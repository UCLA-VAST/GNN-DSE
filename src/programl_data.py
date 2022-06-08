from config import FLAGS
from saver import saver
from utils import get_root_path, MLP, print_stats, get_save_path, \
    create_dir_if_not_exists, plot_dist
from result import Result    

from os.path import join, basename
from glob import glob, iglob

from math import ceil

from sklearn.preprocessing import OneHotEncoder
from torch_geometric.data import Data, Batch

import networkx as nx
import redis, pickle, random
import numpy as np
from collections import Counter, defaultdict, OrderedDict

from scipy.sparse import hstack

from tqdm import tqdm

import os.path as osp

import torch
from torch_geometric.data import Dataset


from shutil import rmtree
import pandas as pd
import math


NON_OPT_PRAGMAS = ['LOOP_TRIPCOUNT', 'INTERFACE', 'INTERFACE', 'KERNEL']
WITH_VAR_PRAGMAS = ['DEPENDENCE', 'RESOURCE', 'STREAM', 'ARRAY_PARTITION']
TARGET = ['perf', 'util-DSP', 'util-BRAM', 'util-LUT', 'util-FF']

SAVE_DIR = join(get_save_path(), FLAGS.dataset, f'new-train-{FLAGS.task}_with-invalid_{FLAGS.invalid}-normalization_{FLAGS.norm_method}_no_pragma_{FLAGS.no_pragma}_tag_{FLAGS.tag}_{"".join(TARGET)}')
ENCODER_PATH = join(SAVE_DIR, 'encoders')
create_dir_if_not_exists(SAVE_DIR)

DATASET = 'machsuite-poly'
if DATASET == 'machsuite-poly':
    KERNEL = FLAGS.tag
    db_path = []
    for benchmark in FLAGS.benchmarks:
        db_path.append(f'../dse_database/{benchmark}/databases/**/*')
else:
    raise NotImplementedError()
    

if FLAGS.dataset == 'programl':
    GEXF_FOLDER = join(get_root_path(), 'dse_database', 'programl', '**', 'processed', '**')
else:
    raise NotImplementedError()

import config
TARGETS = config.TARGETS
MACHSUITE_KERNEL = config.MACHSUITE_KERNEL
poly_KERNEL = config.poly_KERNEL



ALL_KERNEL = MACHSUITE_KERNEL + poly_KERNEL

if FLAGS.all_kernels:
    GEXF_FILES = sorted([f for f in iglob(GEXF_FOLDER, recursive=True) if f.endswith('.gexf')])
else:
    GEXF_FILES = sorted([f for f in iglob(GEXF_FOLDER, recursive=True) if f.endswith('.gexf') and KERNEL in f])

def finte_diff_as_quality(new_result: Result, ref_result: Result) -> float:
    """Compute the quality of the point by finite difference method.

    Args:
        new_result: The new result to be qualified.
        ref_result: The reference result.

    Returns:
        The quality value (negative finite differnece). Larger the better.
    """

    def quantify_util(result: Result) -> float:
        """Quantify the resource utilization to a float number.

        util' = 5 * ceil(util / 5) for each util,
        area = sum(2^1(1/(1-util))) for each util'

        Args:
            result: The evaluation result.

        Returns:
            The quantified area value with the range (2*N) to infinite,
            where N is # of resources.
        """

        # Reduce the sensitivity to (100 / 5) = 20 intervals
        utils = [
            5 * ceil(u * 100 / 5) / 100 + FLAGS.epsilon for k, u in result.res_util.items()
            if k.startswith('util')
        ]

        # Compute the area
        return sum([2.0**(1.0 / (1.0 - u)) for u in utils])

    ref_util = quantify_util(ref_result)
    new_util = quantify_util(new_result)

    # if (new_result.perf / ref_result.perf) > 1.05:
    #     # Performance is too worse to be considered
    #     return -float('inf')

    if new_util == ref_util:
        if new_result.perf < ref_result.perf:
            # Free lunch
            # return float('inf')
            return FLAGS.max_number
        # Same util but slightly worse performance, neutral
        return 0

    return -(new_result.perf - ref_result.perf) / (new_util - ref_util)
    
class MyOwnDataset(Dataset):
    def __init__(self, transform=None, pre_transform=None):
        super(MyOwnDataset, self).__init__(SAVE_DIR, transform, pre_transform)

    @property
    def raw_file_names(self):
        # return ['some_file_1', 'some_file_2', ...]
        return []

    @property
    def processed_file_names(self):
        # return ['data_1.pt', 'data_2.pt', ...]
        rtn = glob(join(SAVE_DIR, '*.pt'))
        return rtn

    def download(self):
        pass

    # Download to `self.raw_dir`.

    def process(self):
        # i = 0
        # for raw_path in self.raw_paths:
        #     # Read data from `raw_path`.
        #     data = Data(...)
        #
        #     if self.pre_filter is not None and not self.pre_filter(data):
        #         continue
        #
        #     if self.pre_transform is not None:
        #         data = self.pre_transform(data)
        #
        #     torch.save(data, osp.join(self.processed_dir, 'data_{}.pt'.format(i)))
        #     i += 1
        pass

    def len(self):
        return len(self.processed_file_names)

    def __len__(self):
        return self.len()

    def get(self, idx):
        data = torch.load(osp.join(SAVE_DIR, 'data_{}.pt'.format(idx)))
        return data



def get_data_list():
    # base_csv = pd.read_csv(join(get_root_path(), 'dse_database', 'databases', 'base.csv'))
    # name_cycle_map = dict(zip(base_csv.Kernel_name, base_csv.CYCLE))
    saver.log_info(f'Found {len(GEXF_FILES)} gexf files under {GEXF_FOLDER}')
    # create a redis database
    database = redis.StrictRedis(host='localhost', port=6379)

    ntypes = Counter()
    ptypes = Counter()
    numerics = Counter()
    itypes = Counter()
    ftypes = Counter()
    btypes = Counter()
    ptypes_edge = Counter()
    ftypes_edge = Counter()
    
    if FLAGS.encoder_path != None:
        encoders = load(FLAGS.encoder_path)
        enc_ntype = encoders['enc_ntype']
        enc_ptype = encoders['enc_ptype']
        enc_itype = encoders['enc_itype']
        enc_ftype = encoders['enc_ftype']
        enc_btype = encoders['enc_btype']
        
        enc_ftype_edge = encoders['enc_ftype_edge']
        enc_ptype_edge = encoders['enc_ptype_edge']

    else:
        ## handle_unknown='ignore' is crucial for handling unknown variables of new kernels
        enc_ntype = OneHotEncoder(handle_unknown='ignore')
        enc_ptype = OneHotEncoder(handle_unknown='ignore')
        enc_itype = OneHotEncoder(handle_unknown='ignore')
        enc_ftype = OneHotEncoder(handle_unknown='ignore')
        enc_btype = OneHotEncoder(handle_unknown='ignore')
        
        enc_ftype_edge = OneHotEncoder(handle_unknown='ignore')
        enc_ptype_edge = OneHotEncoder(handle_unknown='ignore')
    data_list = []

    all_gs = OrderedDict()

    X_ntype_all = []
    X_ptype_all = []
    X_itype_all = []
    X_ftype_all = []
    X_btype_all = []
    
    edge_ftype_all = []
    edge_ptype_all = []
    tot_configs = 0
    num_files = 0
    init_feat_dict = {}
    for gexf_file in tqdm(GEXF_FILES[0:]):  
        if FLAGS.dataset == 'machsuite' or 'programl' in FLAGS.dataset:
            proceed = False
            for k in ALL_KERNEL:
                if k in gexf_file:
                    proceed = True
                    break
            if not proceed:
                continue
            # pass
        else:
            raise NotImplementedError()

        g = nx.read_gexf(gexf_file)
        g.variants = OrderedDict()
        gname = basename(gexf_file).split('.')[0]
        saver.log_info(gname)
        all_gs[gname] = g

        n = basename(gexf_file).split('_')[0]
        if FLAGS.dataset == 'programl':
            db_paths = []
            for db_p in db_path:
                paths = [f for f in iglob(db_p, recursive=True) if f.endswith('.db') and n in f] 
                db_paths.extend(paths)
            if db_paths is None:
                saver.warning(f'No database found for {n}. Skipping.')
                continue
        else:
            raise NotImplementedError()

        database.flushdb()
        saver.log_info(f'db_paths for {n}:')
        for d in db_paths:
            saver.log_info(f'{d}')
        if len(db_paths) == 0:
            saver.log_info(f'{n} has no db_paths')

        assert len(db_paths) >= 1
        
        # load the database and get the keys
        # the key for each entry shows the value of each of the pragmas in the source file
        for idx, file in enumerate(db_paths):
            f_db = open(file, 'rb')
            data = pickle.load(f_db)
            database.hmset(0, data)
            max_idx = idx + 1
            f_db.close()

        keys = [k.decode('utf-8') for k in database.hkeys(0)]
        lv2_keys = [k for k in keys if 'lv2' in k]
        saver.log_info(f'num keys for {n}: {len(keys)} and lv2 keys: {len(lv2_keys)}')
        
        got_reference = False
        res_reference = 0
        max_perf = 0
        for key in sorted(keys):
            pickle_obj = database.hget(0, key)
            obj = pickle.loads(pickle_obj.replace(b'localdse', b'autodse'))

            if type(obj) is int or type(obj) is dict:
                continue
            if key[0:3] == 'lv1' or obj.perf == 0:#obj.ret_code.name == 'PASS':
                continue
            if obj.perf > max_perf:
                max_perf = obj.perf
                got_reference = True
                res_reference = obj
        if res_reference != 0:
            saver.log_info(f'reference point for {n} is {res_reference.perf}')
        else:
            saver.log_info(f'did not find reference point for {n} with {len(keys)} points')


        for key in sorted(keys):
            pickle_obj = database.hget(0, key)
            obj = pickle.loads(pickle_obj.replace(b'localdse', b'autodse'))
            # try:
            if type(obj) is int or type(obj) is dict:
                continue
            if FLAGS.task == 'regression' and key[0:3] == 'lv1':# or obj.perf == 0:#obj.ret_code.name == 'PASS':
                continue
            if FLAGS.task == 'regression' and not FLAGS.invalid and obj.perf == 0:
                continue
            # print(obj.point)
            xy_dict = _encode_X_dict(
                g, ntypes=ntypes, ptypes=ptypes, itypes=itypes, ftypes=ftypes, btypes = btypes, numerics=numerics, obj=obj)
            edge_dict = _encode_edge_dict(
                g, ftypes=ftypes_edge, ptypes=ptypes_edge)
            

            if FLAGS.task == 'regression':
                for tname in TARGETS:
                    if tname == 'perf':
                        if FLAGS.norm_method == 'log2':
                            y = math.log2(obj.perf + FLAGS.epsilon)
                        elif 'const' in FLAGS.norm_method:
                            y = obj.perf * FLAGS.normalizer
                            if y == 0:
                                y = FLAGS.max_number * FLAGS.normalizer
                            if FLAGS.norm_method == 'const-log2':
                                y = math.log2(y)
                        elif 'speedup' in FLAGS.norm_method:
                            assert obj.perf != 0
                            #assert got_reference == True
                            y = FLAGS.normalizer / obj.perf
                            if obj.perf == 0:
                                y = 0
                            else:
                                y = res_reference.perf / obj.perf
                            # y = obj.perf / res_reference.perf
                            if FLAGS.norm_method == 'speedup-log2':
                                y = math.log2(y)
                        elif FLAGS.norm_method == 'off':
                            y = obj.perf
                        xy_dict['actual_perf'] = torch.FloatTensor(np.array([obj.perf]))
                        xy_dict['kernel_speedup'] = torch.FloatTensor(np.array([math.log2(res_reference.perf / obj.perf)]))
                    
                    elif tname == 'quality':
                        y = finte_diff_as_quality(obj, res_reference)
                        if FLAGS.norm_method == 'log2':
                            y = math.log2(y + FLAGS.epsilon)
                        elif FLAGS.norm_method == 'const':
                            y = y * FLAGS.normalizer
                        elif FLAGS.norm_method == 'off':
                            pass
                    elif 'util' in tname or 'total' in tname:
                        y = obj.res_util[tname]
                    else:
                        raise NotImplementedError()
                    xy_dict[tname] = torch.FloatTensor(np.array([y]))
            elif FLAGS.task == 'class':
                if 'lv1' in key:
                    lv2_key = key.replace('lv1', 'lv2')
                    if lv2_key in keys:
                        continue
                    else:
                        y = 0
                else:
                    y = obj.perf if obj.perf == 0 else 1    
                xy_dict['perf'] = torch.FloatTensor(np.array([y])).type(torch.LongTensor)
            else:
                raise NotImplementedError()


            vname = key

            g.variants[vname] = (xy_dict, edge_dict)
            X_ntype_all += xy_dict['X_ntype']
            X_ptype_all += xy_dict['X_ptype']
            X_itype_all += xy_dict['X_itype']
            X_ftype_all += xy_dict['X_ftype']
            X_btype_all += xy_dict['X_btype']
            
            edge_ftype_all += edge_dict['X_ftype']
            edge_ptype_all += edge_dict['X_ptype']
                

        tot_configs += len(g.variants)
        num_files += 1
        saver.log_info(f'{n} g.variants {len(g.variants)} tot_configs {tot_configs}')
        saver.log_info(f'\tntypes {len(ntypes)}')
        saver.log_info(f'\tptypes {len(ptypes)} {ptypes}')
        saver.log_info(f'\tnumerics {len(numerics)} {numerics}')

    if FLAGS.encoder_path == None:
        enc_ptype.fit(X_ptype_all)
        enc_ntype.fit(X_ntype_all)
        enc_itype.fit(X_itype_all)
        enc_ftype.fit(X_ftype_all)
        enc_btype.fit(X_btype_all)
        
        enc_ftype_edge.fit(edge_ftype_all)
        enc_ptype_edge.fit(edge_ptype_all)

        saver.log_info(f'Done {num_files} files tot_configs {tot_configs}')
        saver.log_info(f'\tntypes {len(ntypes)}')
        saver.log_info(f'\tptypes {len(ptypes)} {ptypes}')
        saver.log_info(f'\tnumerics {len(numerics)} {numerics}')

    for gname, g in all_gs.items():
        edge_index = create_edge_index(g)
        saver.log_info('edge_index created', gname)
        for vname, d in g.variants.items():
            d_node, d_edge = d
            X = _encode_X_torch(d_node, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype)
            edge_attr = _encode_edge_torch(d_edge, enc_ftype_edge, enc_ptype_edge)

            if FLAGS.task == 'regression':
                data_list.append(Data(
                    x=X,
                    edge_index=edge_index,
                    perf=d_node['perf'],
                    actual_perf=d_node['actual_perf'],
                    kernel_speedup=d_node['kernel_speedup'], # base is different per kernel
                    quality=d_node['quality'],
                    util_BRAM=d_node['util-BRAM'],
                    util_DSP=d_node['util-DSP'],
                    util_LUT=d_node['util-LUT'],
                    util_FF=d_node['util-FF'],
                    total_BRAM=d_node['total-BRAM'],
                    total_DSP=d_node['total-DSP'],
                    total_LUT=d_node['total-LUT'],
                    total_FF=d_node['total-FF'],
                    edge_attr=edge_attr,
                    kernel=gname
                ))
            elif FLAGS.task == 'class':
                data_list.append(Data(
                    x=X,
                    edge_index=edge_index,
                    perf=d_node['perf'],
                    edge_attr=edge_attr,
                    kernel=gname
                ))
            else:
                raise NotImplementedError()


    nns = [d.x.shape[0] for d in data_list]
    print_stats(nns, 'number of nodes')
    ads = [d.edge_index.shape[1] / d.x.shape[0] for d in data_list]
    print_stats(ads, 'avg degrees')
    saver.log_info('dataset[0].num_features', data_list[0].num_features)
    for target in TARGETS:
        if not hasattr(data_list[0], target.replace('-', '_')):
            saver.warning(f'Data does not have attribute {target}')
            continue
        ys = [_get_y(d, target).item() for d in data_list]
        # if target == 'quality':
        #     continue
        plot_dist(ys, f'{target}_ys', saver.get_log_dir(), saver=saver, analyze_dist=True, bins=None)
        saver.log_info(f'{target}_ys', Counter(ys))

    if FLAGS.force_regen:
        saver.log_info(f'Saving {len(data_list)} to disk {SAVE_DIR}; Deleting existing files')
        rmtree(SAVE_DIR)
        create_dir_if_not_exists(SAVE_DIR)
        for i in tqdm(range(len(data_list))):
            torch.save(data_list[i], osp.join(SAVE_DIR, 'data_{}.pt'.format(i)))

    if FLAGS.force_regen:
        from utils import save
        obj = {'enc_ntype': enc_ntype, 'enc_ptype': enc_ptype,
            'enc_itype': enc_itype, 'enc_ftype': enc_ftype,
            'enc_btype': enc_btype, 
            'enc_ftype_edge': enc_ftype_edge, 'enc_ptype_edge': enc_ptype_edge}

        save(obj, ENCODER_PATH)
        save(init_feat_dict, join(SAVE_DIR, 'pragma_dim'))
        
        for gname, feat_dim in init_feat_dict.items():
            saver.log_info(f'{gname} has initial dim {feat_dim}')


    rtn = MyOwnDataset()
    return rtn, init_feat_dict


def _get_y(data, target):
    return getattr(data, target.replace('-', '_'))

def print_data_stats(data_loader, tvt):
    nns, ads, ys = [], [], []
    for d in tqdm(data_loader):
        nns.append(d.x.shape[0])
        # ads.append(d.edge_index.shape[1] / d.x.shape[0])
        ys.append(d.y.item())
    print_stats(nns, f'{tvt} number of nodes')
    # print_stats(ads, f'{tvt} avg degrees')
    plot_dist(ys, f'{tvt} ys', saver.get_log_dir(), saver=saver, analyze_dist=True, bins=None)
    saver.log_info(f'{tvt} ys', Counter(ys))


def load_all_gs(remove_all_pragma_nodes):
    rtn = []
    for gexf_file in tqdm(GEXF_FILES[0:]):  # TODO: change for partial/full data
        g = nx.read_gexf(gexf_file)
        rtn.append(g)
        if remove_all_pragma_nodes:
            before = g.number_of_nodes()
            nodes_to_remove = []
            for node, ndata in g.nodes(data=True):
                if 'pragma' in ndata['full_text']:
                    nodes_to_remove.append(node)
            g.remove_nodes_from(nodes_to_remove)
            print(f'Removed {len(nodes_to_remove)} pragma nodes;'
                  f' before {before} now {g.number_of_nodes}')
    return rtn


def load_encoders():
    from utils import load
    rtn = load(ENCODER_PATH)
    return rtn


def encode_g_torch(g, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype):
    x_dict = _encode_X_dict(g, ntypes=None, ptypes=None, numerics=None, itypes=None, eftypes=None, btypes=None, obj=None)

    X = _encode_X_torch(x_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype)

    edge_index = create_edge_index(g)

    return X, edge_index


def _encode_X_dict(g, ntypes=None, ptypes=None, numerics=None, itypes=None, ftypes=None, btypes=None, obj=None):
    X_ntype = [] # node type <attribute id="3" title="type" type="long" />
    X_ptype = [] # pragma type
    X_numeric = []
    X_itype = [] # instruction type (text) <attribute id="2" title="text" type="string" />
    X_ftype = [] # function type <attribute id="1" title="function" type="long" />
    X_btype = [] # block type <attribute id="0" title="block" type="long" />
    
    
      
    for node, ndata in g.nodes(data=True):  # TODO: node ordering
        # print(node['type'], type(node['type']))
        if ntypes is not None:
            ntypes[ndata['type']] += 1

        numeric = 0

        if 'full_text' in ndata and 'pragma' in ndata['full_text']:
            # print(ndata['content'])
            p_text = ndata['full_text'].rstrip()
            assert p_text[0:8] == '#pragma '
            p_text_type = p_text[8:].upper()

            if _check_any_in_str(NON_OPT_PRAGMAS, p_text_type):
                p_text_type = 'None'
            else:
                if _check_any_in_str(WITH_VAR_PRAGMAS, p_text_type):
                    # HLS DEPENDENCE VARIABLE=CSIYIY ARRAY INTER FALSE
                    # HLS DEPENDENCE VARIABLE=<> ARRAY INTER FALSE
                    t_li = p_text_type.split(' ')
                    for i in range(len(t_li)):
                        if 'VARIABLE=' in t_li[i]:
                            t_li[i] = 'VARIABLE=<>'
                        elif 'DEPTH=' in t_li[i]:
                            t_li[i] = 'DEPTH=<>'  # TODO: later add back
                        elif 'DIM=' in t_li[i]:
                            numeric = int(t_li[i][4:])
                            t_li[i] = 'DIM=<>'
                        elif 'LATENCY=' in t_li[i]:
                            numeric = int(t_li[i][8:])
                            t_li[i] = 'LATENCY=<>'
                    p_text_type = ' '.join(t_li)

                if obj is not None:
                    t_li = p_text_type.split(' ')
                    for i in range(len(t_li)):
                        if 'AUTO{' in t_li[i]:
                            # print(t_li[i])
                            auto_what = _in_between(t_li[i], '{', '}')
                            numeric = obj.point[auto_what]
                            if type(numeric) is not int:
                                t_li[i] = numeric
                                numeric = 0  # TODO: ? '', 'off', 'flatten'
                            else:
                                t_li[i] = 'AUTO{<>}'
                            break
                    p_text_type = ' '.join(t_li)
                else:
                    assert 'AUTO' not in p_text_type
                # t = ' '.join(t.split(' ')[0:2])
            # print('@@@@@', t)
            ptype = p_text_type
        else:
            ptype = 'None'
        if ptypes is not None:
            ptypes[ptype] += 1
        if numerics is not None:
            numerics[numeric] += 1

        X_ntype.append([ndata['type']])
        X_ptype.append([ptype])
        X_numeric.append([numeric])
        X_itype.append([ndata['text']])
        X_ftype.append([ndata['function']])
        X_btype.append([ndata['block']])
        
    # vname = key

    return {'X_ntype': X_ntype, 'X_ptype': X_ptype,
            'X_numeric': X_numeric, 'X_itype': X_itype,
            'X_ftype': X_ftype, 'X_btype': X_btype}


def _encode_X_torch(x_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype):
    """
    x_dict is the returned dict by _encode_X_dict()
    """
    X_ntype = enc_ntype.transform(x_dict['X_ntype'])
    X_ptype = enc_ptype.transform(x_dict['X_ptype'])
    X_itype = enc_itype.transform(x_dict['X_itype'])
    X_ftype = enc_ftype.transform(x_dict['X_ftype'])
    X_btype = enc_btype.transform(x_dict['X_btype'])

    X_numeric = x_dict['X_numeric']
    if FLAGS.no_pragma:
        X = X_ntype
        X = X.toarray()
        X = torch.FloatTensor(X)
    else:
        X = hstack((X_ntype, X_ptype, X_numeric, X_itype, X_ftype, X_btype))
        X = _coo_to_sparse(X)
        X = X.to_dense()

    return X




def _encode_edge_dict(g, ftypes=None, ptypes=None):
    X_ftype = [] # flow type <attribute id="5" title="flow" type="long" />
    X_ptype = [] # position type <attribute id="6" title="position" type="long" />    
      
    for nid1, nid2, edata in g.edges(data=True):  # TODO: node ordering
        X_ftype.append([edata['flow']])
        X_ptype.append([edata['position']])

    return {'X_ftype': X_ftype, 'X_ptype': X_ptype}

    
def _encode_edge_torch(edge_dict, enc_ftype, enc_ptype):
    """
    edge_dict is the dictionary returned by _encode_edge_dict
    """
    X_ftype = enc_ftype.transform(edge_dict['X_ftype'])
    X_ptype = enc_ptype.transform(edge_dict['X_ptype'])

    X = hstack((X_ftype, X_ptype))
    X = _coo_to_sparse(X)
    X = X.to_dense()

    return X
        

def _in_between(text, left, right):
    # text = 'I want to find a string between two substrings'
    # left = 'find a '
    # right = 'between two'
    return text[text.index(left) + len(left):text.index(right)]


def _check_any_in_str(li, s):
    for li_item in li:
        if li_item in s:
            return True
    return False


def create_edge_index(g):
    g = nx.convert_node_labels_to_integers(g, ordering='sorted')
    edge_index = torch.LongTensor(list(g.edges)).t().contiguous()
    return edge_index


def _coo_to_sparse(coo):
    values = coo.data
    indices = np.vstack((coo.row, coo.col))

    i = torch.LongTensor(indices)
    v = torch.FloatTensor(values)
    shape = coo.shape

    rtn = torch.sparse.FloatTensor(i, v, torch.Size(shape))
    return rtn


def _check_prune_non_pragma_nodes(g):
    if FLAGS.only_pragma:
        to_remove = []
        for node, ndata in g.nodes(data=True):
            x = ndata.get('full_text')
            if x is None:
                x = ndata['type']
            if type(x) is not str or (not 'Pragma' in x and not 'pragma' in x):
                to_remove.append(node)
        before = g.number_of_nodes()
        g.remove_nodes_from(to_remove)
        saver.log_info(f'Removed {len(to_remove)} non-pragma nodes from G -'
                       f'- {before} to {g.number_of_nodes()}')
        assert g.number_of_nodes() + len(to_remove) == before
    return g

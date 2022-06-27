from config import FLAGS
from saver import saver
from utils import MLP, load, get_save_path, argsort, get_root_path, get_src_path, \
     _get_y_with_target, _get_y
from programl_data import print_data_stats, _check_any_in_str, NON_OPT_PRAGMAS, WITH_VAR_PRAGMAS, \
    _in_between, _encode_edge_dict, _encode_edge_torch, _encode_X_torch, create_edge_index
from model import Net
from parameter import DesignSpace, DesignPoint, DesignParameter, get_default_point, topo_sort_param_ids, compile_design_space, gen_key_from_design_point
from config_ds import build_config
from result import Result

from enum import Enum
import json
import os
from math import ceil, inf, exp, log2
import math
from os.path import join
import time
import torch
from torch_geometric.data import Data, DataLoader
from logging import Logger
from typing import Deque, Dict, List, Optional, Set, Union, Generator, Any
import sys
from tqdm import tqdm
import networkx as nx
from collections import OrderedDict
from glob import glob, iglob
import pickle
from copy import deepcopy
import redis
from subprocess import Popen, DEVNULL, PIPE

import random
from pprint import pprint

SAVE_DIR = join(get_root_path(), f'models')
SAVE_DIR_CLASS = join(get_root_path(), f'models')

        
        
        
class GNNModel():
    def __init__(self, path, saver, multi_target = True, task = 'regression', num_layers = FLAGS.num_layers, D = FLAGS.D, target = FLAGS.target, model_name = f'{FLAGS.model_tag}_model_state_dict.pth', encoder_name = 'encoders'):
        """
        >>> self.encoder.keys()
        dict_keys(['enc_ntype', 'enc_ptype', 'enc_itype', 'enc_ftype', 'enc_btype', 'enc_ftype_edge', 'enc_ptype_edge'])

        """
        model_name = f'{task}_model_state_dict.pth'
        self.log = saver
        self.path = path
        if task == 'regression':
            if FLAGS.model_path == None:
                self.model_path = join(self.path, model_name)
            else:
                self.model_path = FLAGS.model_path
        else:
            if FLAGS.class_model_path == None:
                self.model_path = join(self.path, model_name)
            else:
                self.model_path = FLAGS.class_model_path
        if FLAGS.encoder_path == None:
            self.encoder_path = join(self.path, encoder_name)
        else:
            self.encoder_path = FLAGS.encoder_path
        self.num_features = FLAGS.num_features # 124
        self.model = Net(in_channels = self.num_features, task = task, num_layers = num_layers, D = D, target = target).to(FLAGS.device)

        self.model.load_state_dict(torch.load(join(self.model_path), map_location=torch.device('cpu')))
        saver.info(f'loaded {self.model_path}')
        self.encoder = load(self.encoder_path)

          
    
    def encode_node(self, g, point: DesignPoint): ## prograML graph
        X_ntype = [] # node type <attribute id="3" title="type" type="long" />
        X_ptype = [] # pragma type
        X_numeric = []
        X_itype = [] # instruction type (text) <attribute id="2" title="text" type="string" />
        X_ftype = [] # function type <attribute id="1" title="function" type="long" />
        X_btype = [] # block type <attribute id="0" title="block" type="long" />
    
      
        for node, ndata in g.nodes(data=True):  # TODO: node ordering
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

                    if point is not None:
                        t_li = p_text_type.split(' ')
                        for i in range(len(t_li)):
                            if 'AUTO{' in t_li[i]:
                                # print(t_li[i])
                                auto_what = _in_between(t_li[i], '{', '}')
                                numeric = point[auto_what]
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

            X_ntype.append([ndata['type']])
            X_ptype.append([ptype])
            X_numeric.append([numeric])
            X_itype.append([ndata['text']])
            X_ftype.append([ndata['function']])
            X_btype.append([ndata['block']])
            

        node_dict =  {'X_ntype': X_ntype, 'X_ptype': X_ptype,
                'X_numeric': X_numeric, 'X_itype': X_itype,
                'X_ftype': X_ftype, 'X_btype': X_btype}
        
        enc_ntype = self.encoder['enc_ntype']
        enc_ptype = self.encoder['enc_ptype']
        enc_itype = self.encoder['enc_itype']
        enc_ftype = self.encoder['enc_ftype']
        enc_btype = self.encoder['enc_btype']
        
        return _encode_X_torch(node_dict, enc_ntype, enc_ptype, enc_itype, enc_ftype, enc_btype)
        
        
    def encode_edge(self, g):
        edge_dict = _encode_edge_dict(g)
        enc_ptype_edge = self.encoder['enc_ptype_edge']
        enc_ftype_edge = self.encoder['enc_ftype_edge']
        
        return _encode_edge_torch(edge_dict, enc_ftype_edge, enc_ptype_edge)
    
    def perf_as_quality(self, new_result: Result) -> float:
        """Compute the quality of the point by (1 / latency).

        Args:
            new_result: The new result to be qualified.

        Returns:
            The quality value. Larger the better.
        """
        return 1.0 / new_result.perf

    def finte_diff_as_quality(self, new_result: Result, ref_result: Result) -> float:
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
                5 * ceil(u * 100 / 5) / 100 for k, u in result.res_util.items()
                if k.startswith('util')
            ]

            # Compute the area
            return sum([2.0**(1.0 / (1.0 - u)) for u in utils])

        ref_util = quantify_util(ref_result)
        new_util = quantify_util(new_result)

        if (new_result.perf / ref_result.perf) > 1.05:
            # Performance is too worse to be considered
            return -float('inf')

        if new_util == ref_util:
            if new_result.perf < ref_result.perf:
                # Free lunch
                return float('inf')
            # Same util but slightly worse performance, neutral
            return 0

        return -(new_result.perf - ref_result.perf) / (new_util - ref_util)

    def eff_as_quality(self, new_result: Result, ref_result: Result) -> float:
        """Compute the quality of the point by resource efficiency.

        Args:
            new_result: The new result to be qualified.
            ref_result: The reference result.

        Returns:
            The quality value (negative finite differnece). Larger the better.
        """
        if (new_result.perf / ref_result.perf) > 1.05:
            # Performance is too worse to be considered
            return -float('inf')

        area = sum([u for k, u in new_result.res_util.items() if k.startswith('util')])

        return 1 / (new_result.perf * area)
    
    def test(self, loader, config, mode = 'regression'):
        self.model.eval()

        i = 0
        results: List[Result] = []
        target_list = FLAGS.target
        if not isinstance(FLAGS.target, list):
            target_list = [FLAGS.target]

        for data in loader:
            data = data.to(FLAGS.device)
            out_dict, loss, loss_dict = self.model(data)
            
            if mode == 'regression':
                for i in range(len(out_dict['perf'])):
                    curr_result = Result()
                    curr_result.point = data[i].point
                    for target_name in target_list:
                        out = out_dict[target_name]
                        out_value = out[i].item()
                        if target_name == 'perf':
                            curr_result.perf = out_value
                            if FLAGS.encode_log:
                                curr_result.actual_perf = 2**out_value
                            else:
                                curr_result.actual_perf = out_value
                        elif target_name in curr_result.res_util.keys():
                            curr_result.res_util[target_name] = out_value
                        else:
                            raise NotImplementedError()
                    curr_result.quality = self.perf_as_quality(curr_result)
                    
                    # prune if over-utilizes the board
                    max_utils = config['max-util']
                    utils = {k[5:]: max(0.0, u) for k, u in curr_result.res_util.items() if k.startswith('util-')}
                    if FLAGS.prune_util:
                        curr_result.valid = all([utils[res] < max_utils[res] for res in max_utils])
                    else:
                        curr_result.valid = True
                    results.append(curr_result)
            elif mode == 'class':
                _, pred = torch.max(out_dict['perf'], 1)
                labels = _get_y_with_target(data, 'perf') 
                # saver.debug(f'pred: {pred}, labels: {labels}')
                return (pred == labels)
            else:
                raise NotImplementedError()
                    

        return results
  
  
        
class Explorer():
    def __init__(self, path_kernel: str, kernel_name: str, path_graph: str, run_dse: bool = True, prune_invalid = False):
        """Constructor.

        Args:
            ds: DesignSpace
        """
        self.run_dse = run_dse
        self.log = saver
        self.kernel_name = kernel_name
        self.config_path = join(path_kernel, f'{kernel_name}_ds_config.json')
        self.config = self.load_config()
        # self.timeout = self.config['timeout']['exploration']
        # self.timeout = float(inf)
        self.timeout = 60 * 60
        self.ds, self.ds_size = compile_design_space(
            self.config['design-space']['definition'],
            None,
            self.log)

        self.batch_size = 1
        # Status checking
        self.num_top_designs = 10
        self.key_perf_dict = OrderedDict()
        self.best_results_dict = {}
        self.best_result: Result = Result()
        self.explored_point = 0
        self.ordered_pids = self.topo_sort_param_ids(self.ds)
        # self.ordered_pids = FLAGS.ordered_pids
        
        self.GNNmodel = GNNModel(SAVE_DIR, self.log, multi_target=True, task='regression', num_layers = FLAGS.num_layers, D = FLAGS.D)
        if FLAGS.separate_perf:
            perf_target = ['perf', 'util-LUT', 'util-FF', 'util-DSP']
            self.GNNmodel_perf = GNNModel(SAVE_DIR, self.log, multi_target=True, task='regression_perf', num_layers = 8, D = 64, target = perf_target)

        gexf_file = sorted([f for f in glob(path_graph + "/*") if f.endswith('.gexf') and kernel_name in f])
        # print(gexf_file, glob(path_graph))
        assert len(gexf_file) == 1
        # self.graph_path = join(path_graph, f'{kernel_name}_processed_result.gexf')
        self.graph_path = join(path_graph, gexf_file[0])
        self.graph = nx.read_gexf(self.graph_path)
        
        self.prune_invalid = prune_invalid
        if self.prune_invalid:
            self.GNNmodel_valid = GNNModel(SAVE_DIR_CLASS, self.log, multi_target=False, task='class', num_layers = FLAGS.num_layers, D = FLAGS.D)
        
        
    def load_config(self) -> Dict[str, Any]:
        """Load the DSE configurations.

        Returns:
            A dictionary of configurations.
        """

        try:
            if not os.path.exists(self.config_path):
                self.log.error(('Config JSON file not found: %s', self.config_path))
                raise RuntimeError()

            self.log.info('Loading configurations')
            with open(self.config_path, 'r', errors='replace') as filep:
                try:
                    user_config = json.load(filep)
                except ValueError as err:
                    self.log.error(('Failed to load config: %s', str(err)))
                    raise RuntimeError()

            config = build_config(user_config, self.log)
            if config is None:
                self.log.error(('Config %s is invalid', self.config_path))
                raise RuntimeError()
        except RuntimeError:
            sys.exit(1)

        return config
        

    def apply_design_point(self, g, point: DesignPoint, mode = 'regression') -> Data:
        X = self.GNNmodel.encode_node(g, point)
        edge_attr = self.GNNmodel.encode_edge(g)
        edge_index = create_edge_index(g)

        d_node = dict()
        resources = ['BRAM', 'DSP', 'LUT', 'FF']
        keys = ['perf', 'actual_perf', 'quality']
        for r in resources:
            keys.append('util-' + r)
            keys.append('total-' + r)
        for key in keys:
            d_node[key] = 0
        if mode == 'class': ## default: point is valid
            d_node['perf'] = 1
        
        if 'regression' in mode:    
            data = Data(
                x=X,
                edge_index=edge_index,
                perf=d_node['perf'],
                actual_perf=d_node['actual_perf'],
                quality=d_node['quality'],
                util_BRAM=d_node['util-BRAM'],
                util_DSP=d_node['util-DSP'],
                util_LUT=d_node['util-LUT'],
                util_FF=d_node['util-FF'],
                total_BRAM=d_node['total-BRAM'],
                total_DSP=d_node['total-DSP'],
                total_LUT=d_node['total-LUT'],
                total_FF=d_node['total-FF'],
                point=point,
                edge_attr=edge_attr
            )
        elif mode == 'class':
            data = Data(
                x=X,
                edge_index=edge_index,
                perf=d_node['perf'],
                edge_attr=edge_attr,
                kernel=self.kernel_name
            )
        else:
            raise NotImplementedError()
        
        return data
    
    

    def update_best(self, result: Result) -> None:
        """Keep tracking the best result found in this explorer.

        Args:
            result: The new result to be checked.

        """
        # if result.valid and result.quality > self.best_result.quality:
        if 'speedup' in FLAGS.norm_method:
            REF = min
        else:
            REF = max
        if self.key_perf_dict:
            key_refs_perf = REF(self.key_perf_dict, key=(lambda key: self.key_perf_dict[key]))
            refs_perf = self.key_perf_dict[key_refs_perf]
        else:
            if REF == min:
                refs_perf = float(-inf)
            else:
                refs_perf = float(inf)
        point_key = gen_key_from_design_point(result.point)
        if point_key not in self.key_perf_dict and result.valid and REF(result.perf, refs_perf) != result.perf: # if the new result is better than the references designs
            self.best_result = result
            self.log.info(('Found a better result at {}: Quality {:.1e}, Perf {:.1e}'.format(
                        self.explored_point, result.quality, result.perf)))
            if len(self.key_perf_dict.keys()) >= self.num_top_designs:
                ## replace maxmimum performance value
                key_refs_perf = REF(self.key_perf_dict, key=(lambda key: self.key_perf_dict[key]))
                self.best_results_dict.pop((self.key_perf_dict[key_refs_perf], key_refs_perf))
                self.key_perf_dict.pop(key_refs_perf)
                
            attrs = vars(result)
            self.log.info(', '.join("%s: %s" % item for item in attrs.items()))
            
            self.key_perf_dict[point_key] = result.perf
            self.best_results_dict[(result.perf, point_key)] = result
        
        if self.key_perf_dict.values():
            reward = REF([-p for p in self.key_perf_dict.values()])  
            return reward 
        else:
            return 0

    def gen_options(self, point: DesignPoint, pid: str, default = False) -> List[Union[int, str]]:
        """Evaluate available options of the target design parameter.

        Args:
            point: The current design point.
            pid: The target design parameter ID.

        Returns:
            A list of available options.
        """
        if default:
            dep_values = {dep: point[dep].default for dep in self.ds[pid].deps}
        else:
            dep_values = {dep: point[dep] for dep in self.ds[pid].deps}
        dep_values = {dep: point[dep] for dep in self.ds[pid].deps}
        options = eval(self.ds[pid].option_expr, dep_values)
        if options is None:
            self.log.error(f'Failed to evaluate {self.ds[pid].option_expr} with dep {str(dep_values)}')
            print('Error: failed to manipulate design points')
            sys.exit(1)

        return options

    def get_order(self, point: DesignPoint, pid: str) -> int:
        """Evaluate the order of the current value.

        Args:
            point: The current design point.
            pid: The target design parameter ID.

        Returns:
            The order.
        """

        if not self.ds[pid].order:
            return 0

        order = eval(self.ds[pid].order['expr'], {self.ds[pid].order['var']: point[pid]})
        if order is None or not isinstance(order, int):
            self.log.warning(f'Failed to evaluate the order of {pid} with value {str(point[pid])}: {str(order)}')
            return 0

        return order

    def update_child(self, point: DesignPoint, pid: str) -> None:
        """Check values of affect parameters and update them in place if it is invalid.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.
        """

        pendings = [child for child in self.ds[pid].child if self.validate_value(point, child)]
        for child in pendings:
            self.update_child(point, child)

    def validate_point(self, point: DesignPoint) -> bool:
        """Check if the current point is valid and set it to the closest value if not.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.

        Returns:
            True if the value is changed.
        """

        changed = False
        for pid in point.keys():
            options = self.gen_options(point, pid)
            value = point[pid]
            if not options:  # All invalid (something not right), set to default
                self.log.warning(f'No valid options for {pid} with point {str(point)}')
                point[pid] = self.ds[pid].default
                changed = True
                continue

            if isinstance(value, int):
                # Note that we assume all options have the same type (int or str)
                cand = min(options, key=lambda x: abs(int(x) - int(value)))
                if cand != value:
                    point[pid] = cand
                    changed = True
                    continue

            if value not in options:
                point[pid] = self.ds[pid].default
                changed = True
                continue

        return changed
    
    def validate_value(self, point: DesignPoint, pid: str) -> bool:
        """Check if the current value is valid and set it to the closest value if not.

        Args:
            point: The current design point.
            pid: The design parameter ID that just be changed.

        Returns:
            True if the value is changed.
        """

        options = self.gen_options(point, pid)
        value = point[pid]
        if not options:  # All invalid (something not right), set to default
            self.log.warning(f'No valid options for {pid} with point {str(point)}')
            point[pid] = self.ds[pid].default
            return False

        if isinstance(value, int):
            # Note that we assume all options have the same type (int or str)
            cand = min(options, key=lambda x: abs(int(x) - int(value)))
            if cand != value:
                point[pid] = cand
                return True

        if value not in options:
            point[pid] = self.ds[pid].default
            return True
        return False

    def move_by(self, point: DesignPoint, pid: str, step: int = 1) -> int:
        """Move N steps of pid parameter's value in a design point in place.

        Args:
            point: The design point to be manipulated.
            pid: The target design parameter.
            step: The steps to move. Note that step can be positive or negatie,
                  but we will not move cirulatory even the step is too large.

        Returns:
            The actual move steps.
        """

        try:
            options = self.gen_options(point, pid)
            idx = options.index(point[pid])
        except (AttributeError, ValueError) as err:
            self.log.error(
                f'Fail to identify the index of value {point[pid]} of parameter {pid} at design point {str(point)}: {str(err)}')
            print('Error: failed to manipulate design points')
            sys.exit(1)

        target = idx + step
        if target >= len(options):
            target = len(options) - 1
        elif target < 0:
            target = 0

        if target != idx:
            point[pid] = options[target]
            self.update_child(point, pid)
        return target - idx
    
    def get_results(self, next_points: List[DesignPoint]) -> List[Result]:
        data_list = []
        for point in next_points:
            data_list.append(self.apply_design_point(self.graph, point, mode = 'class'))

        test_loader = DataLoader(data_list, batch_size=self.batch_size)  # TODO

        if self.prune_invalid:
            valid = self.GNNmodel_valid.test(test_loader, self.config['evaluate'], mode='class')
            if valid == 0:
                # stop if the point is invalid
                self.log.debug(f'invalid point {point}')
                return [float(inf)] # TODO: add batch processing 
        
        data_list = []
        for point in next_points:
            data_list.append(self.apply_design_point(self.graph, point))

        test_loader = DataLoader(data_list, batch_size=self.batch_size)  # TODO
        results = self.GNNmodel.test(test_loader, self.config['evaluate'], mode='regression')
        
        return results
    
    def topo_sort_param_ids(self, space: DesignSpace) -> List[str]:
        return topo_sort_param_ids(space)
    
    def traverse(self, point: DesignPoint, idx: int) -> Generator[DesignPoint, None, None]:
        """DFS traverse the design space and yield leaf points.

        Args:
            point: The current design point.
            idx: The current manipulated parameter index.

        Returns:
            A resursive generator for traversing.
        """

        if idx == len(self.ordered_pids):
            # Finish a point
            yield point
        else:
            yield from self.traverse(point, idx + 1)

            # Manipulate idx-th point
            new_point = self.clone_point(point)
            while self.move_by(new_point, self.ordered_pids[idx]) == 1:
                yield from self.traverse(new_point, idx + 1)
                new_point = self.clone_point(new_point)
    
    @staticmethod
    def clone_point(point: DesignPoint) -> DesignPoint:
        return dict(point)
    
    def run(self) -> None:
        """The main function of the explorer to launch the search algorithm.

        Args:
            algo_name: The corresponding algorithm name for running this exploration.
            algo_config: The configurable values for the algorithm.
        """
        raise NotImplementedError()
    
    
class ExhaustiveExplorer(Explorer):
    def __init__(self, path_kernel: str, kernel_name: str, path_graph: str, run_dse: bool = True, prune_invalid = FLAGS.prune_class, point: DesignPoint = None):
        """Constructor.

        Args:
            ds: Design space.
        """
        super(ExhaustiveExplorer, self).__init__(path_kernel, kernel_name, path_graph, run_dse, prune_invalid)
        self.batch_size = 1
        self.log.info('Done init')
        
        if self.run_dse:
            self.run()
            attrs = vars(self.best_result)
            self.log.info('Best Results Found:')
            i = 1
            with open(join(saver.logdir, f'{kernel_name}.pickle'), 'wb') as handle:
                pickle.dump(self.best_results_dict, handle, protocol=pickle.HIGHEST_PROTOCOL)
                handle.flush()
            for _, result in sorted(self.best_results_dict.items()):
                attrs = vars(result)
                self.log.info(f'Design {i}')
                self.log.info(', '.join("%s: %s" % item for item in attrs.items()))
                i += 1
        else:
            results = self.get_results([point])
            attrs = vars(results[0])
            self.log.info(', '.join("%s: %s" % item for item in attrs.items()))
                
        
                

    def gen(self) -> Generator[List[DesignPoint], Optional[Dict[str, Result]], None]:
        #pylint:disable=missing-docstring

        self.log.info('Launch exhaustive search algorithm')

        traverser = self.traverse(get_default_point(self.ds), 0)
        iter_cnt = 0
        while True:
            next_points: List[DesignPoint] = []
            try:
                iter_cnt += 1
                self.log.debug(f'Iteration {iter_cnt}')
                while len(next_points) < self.batch_size:
                    next_points.append(next(traverser))
                    self.log.debug(f'Next point: {str(next_points[-1])}')
                yield next_points
            except StopIteration:
                if next_points:
                    yield next_points
                break

        self.log.info('No more points to be explored, stop.')
    
        
    def run(self) -> None:
        #pylint:disable=missing-docstring

        # Create a search algorithm generator
        gen_next = self.gen()

        timer = time.time()
        duplicated_iters = 0
        while (time.time() - timer) < self.timeout:
            try:
                # Generate the next set of design points
                next_points = next(gen_next)
                self.log.debug(f'The algorithm generates {len(next_points)} design points')
            except StopIteration:
                break

            results = self.get_results(next_points)
            for r in results:
                if isinstance(r, Result):
                    attrs = vars(r)
                    self.log.debug(f'Evaluating Design')
                    self.log.debug(', '.join("%s: %s" % item for item in attrs.items()))
                    self.update_best(r)
            self.explored_point += len(results)
            
        self.log.info(f'Explored {self.explored_point} points')
        

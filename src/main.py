from config import FLAGS
from train import train_main, inference
from dse import ExhaustiveExplorer
from saver import saver
import os.path as osp
from utils import get_root_path
from os.path import join


import torch

import config
TARGETS = config.TARGETS
MACHSUITE_KERNEL = config.MACHSUITE_KERNEL
poly_KERNEL = config.poly_KERNEL

class HandleNodeAttention(object):
    def __call__(self, data):
        data.attn = torch.softmax(data.x[:, 0], dim=0)
        data.x = data.x[:, 1:]
        return data

from programl_data import get_data_list, MyOwnDataset

path = osp.join(osp.dirname(osp.realpath(__file__)), '..', 'data', 'COLORS-3')
if not FLAGS.force_regen or FLAGS.subtask == 'dse':
    dataset = MyOwnDataset()
else:
    pragma_dim = 0
    dataset, pragma_dim = get_data_list()


if FLAGS.subtask == 'inference':
    inference(dataset)
elif FLAGS.subtask == 'dse':
    for dataset in ['machsuite', 'poly']:
    # for dataset in ['poly']:
        path = join(get_root_path(), 'dse_database', dataset, 'config')
        path_graph = join(get_root_path(), 'dse_database', 'programl', dataset, 'processed')
        if dataset == 'machsuite':   
            KERNELS = MACHSUITE_KERNEL
        elif dataset == 'poly':
            KERNELS = poly_KERNEL
        else:
            raise NotImplementedError()
        
        point = {'__PARA__L0': 1, '__PARA__L1': 4, '__PARA__L2': 1, '__PIPE__L0': 'off', '__PIPE__L1': 'flatten', '__TILE__L0': 1, '__TILE__L1': 1}
        for kernel in KERNELS:
            # if 'md' not in kernel:
            #     continue
            saver.info('#################################################################')
            saver.info(f'Starting DSE for {kernel}')
            if FLAGS.explorer == 'exhaustive':
                ExhaustiveExplorer(path, kernel, path_graph, run_dse = True, point = point)
            else:
                raise NotImplementedError()
            saver.info('#################################################################')
            saver.info(f'')
else:
    train_main(dataset, 0)


saver.close()
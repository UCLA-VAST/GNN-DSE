from utils import get_user, get_host
import argparse
import torch

TARGETS = ['perf', 'quality', 'util-BRAM', 'util-DSP', 'util-LUT', 'util-FF',
           'total-BRAM', 'total-DSP', 'total-LUT', 'total-FF']
MACHSUITE_KERNEL = ['aes', 'gemm-blocked', 'gemm-ncubed', 'spmv-crs', 'spmv-ellpack', 'stencil', 'nw']
poly_KERNEL = ['2mm', '3mm', 'adi', 'atax', 'bicg', 'doitgen', 
                'mvt', 'fdtd-2d', 'gemver', 'gemm-p', 'gesummv', 
                'heat-3d', 'jacobi-1d', 'jacobi-2d', 'seidel-2d']


parser = argparse.ArgumentParser()

parser.add_argument('--model', default='simple')

dataset = 'programl'
parser.add_argument('--dataset', default=dataset)

benchmark = ['machsuite', 'poly']
parser.add_argument('--benchmarks', default=benchmark)

tag = 'whole-machsuite-poly'
parser.add_argument('--tag', default=tag)

encoder_path = None
parser.add_argument('--encoder_path', default=encoder_path)
model_path = None
parser.add_argument('--model_path', default=model_path)
class_model_path = None
parser.add_argument('--class_model_path', default=class_model_path)
parser.add_argument('--num_features', default=124)

# TASK = 'class'
TASK = 'regression'
parser.add_argument('--task', default=TASK)

# SUBTASK = 'dse'
# SUBTASK = 'inference'
SUBTASK = 'train'
parser.add_argument('--subtask', default=SUBTASK)
parser.add_argument('--val_ratio', type=float, default=0.15) # ratio of database for validation set

explorer = 'exhaustive'
parser.add_argument('--explorer', default=explorer)

model_tag = 'test'
parser.add_argument('--model_tag', default=model_tag)

parser.add_argument('--prune_util', default=True) 
parser.add_argument('--prune_class', default=True)

parser.add_argument('--activation', default='elu')

parser.add_argument('--force_regen', type=bool, default=True)

parser.add_argument('--no_pragma', type=bool, default=False)

pids = ['__PARA__L3', '__PIPE__L2', '__PARA__L1', '__PIPE__L0', '__TILE__L2', '__TILE__L0', '__PARA__L2', '__PIPE__L0']
parser.add_argument('--ordered_pids', default=pids)

multi_target = ['perf', 'util-LUT', 'util-FF', 'util-DSP', 'util-BRAM']
target = 'perf'
parser.add_argument('--target', default=multi_target)

parser.add_argument('--separate_perf', type = bool, default=False )

parser.add_argument('--num_layers', type=int, default=6)  

parser.add_argument('--no_graph', type = bool, default=False )
parser.add_argument('--only_pragma', type = bool, default=False )
# gnn_type = 'gcn'
# gnn_type = 'gat'
gnn_type = 'transformer'
parser.add_argument('--gnn_type', type=str, default=gnn_type)
parser.add_argument('--encode_edge', type=bool, default=False)

parser.add_argument('--loss', type=str, default='RMSE')

# jkn_mode = 'lstm'
jkn_mode = 'max'
parser.add_argument('--jkn_mode', type=str, default=jkn_mode)
parser.add_argument('--jkn_enable', type=bool, default=True)
parser.add_argument('--node_attention', type=bool, default=True)

EPSILON = 1e-3
parser.add_argument('--epsilon', default=EPSILON)
NORMALIZER = 1e7
parser.add_argument('--normalizer', default=NORMALIZER)
# MAX_NUMBER = 3464510.00
MAX_NUMBER = 1e10
parser.add_argument('--max_number', default=MAX_NUMBER)

norm = 'speedup-log2' # 'const' 'log2' 'speedup' 'off' 'speedup-const' 'const-log2' 'none' 'speedup-log2'
parser.add_argument('--norm_method', default=norm)

parser.add_argument('--invalid', type = bool, default=False ) # False: do not include invalid designs

parser.add_argument('--all_kernels', type = bool, default=True)

parser.add_argument('--multi_target', type = bool, default=True)

parser.add_argument('--save_model', type = bool, default=True)

parser.add_argument('--encode_log', type = bool, default=False)

parser.add_argument('--D', type=int, default=64)

batch_size = 64
parser.add_argument('--batch_size', type=int, default=batch_size)

epoch_num = 1000
parser.add_argument('--epoch_num', type=int, default=epoch_num)

gpu = 0
device = str('cuda:{}'.format(gpu) if torch.cuda.is_available() and gpu != -1
             else 'cpu')
parser.add_argument('--device', default=device)

parser.add_argument('--print_every_iter', type=int, default=100)

parser.add_argument('--plot_pred_points', type=bool, default=False)

"""
Other info.
"""
parser.add_argument('--user', default=get_user())

parser.add_argument('--hostname', default=get_host())

FLAGS = parser.parse_args()

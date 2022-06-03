

from config import FLAGS
from saver import saver
from utils import MLP, OurTimer, get_save_path, _get_y_with_target

import torch
import torch.nn.functional as F
from torch_geometric.data import DataLoader
from torch_geometric.nn import GATConv, GlobalAttention, JumpingKnowledge, TransformerConv, GCNConv
from torch_geometric.nn import global_add_pool
import torch.nn as nn
from scipy.stats import rankdata, kendalltau

from nn_att import MyGlobalAttention
from torch.nn import Sequential, Linear, ReLU

from tqdm import tqdm
from os.path import join

from collections import OrderedDict, defaultdict

import pandas as pd


class Net(torch.nn.Module):
    def __init__(self, in_channels, edge_dim = 7, init_pragma_dict = None, task = FLAGS.task, num_layers = FLAGS.num_layers, D = FLAGS.D, target = FLAGS.target):
        super(Net, self).__init__()
        
        if FLAGS.gnn_type == 'gat':
            conv_class = GATConv
        elif FLAGS.gnn_type == 'gcn':
            conv_class = GCNConv
        elif FLAGS.gnn_type == 'transformer':
            conv_class = TransformerConv
        else:
            raise NotImplementedError()

        if FLAGS.no_graph:
            if FLAGS.only_pragma:
                self.init_MLPs = nn.ModuleDict()
                for gname, feat_dim in init_pragma_dict.items():
                    mlp = MLP(feat_dim, D,
                                    activation_type=FLAGS.activation,
                                    num_hidden_lyr=1)
                    self.init_MLPs[gname] = mlp
                channels = [D, D, D, D]
                self.conv_first = MLP(D, D,
                                activation_type=FLAGS.activation,
                                hidden_channels=channels,
                                num_hidden_lyr=len(channels))
            else:   
                channels = [D, D, D, D, D]
                self.conv_first = MLP(in_channels, D,
                                activation_type=FLAGS.activation,
                                hidden_channels=channels,
                                num_hidden_lyr=len(channels))
        else:
            if FLAGS.encode_edge and FLAGS.gnn_type == 'transformer':
                # print(in_channels)
                self.conv_first = conv_class(in_channels, D, edge_dim=edge_dim)
            else:
                self.conv_first = conv_class(in_channels, D)

            self.conv_layers = nn.ModuleList()

            for _ in range(num_layers - 1):
                if FLAGS.encode_edge and FLAGS.gnn_type == 'transformer':
                    conv = conv_class(D, D, edge_dim=edge_dim)
                else:
                    conv = conv_class(D, D)
                self.conv_layers.append(conv)

        self.jkn = JumpingKnowledge(FLAGS.jkn_mode, channels=D, num_layers=2)

        self.task = task

        if task == 'regression':
            self.out_dim = 1
            self.loss_fucntion = torch.nn.MSELoss()
        else:
            self.out_dim = 2
            self.loss_fucntion = torch.nn.CrossEntropyLoss()

        self.MLPs = nn.ModuleDict()
        
        if FLAGS.node_attention:
            self.gate_nn = Sequential(Linear(D, D), ReLU(), Linear(D, 1))
            self.glob = MyGlobalAttention(self.gate_nn, None)
        
        if 'regression' in self.task:
            _target_list = target
            if not isinstance(FLAGS.target, list):
                _target_list = [target]
            self.target_list = [t for t in _target_list]
        else:
            self.target_list = ['perf']
        if D > 64:
            hidden_channels = [D // 2, D // 4, D // 8, D // 16, D // 32]
        else:
            hidden_channels = [D // 2, D // 4, D // 8]
        for target in self.target_list:
            self.MLPs[target] = MLP(D, self.out_dim, activation_type=FLAGS.activation,
                                    hidden_channels=hidden_channels,
                                    num_hidden_lyr=len(hidden_channels))

    def forward(self, data):
        x, edge_index, edge_attr, batch= \
            data.x, data.edge_index, data.edge_attr, data.batch# , data.pragmas
        if hasattr(data, 'kernel'):
            gname = data.kernel[0]
        # print(gname)
        # print(edge_attr.shape)
        outs = []
        if FLAGS.activation == 'relu':
            activation = F.relu
        elif FLAGS.activation == 'elu':
            activation = F.elu
        else:
            raise NotImplementedError()
        
        if FLAGS.no_graph:
            out = x
            if FLAGS.only_pragma:
                MLP_to_use = self.init_MLPs[gname]
                out = MLP_to_use(pragmas)
            
            out = self.conv_first(out)
        else:
            if FLAGS.encode_edge and  FLAGS.gnn_type == 'transformer':
                out = activation(self.conv_first(x, edge_index, edge_attr=edge_attr))
            else:
                out = activation(self.conv_first(x, edge_index))

            outs.append(out)

            for i, conv in enumerate(self.conv_layers):
                if FLAGS.encode_edge and  FLAGS.gnn_type == 'transformer':
                    out = conv(out, edge_index, edge_attr=edge_attr)
                else:
                    out = conv(out, edge_index)
                if i != len(self.conv_layers) - 1:
                    out = activation(out)
                    
                outs.append(out)

            if FLAGS.jkn_enable:
                out = self.jkn(outs)
        
        if FLAGS.node_attention:
            out, node_att_scores = self.glob(out, batch)
            if FLAGS.subtask == 'visualize':
                from saver import saver
                saver.save_dict({'data': data, 'node_att_scores': node_att_scores},
                                f'{tvt}_{epoch}_{iter}_node_att.pickle')
        else:
            out = global_add_pool(out, batch)         

        out_dict = OrderedDict()
        total_loss = 0
        out_embed = out
        
        loss_dict = {}
        for target_name in self.target_list:
        # for target_name in target_list:
            out = self.MLPs[target_name](out_embed)
            y = _get_y_with_target(data, target_name)
            if self.task == 'regression':
                target = y.view((len(y), self.out_dim))
                if FLAGS.loss == 'RMSE':
                    loss = torch.sqrt(self.loss_fucntion(out, target))
                elif FLAGS.loss == 'MSE':
                    loss = self.loss_fucntion(out, target)
                else:
                    raise NotImplementedError()
            else:
                target = y.view((len(y)))
                loss = self.loss_fucntion(out, target)
            out_dict[target_name] = out
            total_loss += loss
            loss_dict[target_name] = loss


        return out_dict, total_loss, loss_dict
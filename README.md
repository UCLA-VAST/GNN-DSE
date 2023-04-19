# GNN-DSE

## Publication

+ Atefeh Sohrabizadeh, Yunsheng Bai, Yizhou Sun, Jason Cong. [Automated Accelerator Optimization Aided by Graph Neural Networks](https://dl.acm.org/doi/abs/10.1145/3489517.3530409). In DAC, 2022.

## About
This repo contains the codes for building GNN-DSE, an automated framework to be trained to act as the surrogate of the HLS tool. It can be used to expedite the design optimization process. The database used in this repo is built using the Xilinx HLS tools, but can be replaced by other databases.


## Content
1. [Requirements and Dependencies](#requirements-and-dependencies)
2. [Project File Tree](#project-file-tree)
3. [Running the Project](#running-the-project)


## Requirements and Dependencies

### Requirements
You can install the required packages for running this project using:

````bash
sudo apt-get install python3-venv
python3 -m venv venv
source venv/bin/activate
pip3 install --upgrade pip
pip3 install -r requirements.txt
````

### Graph Generation
The graph generation requires [LLVM](https://clang.llvm.org/get_started.html) and [ProGraML](https://github.com/ChrisCummins/ProGraML). If you want to expand on the existing graphs, please consider installing them.

This project is built on LLVM 13 that can be installed by:

```
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh <version number>
```

Please refer to [ProGraML's](https://github.com/ChrisCummins/ProGraML) repo for installing it.


### Database Generation
The initial database is generated by [AutoDSE](https://github.com/UCLA-VAST/AutoDSE) which is built on top of the [Merlin Compiler](https://github.com/Xilinx/merlin-compiler). If you want to expand the database, please consider installing them.

For synthesizing the designs, Xilinx SDAccel 2018.3 is used and currently we are working on transferring the database to Vitis 2020.2.


## Project File Tree
The project file structure is as below:

````
.
+-- dse_database          # database, graphs, codes to generate/analyze them
    +-- [machsuite/poly]  # the source code, ds config, and database for each of the benchmarks
    +-- programl          # the generated graphs for each of the kernels
    +-- merlin_prj        # the Merlin project to run each of the kernels
+-- models                # the final trained models along with the initial one-hot encoder
+-- src                   # the source codes for defining and training the model and running the DSE
````


## Running the Project

The `src/config.py` contains all the tunable parameters of the project. The current configuration runs the trainer in regression mode with some pre-defined hyper parameters. If you want to change the modes of running, please edit this file.

After setting the configurations, run the following command to execute the project:

````bash
cd src
python3 -W ignore main.py
````

You can run the `src/main.py` for training, inference, and design space exploration based on the parameters in `src/config.py`. For generating the graph, run the following command: 

````bash
cd dse_database
python3 -W ignore graph-gen.py ## modify inside of __main__ with your desired kernels
````


## Citation
If you find any of the ideas/codes useful for your research, please cite our paper:

	@inproceedings{sohrabizadeh2021gnn,
        title={Automated Accelerator Optimization Aided by Graph Neural Networks},
        author={Sohrabizadeh, Atefeh and Bai, Yunsheng and Sun, Yizhou and Cong, Jason},
        booktitle={2022 59th ACM/IEEE Design Automation Conference (DAC)},
        year={2022}
    }

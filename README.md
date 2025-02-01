## Structured Doubly Stochastic Graph based Clustering
This is a Matlab implementation of  paper "Structured Doubly Stochastic Graph-based Clustering", which is accepted by TNNLS2025. 

## Contributions

The contributions of this paper are three-folded.
1) we propose a structured doubly stochastic graph-based clustering model termed SDSGC.
2) we propose a novel method based ALM to optimize the subproblem with doubly stochastic constraints.
3) we formulate an effective noise-adding scheme and generate a series of noised face data sets based on the pipeline of unconstrained face clustering.
Note: We crop the face area to form deep features, which implies some noised images whose face area fails to be detected are discarded. We have updated all the ".mat" documents for these noised face data sets, if you need the original noisy face images, you can download at the [Link](https://pan.baidu.com/s/1GQAp8JUowrvkDIYBOqhPNw?pwd=1234), extract code: 1234.
## Usage

# To Reproduce  the results in the paper, please dicretly run the following two ".m" files respectively.
* Run_SDSGC.m: run  SDSGC on real benchmarks.
* Run_SDSGC_noisedfaces.m: run SDSGC on our noised face data sets.
  
# For your own experiments, here are some important settings (Take "Run_SDSGC.m" as example)
First, set runtimes and test datasets in "Run_SDSGC.m" 
```
runtimes = 1; % runnings on each dataset, default: 1
dataname = {'iris','COIL20','zoo','COIL100','Yale_64x64','JAFFE_64x64','ORL_64x64','CASIA_64x64'}; 
```
Then, run  "Run_SDSGC.m".  The results of aLL datasets (benchamarks) are obtained simultaneously and saved in corresponding pathes.
# For result record

*  Seven clustering metrics are recorded (we only report three of them in the paper). For each dataset (benchamark), the accuracy (ACC), Normalized Mutual Information (NMI), Purity (PUR), Fscore, Precision (PRE), Recall (REC), Adjusted Rand Index (ARI), as well as  the average value (ave.) and standard deviation (std.) of them in total 5 runs  (we set 5 runs in the paper to demonstrate deterministic result) are recorded in "./Results_ySDSGC". For convenience,  the ave. and std. of seven metrics on all the datasets (benchmarks) are recorded in "./Results_ySDSGC_all". Moreover, the time cost of each run as well as the average value (ave.) and standard deviation (std.) in all 5 runs are recorded in "./Results_timeSDSGC".
# Citation
If you think our work is helpful,  considering to give a star for this repository. Thanks!

If you use our code or noised data sets, please kindly cite our paper by
```
@ARTICLE{SDSGC,
  author={Wang, Nian and Cui, Zhigao and Li, Aihua and Lu, Yihang and Wang, Rong and Nie, Feiping},
  journal={IEEE Transactions on Neural Networks and Learning Systems}, 
  title={Structured Doubly Stochastic Graph-Based Clustering}, 
  year={2025},
  volume={},
  number={},
  pages={1-14},
  doi={10.1109/TNNLS.2025.3531987}}
```
# For more our works
My interests focus on machine learning (deep learning) and its applications to image enhancement, data clustering (classification), object recognition (tracking) etc. Please feel free to  communicate with me. If you are interested at my works, you can get more papers and codes at my [Homepage](https://nianwang-hjjgcdx.github.io/).

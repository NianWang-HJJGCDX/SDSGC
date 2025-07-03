# Structured Doubly Stochastic Graph-based Clustering （SDSGC）
This is a Matlab implementation of  paper "Structured Doubly Stochastic Graph-based Clustering", which is accepted by IEEE Transactions on Neural Networks and Learning Systems in 2025. 

# Contributions
The contributions of this paper are three-folded.
1) we propose a structured doubly stochastic graph-based clustering model termed SDSGC.
2) we propose a novel method based ALM to optimize the subproblem with doubly stochastic constraints.
3) we formulate an effective noise-adding scheme and generate a series of noised face data sets based on the pipeline of unconstrained face clustering.

The proposed strategy is inherently applicable to nearly all existing graph clustering algorithms by changing the constraints (1<sup>T</sup>w<sup>i</sup>=1,w<sub>ij</sub>>0) to doubly stochastic constraints (w<sup>i</sup>=w<sub>i</sub>,1<sup>T</sup>w<sup>i</sup>=1,w<sub>ij</sub>>0), including even multi-view or multi-order graph fusion models. Such broad extensibility stems from the simplicity of our optimization strategy, which does not involve any sophisticated theorems but merely requires a straightforward transformation—converting the matrix optimization problem (Eq. 19 in the paper) into a vector-based formulation (Eq. 20 in the paper). 

:exclamation: Note for our noisy face data sets: To extract facial features, we first detect and crop the face region from each image, which inherently excludes low-quality images where face detection fails. We have updated all the ".mat" documents for these noisy face data sets in root "our_noised_facedatasets". If you need the original noisy face images, you can download at the [Link](https://pan.baidu.com/s/1GQAp8JUowrvkDIYBOqhPNw?pwd=1234), extract code: 1234.

# Usage of this code

## To reproduce  the results in the paper, please dicretly run the following two ".m" files respectively.
* Run_SDSGC.m: run  SDSGC on real benchmarks.
* Run_SDSGC_noisedfaces.m: run SDSGC on our noised face data sets.
  
## Here are some important settings (Take "Run_SDSGC.m" as example)
First, set runtimes and test datasets in "Run_SDSGC.m" 
```
runtimes = 1; % runs on each dataset, default: 1
dataname = {'iris','JAFFE_64x64'}; 
```
Then, run  "Run_SDSGC.m".  The results of aLL datasets (benchamarks) are obtained simultaneously and saved in corresponding pathes.
## For result record
Seven clustering metrics are recorded (we only report three of them in the paper). For each dataset (benchamark), the accuracy (ACC), Normalized Mutual Information (NMI), Purity (PUR), Fscore, Precision (PRE), Recall (REC), Adjusted Rand Index (ARI), as well as  the average value (ave.) and standard deviation (std.) of them in total 5 runs  (we set 5 runs in the paper to demonstrate deterministic results) are recorded in "./Results_ySDSGC". For convenience,  the ave. and std. of seven metrics on all the datasets (benchmarks) are recorded in "./Results_ySDSGC_all". Moreover, the time cost of each run as well as the average value (ave.) and standard deviation (std.) in all 5 runs are recorded in "./Results_timeSDSGC".

## For hyperparamters
We adopted a heuristic method to avoid the tuning  of the hyperparameters in the designed model. Due to the use of the augmented Lagrange method, two additional hyperparameters, $\mu$ and $\rho$, are introduced. Typically, the hyperparameters of the augmented Lagrange method do not require tuning. Our initial experiments proved that the performance was very stable with the settings of these two parameters. When $\mu$ is set to 1 and $\rho$ is within [1-1.5], the impact on the final performance is very small.

# Our related works


 In [1], we applied our method to large-scale remote sensing data clustering, achieving a linear-complexity clustering model. 
 %In [2], we extended it to a high-order graph fusion-based clustering framework, attaining much higher accuracy than the baseline method presented in this work.

[1] Large-scale Hyperspectral Image Projected Clustering via Doubly-stochastic Graph Learning. [Paper](https://www.mdpi.com/2072-4292/17/9/1526)  [Code](https://github.com/NianWang-HJJGCDX/HPCDL)

% [2] Multi-order Graph based Clustering Via Dynamical Low Rank Tensor Approximation. [Paper](https://www.sciencedirect.com/science/article/pii/S0925231225012433) [Code](https://github.com/NianWang-HJJGCDX/MCDLT)

# For more  works
If you are interested at my works, you can get more papers and codes at my [Homepage](https://nianwang-hjjgcdx.github.io/).

# Citation
If you think our work is helpful,  considering to give a star for this repository. Thanks!
If you use our code or nois data sets, please kindly cite our paper by
```
@ARTICLE{SDSGC,
  author={Wang, Nian and Cui, Zhigao and Li, Aihua and Lu, Yihang and Wang, Rong and Nie, Feiping},
  journal={IEEE Transactions on Neural Networks and Learning Systems}, 
  title={Structured Doubly Stochastic Graph-Based Clustering}, 
  year={2025},
  volume={36},
  number={6},
  pages={11064-11077},
  doi={10.1109/TNNLS.2025.3531987}}}
```

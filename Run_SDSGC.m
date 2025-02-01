%
% Structured Doubly Stochastic Graph based Clustering [TNNLS2025]
%% 
% X: 2D data matrix, each row is a sample.
% Y: ture clustering label.
% n: number of samples.
% d: number of feature dimensions.
% c: number of neighbors for graph building.
% k: number of clusters.
% gamma & eta: two hyperparameters in our model.
% y: predicted clustering label.
% W: affinity matrix of learned structured doubly stochastic graph
%%
clc;  close all; clear all;

%% setting
runtimes = 1; % run-times on each dataset, default: 1
dataname = {'iris','JAFFE_64x64'};

[userview,systemview] = memory;
numdata = length(dataname);
currentFolder = pwd;
addpath(genpath(currentFolder));

%% buidling the path for results record
result_y_dir = 'Results_ySDSGC/';
if(~exist('Results_ySDSGC','file'))
    mkdir('Results_ySDSGC');
    addpath(genpath('Results_ySDSGC/'));
end
result_ySDSGC_all_dir = 'Results_ySDSGC_all/';  
if(~exist('Results_ySDSGC_all','file'))
    mkdir('Results_ySDSGC_all');
    addpath(genpath('Results_ySDSGC_all/'));
end
result_timeSDSGC_dir = 'Results_timeSDSGC/';
if(~exist('Results_timeSDSGC','file'))
    mkdir('Results_timeSDSGC');
    addpath(genpath('Results_timeSDSGC/'));
end

%% read dataset
for cdata = 1:numdata
disp(char(dataname(cdata)));
datadir = 'datasets/';
dataf = [datadir, cell2mat(dataname(cdata))];
load(dataf); X = NormalizeFea(X,1); 
k=length(unique(Y));
[n,d]=size(X);
c=15;

% Initialization 
[W,gamma] = GLAN(X',c);
eta = gamma;
%% iter ...
for rtimes = 1:runtimes
time = 0;
tic;
[y,W] = SDSGC(X',W,k,gamma,eta);
Dw = sum(W); % for a doubly stochastic graph, its degree matrix is an identity matrix
time = time + toc;
metric_y =ClusteringMeasure_new(Y, y);
ACC_y(rtimes) = metric_y(1); 
NMI_y(rtimes) = metric_y(2);
Pu_y(rtimes)  = metric_y(3); 
Fscore_y(rtimes) = metric_y(4);
Precision_y(rtimes) = metric_y(5); 
Recall_y(rtimes) = metric_y(6);
ARI_y(rtimes) = metric_y(7); 
Time_cost(rtimes)=time;

fprintf('=====In runtime %d=====\n ACC:%.4f\t NMI:%.4f\t Pu:%.4f\t Fscore:%.4f\t Precision:%.4f\t Recall:%.4f\t ARI:%.4f Time_cost:%.4f\n',rtimes,metric_y(1),metric_y(2),metric_y(3),metric_y(4),metric_y(5),metric_y(6),metric_y(7),time);
end;
    Result_y(1,:) = ACC_y; 
    Result_y(2,:) = NMI_y; 
    Result_y(3,:) = Pu_y; 
    Result_y(4,:) = Fscore_y;
    Result_y(5,:) = Precision_y; 
    Result_y(6,:) = Recall_y; 
    Result_y(7,:) = ARI_y; 
   
    Result_y(8,1) = mean(ACC_y);  
    Result_y(8,2) = mean(NMI_y); 
    Result_y(8,3) = mean(Pu_y); 
    Result_y(8,4) = mean(Fscore_y); 
    Result_y(8,5) = mean(Precision_y); 
    Result_y(8,6) = mean(Recall_y); 
    Result_y(8,7) = mean(ARI_y); 
    
    Result_y(9,1) = std(ACC_y); 
    Result_y(9,2) = std(NMI_y); 
    Result_y(9,3) = std(Pu_y);
    Result_y(9,4) = std(Fscore_y);
    Result_y(9,5) = std(Precision_y);  
    Result_y(9,6) = std(Recall_y);  
    Result_y(9,7) = std(ARI_y); 
    
    result_y_all(cdata,1) = mean(ACC_y); result_y_all(cdata,10) = std(ACC_y);
    result_y_all(cdata,2) = mean(NMI_y); result_y_all(cdata,11) = std(NMI_y);
    result_y_all(cdata,3) = mean(Pu_y); result_y_all(cdata,12) = std(Pu_y);
    result_y_all(cdata,4) = mean(Fscore_y); result_y_all(cdata,13) = std(Fscore_y);
    result_y_all(cdata,5) = mean(Precision_y); result_y_all(cdata,14) = std(Precision_y);
    result_y_all(cdata,6) = mean(Recall_y); result_y_all(cdata,15) = std(Recall_y);
    result_y_all(cdata,7) = mean(ARI_y); result_y_all(cdata,16) = std(ARI_y);
    
    Result_time(1,:) = Time_cost;
    Result_time(2,1) = mean(Time_cost);
    Result_time(2,2) = std(Time_cost);
    
save([result_y_dir,char(dataname(cdata)),'_result_y.mat'],'Result_y');
save([result_timeSDSGC_dir,char(dataname(cdata)),'_result_time.mat'],'Result_time');
save([result_ySDSGC_all_dir,'result_all.mat'],'result_y_all');
clear ACC_y NMI_y Pu_y Fscore_y Precision_y Recall_y ARI_y metric_y Result_y  y Result_time A F;

end;
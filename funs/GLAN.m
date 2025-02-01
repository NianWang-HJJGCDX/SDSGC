% min_{W>=0,W1=1} sum_{i,j=1}^n||x_i-x_j||_2^2w_{ij}+gamma||W||_F^2
function [A,r] = GLAN(X,k)
% X: dim*num data matrix, each column is a data point
% k: number of neighbors to determine the initial graph
% A: num*num learned symmetric similarity matrix

% Graph Learning with Adaptive Neighbors.  

num = size(X,2);

if nargin < 2
    k = 5;
end

distX = L2_distance_1(X,X);
%distX = sqrt(distX);
[distX1, idx] = sort(distX,2);
A = zeros(num);
% NITER = 100;
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    id = idx(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
r = mean(rr);



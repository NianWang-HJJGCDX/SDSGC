%% min_{W>=0,W1=1,W=W'}sum_{i,j=1}^n||x_i-x_j||_2^2w_{ij}+gamma||W||_F^2+2*lambda*trace(F'*L(W)*F)
function [y, W, evs] = SDSGC(X,W,k,gamma,eta,local)
% X: dim*num data matrix, each column is a data point
% k: number of neighbors to determine the initial graph
% y: num*1 cluster labels
% W: num*num the learned doubly stochastic  matrix
% local:capture localized data relationships by enforcing the sparsity of the graph

NITER = 300;
num = size(X,2);
D = diag(sum(W));
L = D - W;
[F, temp, evs]=eig1(L, k, 0);
if sum(evs(1:k+1)) < 0.00000000001
    error('The original graph has more than %d connected component', k);
end;
rho = 1.3;
mu = 1;
lambda = zeros(num);
distX = L2_distance_1(X,X);
[Para,idx] = symNeighbors(distX,k);
for iter = 1:NITER
    % update F
    distF = L2_distance_1(F',F');
    Z = mu*W'-1/2*lambda-1/2*lambda'-1/2*distX-1/2*eta*distF;
    % update W
    W = zeros(num);
    for i=1:num
        if local == 1
          idxa0 = Para.kn{i};
        else
          idxa0 = idx(i,2:num);
        end
        ad = Z(i,idxa0)/(gamma+mu);
        W(i,idxa0) = EProjSimplex_new(ad);    
    end;
    % Update zeta
    h = W-W';
    lambda = lambda+mu*h;
    % Update mu
    mu = rho*mu;
    W = (W+W')/2;
    D = diag(sum((W+W')/2));
    F_old = F;
    [F, temp, ev]=eig1(D-W, k, 0);
    evs(:,iter+1) = ev;
    fn1 = sum(ev(1:k));
    fn2 = sum(ev(1:k+1)); 
    flag = sum(logical(diag(D-eye(num))<0.01)); % check  whether the graph is doubly stochastic
    if fn1 > 0.00000000001 
        eta = 2*eta;
    elseif fn2 < 0.00000000001
        eta = eta/2;  F = F_old;
    elseif fn1 < 0.00000000001 & fn2 > 0.00000000001 & flag == num  % output graph in advance [when the graph is structured and doubly stochastic] 
        break;
    end;
end;
[clusternum, y]=graphconncomp(sparse(W)); y = y'; % obtaining the clustering results by searching for the connectivity of structured doubly stochastic graph W
if clusternum ~= k
    sprintf('Can not find the correct cluster number: %d', k)
end;


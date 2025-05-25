function   [Para,idx] = FindNeighbors(distX,k)
num = size(distX,2);
[~, idx] = sort(distX,2);
index = zeros(num);
for i=1:num
    idxa0 = idx(i,2:k+1);
    index(i,idxa0)= 1;   
end;
idxa0 = zeros(num);
for i=1:num
    c_vec = index(:,i);
    m = find(c_vec==1);
    aa = idx(i,2:k+1);
    cc=setdiff(m,aa)';
    Para.k{i,1} = length([cc,aa]);
    Para.kn{i,1} = [cc,aa];    
end;
end
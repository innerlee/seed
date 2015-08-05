function [ seeds ] = kpp( data, k )
%k-means++
%   Simple implementation of k-means++.
%  Input: 
%    data: rows of data
%    k: k seeds
%  Output: row index of seeds
%
%  ref: k-means++: The Advantages of Careful Seeding
%  by: D. Arthur & C. Vassilvitskii
%  code by: lizz
%  version: 0.0
%  date: 2015-08-04

if k<=0
    seeds=[];
    return; 
end

[N, M]=size(data);

if(k>=N)
    seeds=1:N;
    return;
end

seeds(k)=0;

% dist and accumulates
dist=Inf(N,1);

% random choose first index i
ind=randi(N);
seeds(1)=ind;

for j=2:k
    % distance to i
    dist=min(dist,sum((data-repmat(data(ind,:),N,1)).^2,2));
    acc=cumsum(dist);

    tok=rand()*acc(N);
    ind=sum(acc<tok)+1;
    seeds(j)=ind;
    
end



end


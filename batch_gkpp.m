function [ seeds ] = gkpp( data, k)
%k-means++
%   Gpu implementation of k-means++, allow big dataset
%  Input: 
%    data: rows of data
%    k: k seeds
%    P: lines per batch
%  Output: row index of seeds
%
%  ref: k-means++: The Advantages of Careful Seeding
%  by: D. Arthur & C. Vassilvitskii
%  code by: lizz
%  version: 0.0
%  date: 2015-08-04
tic
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

% get gpu info
gpu=gpuDevice;
mem=gpu.AvailableMemory;

% load data to gpu
gdata=gpuArray(data);
fprintf(['loading data to gpu: '])
toc

% random choose first index i
ind=randi(N);
seeds(1)=ind;
fprintf(['seed 1: (' int2str(ind) ') '])
toc

for j=2:k
    % distance to i
    gpoint=gpuArray(gdata(ind,:));
    gsubtract = bsxfun(@minus,gdata,gpoint);
    gdist=sum(gsubtract.^2,2);
    dist=min(dist,gather(gdist));
    acc=cumsum(dist);

    tok=rand()*acc(N);
    ind=sum(acc<tok)+1;
    seeds(j)=ind;
    fprintf(['seed ' int2str(j) ':  (' int2str(ind) ') '])
    toc
end



end


data=rand(100000,1000);
k=100;

fprintf('===== with gpu =====\n');
gkpp(data,k)

data=rand(100000,1000);
k=100;

fprintf('===== with gpu =====\n');
gkpp(data,k)
 
k=5;
fprintf('===== without gpu =====\n');
kpp(data,k)
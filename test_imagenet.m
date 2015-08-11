testdata=cell2mat(data_features');
k=100;


fprintf('===== with gpu =====\n');
seeds=gkpp(testdata,k);

seedata=testdata(seeds,:);

salt=datestr(now,'mmddHHMMSS');
filefeature=['data/' salt '-features.h5'];
fileseeds=['data/' salt '-seeds.h5'];

h5create(filefeature, '/features', size(testdata'))
h5write(filefeature, '/features', testdata')

h5create(fileseeds, '/seeds', size(seedata'))
h5write(fileseeds, '/seeds', seedata')
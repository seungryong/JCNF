function net = init_depth_gradient_scale()
%% DAG-NN based Network
net = dagnn.DagNN();

cnv1 = dagnn.Conv('size',[3 3 20 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv1', cnv1, {'input'}, {'x1'}, {'c1f','c1b'});
f = net.getParamIndex('c1f') ;
net.params(f).value = randn(3, 3, 20, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c1b') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn1',...
    dagnn.BatchNorm(),...
    'x1','x2',{'bn1bism','bn1bisb','bn1biss'});
f = net.getParamIndex('bn1bism') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1bisb') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1biss') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re1', dagnn.ReLU(), {'x2'}, {'x3'});

cnv2 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv2', cnv2, {'x3'}, {'x4'}, {'c2f','c2b'});
f = net.getParamIndex('c2f') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c2b') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn2',...
    dagnn.BatchNorm(),...
    'x4','x5',{'bn2bism','bn2bisb','bn2biss'});
f = net.getParamIndex('bn2bism') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2bisb') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2biss') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re2', dagnn.ReLU(), {'x5'}, {'x6'});

cnv3 = dagnn.Conv('size',[3 3 64 2],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv3', cnv3, {'x6'}, {'x7'}, {'c3f','c3b'});
f = net.getParamIndex('c3f') ;
net.params(f).value = randn(3, 3, 64, 2, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c3b') ;
net.params(f).value = zeros(1, 2, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('non_act', NonlinearActivation(), {'x7'}, {'pred'});

net.addLayer('objective', ...
  EuclideanLoss_Scale(), ...
  {'pred', 'label'}, 'objective');


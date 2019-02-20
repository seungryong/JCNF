function net = init_depth_intrinsic_gradient()

net = dagnn.DagNN();

% Conv1 in Depth/Intrinsic
cnv1 = dagnn.Conv('size',[3 3 3 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv1_D', cnv1, {'input'}, {'x1'}, {'c1f_D','c1b_D'});
f = net.getParamIndex('c1f_D') ;
net.params(f).value = randn(3, 3, 3, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c1b_D') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn1_D',...
    dagnn.BatchNorm(),...
    'x1','x1_bn',{'bn1bism_D','bn1bisb_D','bn1biss_D'});
f = net.getParamIndex('bn1bism_D') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1bisb_D') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1biss_D') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re1_D', dagnn.ReLU(), {'x1_bn'}, {'x1_ru'});

cnv1 = dagnn.Conv('size',[3 3 3 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv1_I', cnv1, {'input'}, {'x2'}, {'c1f_I','c1b_I'});
f = net.getParamIndex('c1f_I') ;
net.params(f).value = randn(3, 3, 3, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c1b_I') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn1_I',...
    dagnn.BatchNorm(),...
    'x2','x2_bn',{'bn1bism_I','bn1bisb_I','bn1biss_I'});
f = net.getParamIndex('bn1bism_I') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1bisb_I') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn1biss_I') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;

net.addLayer('re1_I', dagnn.ReLU(), {'x2_bn'}, {'x2_ru'});

% Conv2 in Depth/Intrinsic
cnv2 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv2_D', cnv2, {'x1_ru'}, {'x3'}, {'c2f_D','c2b_D'});
f = net.getParamIndex('c2f_D') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c2b_D') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn2_D',...
    dagnn.BatchNorm(),...
    'x3','x3_bn',{'bn2bism_D','bn2bisb_D','bn2biss_D'});
f = net.getParamIndex('bn2bism_D') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2bisb_D') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2biss_D') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re2_D', dagnn.ReLU(), {'x3_bn'}, {'x3_ru'});

cnv2 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv2_I', cnv2, {'x2_ru'}, {'x4'}, {'c2f_I','c2b_I'});
f = net.getParamIndex('c2f_I') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c2b_I') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn2_I',...
    dagnn.BatchNorm(),...
    'x4','x4_bn',{'bn2bism_I','bn2bisb_I','bn2biss_I'});
f = net.getParamIndex('bn2bism_I') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2bisb_I') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn2biss_I') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re2_I', dagnn.ReLU(), {'x4_bn'}, {'x4_ru'});

% Concat. Network
net.addLayer('concat', dagnn.Concat('dim',3), {'x3_ru','x4_ru'}, {'x5'}) ;

% Conv3 in Depth/Intrinsic
cnv3 = dagnn.Conv('size',[3 3 128 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv3_D', cnv3, {'x5'}, {'x6'}, {'c3f_D','c3b_D'});
f = net.getParamIndex('c3f_D') ;
net.params(f).value = randn(3, 3, 128, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c3b_D') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn3_D',...
    dagnn.BatchNorm(),...
    'x6','x6_bn',{'bn3bism_D','bn3bisb_D','bn3biss_D'});
f = net.getParamIndex('bn3bism_D') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn3bisb_D') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn3biss_D') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re3_D', dagnn.ReLU(), {'x6_bn'}, {'x6_ru'});

cnv3 = dagnn.Conv('size',[3 3 128 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv3_I', cnv3, {'x5'}, {'x7'}, {'c3f_I','c3b_I'});
f = net.getParamIndex('c3f_I') ;
net.params(f).value = randn(3, 3, 128, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c3b_I') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn3_I',...
    dagnn.BatchNorm(),...
    'x7','x7_bn',{'bn3bism_I','bn3bisb_I','bn3biss_I'});
f = net.getParamIndex('bn3bism_I') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn3bisb_I') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn3biss_I') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re3_I', dagnn.ReLU(), {'x7_bn'}, {'x7_ru'});

% Conv4 in Depth/Intrinsic
cnv4 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv4_D', cnv4, {'x6_ru'}, {'x8'}, {'c4f_D','c4b_D'});
f = net.getParamIndex('c4f_D') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c4b_D') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn4_D',...
    dagnn.BatchNorm(),...
    'x8','x8_bn',{'bn4bism_D','bn4bisb_D','bn4biss_D'});
f = net.getParamIndex('bn4bism_D') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4bisb_D') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4biss_D') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re4_D', dagnn.ReLU(), {'x8_bn'}, {'x8_ru'});

cnv4 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv4_A', cnv4, {'x7_bn'}, {'x9'}, {'c4f_A','c4b_A'});
f = net.getParamIndex('c4f_A') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c4b_A') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn4_A',...
    dagnn.BatchNorm(),...
    'x9','x9_bn',{'bn4bism_A','bn4bisb_A','bn4biss_A'});
f = net.getParamIndex('bn4bism_A') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4bisb_A') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4biss_A') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re4_A', dagnn.ReLU(), {'x9_bn'}, {'x9_ru'});

cnv4 = dagnn.Conv('size',[3 3 64 64],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv4_S', cnv4, {'x7_ru'}, {'x10'}, {'c4f_S','c4b_S'});
f = net.getParamIndex('c4f_S') ;
net.params(f).value = randn(3, 3, 64, 64, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c4b_S') ;
net.params(f).value = zeros(1, 64, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

net.addLayer('bn4_S',...
    dagnn.BatchNorm(),...
    'x10','x10_bn',{'bn4bism_S','bn4bisb_S','bn4biss_S'});
f = net.getParamIndex('bn4bism_S') ;
net.params(f).value = ones(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4bisb_S') ;
net.params(f).value = zeros(64, 1, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0 ;
f = net.getParamIndex('bn4biss_S') ;
net.params(f).value = zeros(64,2, 'single');
net.params(f).learningRate = 0.05 ;
net.params(f).weightDecay = 0 ;

net.addLayer('re4_S', dagnn.ReLU(), {'x10_bn'}, {'x10_ru'});

% Conv5 in Depth/Intrinsic
cnv5 = dagnn.Conv('size',[3 3 64 2],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv5_D', cnv5, {'x8_ru'}, {'x11'}, {'c5f_D','c5b_D'});
f = net.getParamIndex('c5f_D') ;
net.params(f).value = randn(3, 3, 64, 2, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c5b_D') ;
net.params(f).value = zeros(1, 2, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

cnv5 = dagnn.Conv('size',[3 3 64 6],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv5_A', cnv5, {'x9_ru'}, {'x12'}, {'c5f_A','c5b_A'});
f = net.getParamIndex('c5f_A') ;
net.params(f).value = randn(3, 3, 64, 6, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c5b_A') ;
net.params(f).value = zeros(1, 6, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

cnv5 = dagnn.Conv('size',[3 3 64 6],'pad',1,'stride',1,'hasBias',true);
net.addLayer('cnv5_S', cnv5, {'x10_ru'}, {'x13'}, {'c5f_S','c5b_S'});
f = net.getParamIndex('c5f_S') ;
net.params(f).value = randn(3, 3, 64, 6, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('c5b_S') ;
net.params(f).value = zeros(1, 6, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

% loss
net.addLayer('objective1', ...
  EuclideanLoss(), ...
  {'x11', 'label1'}, 'objective1');

net.addLayer('objective2', ...
  EuclideanLoss(), ...
  {'x12', 'label2'}, 'objective2');

net.addLayer('objective3', ...
  EuclideanLoss(), ...
  {'x13', 'label3'}, 'objective3');
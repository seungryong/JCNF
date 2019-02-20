function net = init_depth_global()

%% Residual Net based CNN
% -------------------------------------------------------------------------
%                    Load & download the source model if needed (ResNet)
% -------------------------------------------------------------------------
sourceModelPath = 'model/imagenet-resnet-101-dag.mat';
if ~exist(sourceModelPath)
  fprintf('downloading ResNet model\n') ;
  mkdir(fileparts(sourceModelPath)) ;
  urlwrite('http://www.vlfeat.org/matconvnet/models/imagenet-resnet-101-dag.mat', sourceModelPath) ;
end
netStruct = load(sourceModelPath);
net = dagnn.DagNN.loadobj(netStruct) ;

out = net.getLayerIndex('fc1000');

while(numel(net.layers)>=out)
    net.removeLayer(net.layers(numel(net.layers)).name) ;
end

net.addLayer('fc2048', ...
  dagnn.Conv('size', [1 10 2048 13*32 ], 'hasBias', true, 'pad', [0 0 0 0], 'stride', [1 1]), ...
  {'pool5'}, {'pred'}, {'fc2048f','fc2048b'}) ;
f = net.getParamIndex('fc2048f') ;
net.params(f).value = randn(1, 10, 2048, 13*32, 'single')/1000;
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;
f = net.getParamIndex('fc2048b') ;
net.params(f).value = zeros(1, 13*32, 'single');
net.params(f).learningRate = 1 ;
net.params(f).weightDecay = 0.9 ;

% loss
net.addLayer('objective', ...
  EuclideanLoss(), ...
  {'pred', 'label'}, 'objective');

% --------------------------------------------------------------------
function net = insertBnorm(net, l)
% --------------------------------------------------------------------
assert(isfield(net.layers{l}, 'weights'));
ndim = size(net.layers{l}.weights{1}, 4);
layer = struct('type', 'bnorm', ...
               'weights', {{ones(ndim, 1, 'single'), zeros(ndim, 1, 'single')}}, ...
               'learningRate', [1 1 0.05], ...
               'weightDecay', [0 0]) ;
net.layers{l}.biases = [] ;
net.layers = horzcat(net.layers(1:l), layer, net.layers(l+1:end)) ;
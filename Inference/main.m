%% S. Kim et al., "Unified Depth Prediction and Intrinsic Image Decomposition 
%% from a Single Image via Joint Convolutional Neural Fields," ECCV, 2016.
%% script for computing testing
%% written by Seungryong Kim, Yonsei University, Seoul, Korea
clc; clear; close all;
run('..\Dependencies\vlfeat-0.9.20\toolbox\vl_setup');
run('..\Dependencies\matconvnet-1.0-beta25\matlab\vl_setupnn.m');
addpath('graphAnalysisToolbox-1.0');
addpath('Possion');
addpath('function');
addpath('model');

%% ------------------------------------------------
%% Parameter initialization
lambda = 10; 
lambda1 = 0.1;
lambda2 = 0.1;

%% ------------------------------------------------
%% Load the CNN model
% Trained models
% load('../Global_Depth_Network/data/depth-experiment/net-epoch-400.mat');
load('trained_models/depth-net.mat');
net_global = dagnn.DagNN.loadobj(net) ;
net_global.mode = 'test' ;
net_global.move('gpu');

% load('../Depth_Intrinsic_Gradient_Network/data/depth-intrinsic-gradient-experiment/net-epoch-400.mat');
load('trained_models/depth-intrinsic-gradient.mat');
net_gradient = dagnn.DagNN.loadobj(net) ;
net_gradient.mode = 'test' ;
net_gradient.move('gpu');

% load('../Gradient_Scale_Network/data/depth-gradient-scale-experiment/net-epoch-400.mat');
load('trained_models/depth-gradient-scale.mat');
net_depth_scale = dagnn.DagNN.loadobj(net) ;
net_depth_scale.mode = 'test' ;
net_depth_scale.move('gpu');

% load('../Gradient_Scale_Network/data/albedo-gradient-scale-experiment/net-epoch-400.mat');
load('trained_models/albedo-gradient-scale.mat');
net_albedo_scale = dagnn.DagNN.loadobj(net) ;
net_albedo_scale.mode = 'test' ;
net_albedo_scale.move('gpu');

% load('../Gradient_Scale_Network/data/shading-gradient-scale-experiment/net-epoch-400.mat');
load('trained_models/shading-gradient-scale.mat');
net_shading_scale = dagnn.DagNN.loadobj(net) ;
net_shading_scale.mode = 'test' ;
net_shading_scale.move('gpu');

% output prediction
depth_global_id = net_global.getVarIndex('pred');
net_global.vars(depth_global_id).precious = 1;

depth_gradient_id = net_gradient.getVarIndex('x11');
net_gradient.vars(depth_gradient_id).precious = 1;
albedo_gradient_id = net_gradient.getVarIndex('x12');
net_gradient.vars(albedo_gradient_id).precious = 1;
shading_gradient_id = net_gradient.getVarIndex('x13');
net_gradient.vars(shading_gradient_id).precious = 1;

depth_scale_id = net_depth_scale.getVarIndex('pred');
net_depth_scale.vars(depth_scale_id).precious = 1;
albedo_scale_id = net_albedo_scale.getVarIndex('pred');
net_albedo_scale.vars(albedo_scale_id).precious = 1;
shading_scale_id = net_shading_scale.getVarIndex('pred');
net_shading_scale.vars(shading_scale_id).precious = 1;

%% ------------------------------------------------
%% Load the image
im_input = double(imread('images/color.png'));
im_depth = double(imread('images/depth.png'));
im_albedo = double(imread('images/albedo.png'));
im_shading = double(imread('images/shading.png'));

im_input = imresize(im_input,[218,512]);
im_depth = imresize(im_depth,[218,512]);
im_albedo = imresize(im_albedo,[218,512]);
im_shading = imresize(im_shading,[218,512]);

%% ------------------------------------------------
%% Forward propagate the CNN
% global depth network
im_input_global = imresize(im_input,[218,512]);
inputs = {'data', gpuArray(single(im_input_global))};
net_global.eval(inputs);
depth_global_out = gather(net_global.vars(depth_global_id).value);
depth_global_out = reshape(depth_global_out,[13,32]);
depth_global_out = imresize(depth_global_out,[218,512]);

% depth/intrinsic gradient network
inputs = {'input', gpuArray(single(im_input))};
net_gradient.eval(inputs);
depth_gradient = gather(net_gradient.vars(depth_gradient_id).value);
albedo_gradient = gather(net_gradient.vars(albedo_gradient_id).value);
shading_gradient = gather(net_gradient.vars(shading_gradient_id).value);

% Depth and intrinsic gradient scale weight
im_input_scale = imresize(im_input,[218,512]);
im_input_scale = max(log(mat2gray(im_input_scale)),-2);
[dx,dy] = gradient(im_input_scale);
im_input_scale = single(cat(3,dx,dy));     

% depth weight
im_input_scale_depth = cat(3,im_input_scale,depth_gradient,albedo_gradient,shading_gradient);
inputs = {'input', gpuArray(single(im_input_scale_depth))};
net_depth_scale.eval(inputs);
depth_weight = gather(net_depth_scale.vars(depth_scale_id).value);

% albedo weight
im_input_scale_albedo = cat(3,im_input_scale,depth_gradient,albedo_gradient,shading_gradient);
inputs = {'input', gpuArray(single(im_input_scale_albedo))};
net_albedo_scale.eval(inputs);
albedo_weight = gather(net_albedo_scale.vars(albedo_scale_id).value);

% shading weight
im_input_scale_shading = cat(3,im_input_scale,depth_gradient,albedo_gradient,shading_gradient);
inputs = {'input', gpuArray(single(im_input_scale_shading))};
net_shading_scale.eval(inputs);
shading_weight = gather(net_shading_scale.vars(shading_scale_id).value);

%% ------------------------------------------------
%% Depth and intrinsic inference
% depth inference
depth_out = possion_solver(depth_global_out,depth_weight(:,:,2),depth_weight(:,:,1),depth_gradient(:,:,2),depth_gradient(:,:,1),lambda);

% albedo/shading inference
im_input_intrinsic = imresize(im_input,[218,512]);
im_input_intrinsic = max(log(mat2gray(im_input_intrinsic)),-2);

im_lum = mean(mat2gray(im_input_intrinsic),3);
im_lum = min(max(im_lum,0),1);
im_lum = min(max(im_lum*0.9999+0.0001,0),1);

for i = 1:3
    [albedo_out(:,:,i),shading_out(:,:,i)] = possion_solver_intrinsic(im_input_intrinsic(:,:,i),im_lum,...
        albedo_weight(:,:,i+3),albedo_weight(:,:,i),shading_weight(:,:,i+3),shading_weight(:,:,i),...
        albedo_gradient(:,:,i+3), albedo_gradient(:,:,i),shading_gradient(:,:,i+3), shading_gradient(:,:,i),lambda1,lambda2);
end

%% ------------------------------------------------
%% Visualization
figure; imshow(uint8(im_input)); colormap gray; title('color image');
figure; imshow(mat2gray(exp(depth_global_out))); colormap gray; title('global depth image');
figure; imshow(mat2gray(exp(depth_out))); colormap gray; title('global+gradient depth image');
figure; imshow(uint8(im_depth)); colormap gray; title('ground-truth depth image');
figure; imshow(mat2gray(exp(albedo_out))); title('albedo image');
figure; imshow(uint8(im_albedo)); colormap gray; title('ground-truth albedo image');
figure; imshow(mean(mat2gray(exp(shading_out)),3)); title('shading image');
figure; imshow(uint8(im_shading)); colormap gray; title('ground-truth shading image');

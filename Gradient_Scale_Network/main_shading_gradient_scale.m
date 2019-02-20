%% S. Kim et al., "Unified Depth Prediction and Intrinsic Image Decomposition 
%% from a Single Image via Joint Convolutional Neural Fields," ECCV, 2016.
%% script for learning shading-scale network
%% written by Seungryong Kim, Yonsei University, Seoul, Korea
function main_shading_gradient_scale(varargin)
    run('..\Dependencies\vlfeat-0.9.20\toolbox\vl_setup');
    run('..\Dependencies\matconvnet-1.0-beta25\matlab\vl_setupnn.m');
    addpath('function');

    load('data/imdb_gradient_scale.mat');

    net = init_intrinsic_gradient_scale();

    trainOpts.batchSize = 8;
    trainOpts.numEpochs = 400;
    trainOpts.continue = true;
    trainOpts.gpus = 1;
    trainOpts.learningRate = 1e-6;
    trainOpts.expDir = 'data/shading-gradient-scale-experiment';
    trainOpts = vl_argparse(trainOpts, varargin);

    [~,~] = cnn_train_dag(net, imdb, @getBatch, trainOpts);
end

function inputs = getBatch(imdb, batch)
% --------------------------------------------------------------------
    for i = 1:length(batch) 
        load(fullfile(imdb.images.data{batch(i)},'im_input1.mat'));
        load(fullfile(imdb.images.data{batch(i)},'im_label3.mat'));
        load(fullfile(imdb.images.data{batch(i)},'depth_gradient.mat'));
        load(fullfile(imdb.images.data{batch(i)},'albedo_gradient.mat'));
        load(fullfile(imdb.images.data{batch(i)},'shading_gradient.mat'));

        data(:,:,:,i) = cat(3,single(im_input1),single(depth_gradient),single(albedo_gradient),single(shading_gradient));
        label(:,:,:,i) = cat(3,single(im_label3),single(shading_gradient));
    end

    data = gpuArray(data);
    label = gpuArray(label);
    inputs = {'input', data, 'label', label};    
end


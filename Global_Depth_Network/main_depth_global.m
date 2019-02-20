%% S. Kim et al., "Unified Depth Prediction and Intrinsic Image Decomposition 
%% from a Single Image via Joint Convolutional Neural Fields," ECCV, 2016.
%% script for learning global depth network
%% written by Seungryong Kim, Yonsei University, Seoul, Korea
function main_depth_global(varargin)
    run('..\Dependencies\vlfeat-0.9.20\toolbox\vl_setup');
    run('..\Dependencies\matconvnet-1.0-beta25\matlab\vl_setupnn.m');
    addpath('function');

    load('data/imdb_depth.mat') ;

    net = init_depth_global() ;

    trainOpts.batchSize = 8;
    trainOpts.numEpochs = 400;
    trainOpts.continue = true;
    trainOpts.gpus = 1;
    trainOpts.learningRate = 1e-6;
    trainOpts.expDir = 'data/depth-experiment';
    trainOpts = vl_argparse(trainOpts, varargin);

    [~,~] = cnn_train_dag(net, imdb, @getBatch, trainOpts);
end

function inputs = getBatch(imdb, batch)
% --------------------------------------------------------------------
    for i = 1:length(batch) 
        im_input = imread(fullfile(imdb.images.data{batch(i)},'im_input.png'));
        im_label = imread(fullfile(imdb.images.data{batch(i)},'im_label.png'));
        im_label = max(log(mat2gray(im_label)),-2);    
        if rand() > 0.5
            data(:,:,:,i) = single(im_input);
            label(1,1,:,i) = single(im_label(:));
        else
            data(:,:,:,i) = single(fliplr(im_input));
            im_label = fliplr(im_label);
            label(1,1,:,i) = single(im_label(:));            
        end
    end

    data = gpuArray(data) ;
    label = gpuArray(label) ;
    inputs = {'data', data, 'label', label} ;   
end


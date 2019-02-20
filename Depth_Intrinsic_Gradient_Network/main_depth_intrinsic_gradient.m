%% S. Kim et al., "Unified Depth Prediction and Intrinsic Image Decomposition 
%% from a Single Image via Joint Convolutional Neural Fields," ECCV, 2016.
%% script for learning depth/intrinsic gradient network
%% written by Seungryong Kim, Yonsei University, Seoul, Korea
function main_depth_intrinsic_gradient(varargin)
    run('..\Dependencies\vlfeat-0.9.20\toolbox\vl_setup');
    run('..\Dependencies\matconvnet-1.0-beta25\matlab\vl_setupnn.m');
    addpath('function');

    load('data/imdb_depth_intrinsic_gradient.mat');

    net = init_depth_intrinsic_gradient();

    trainOpts.batchSize = 8;
    trainOpts.numEpochs = 400;
    trainOpts.continue = true;
    trainOpts.gpus = 1;
    trainOpts.learningRate = 1e-7;
    trainOpts.derOutputs = {'objective1',1,'objective2',1,'objective3',1};
    trainOpts.expDir = 'data/depth-intrinsic-gradient-experiment';
    trainOpts = vl_argparse(trainOpts,varargin);

    [~,~] = cnn_train_dag(net,imdb,@getBatch,trainOpts);
end

function inputs = getBatch(imdb, batch)
    % --------------------------------------------------------------------
    for i = 1:length(batch) 
        im_input = imread(fullfile(imdb.images.data{batch(i)},'im_input.png'));
        im_label1 = imread(fullfile(imdb.images.data{batch(i)},'im_label1.png'));
        im_label2 = imread(fullfile(imdb.images.data{batch(i)},'im_label2.png'));
        im_label3 = imread(fullfile(imdb.images.data{batch(i)},'im_label3.png'));
        
        im_label1 = mat2gray(im_label1);
        im_label1 = max(log(im_label1),-2);
        im_label2 = mat2gray(im_label2);
        im_label2 = max(log(im_label2),-2);
        im_label3 = mat2gray(im_label3);
        im_label3 = max(log(im_label3),-2);
        
        if rand() > 0.5
            im_input = fliplr(im_input);
            im_label1 = fliplr(im_label1);
            im_label2 = fliplr(im_label2);    
            im_label3 = fliplr(im_label3);
        end

        [dx,dy] = gradient(im_label1);
        im_label1 = cat(3,dx,dy);
        [dx,dy] = gradient(im_label2);
        im_label2 = cat(3,dx,dy);
        [dx,dy] = gradient(im_label3);
        im_label3 = cat(3,dx,dy);

        data(:,:,:,i) = single(im_input);
        label1(:,:,:,i) = single(im_label1);
        label2(:,:,:,i) = single(im_label2);
        label3(:,:,:,i) = single(im_label3);
    end
    data = gpuArray(data);
    label1 = gpuArray(label1);
    label2 = gpuArray(label2);
    label3 = gpuArray(label3);
    inputs = {'input',data,'label1',label1,'label2',label2,'label3',label3};
end











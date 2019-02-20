clc; clear; close all;
%% settings
folder_data{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\alley_1';
folder_data{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\alley_2';
folder_data{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bamboo_1';
folder_data{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bamboo_2';
folder_data{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bandage_1';
folder_data{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bandage_2';
folder_data{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\cave_2';
folder_data{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\cave_4';
folder_data{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_2';
folder_data{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_5';
folder_data{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_6';
folder_data{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\mountain_1';
folder_data{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\shaman_2';
folder_data{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\shaman_3';
folder_data{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\sleeping_1';
folder_data{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\sleeping_2';
folder_data{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\temple_2';
folder_data{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\temple_3';

folder_label{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\alley_1';
folder_label{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\alley_2';
folder_label{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bamboo_1';
folder_label{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bamboo_2';
folder_label{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bandage_1';
folder_label{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bandage_2';
folder_label{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\cave_2';
folder_label{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\cave_4';
folder_label{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_2';
folder_label{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_5';
folder_label{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_6';
folder_label{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\mountain_1';
folder_label{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\shaman_2';
folder_label{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\shaman_3';
folder_label{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\sleeping_1';
folder_label{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\sleeping_2';
folder_label{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\temple_2';
folder_label{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\temple_3';

folder_label1{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\alley_1';
folder_label1{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\alley_2';
folder_label1{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\bamboo_1';
folder_label1{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\bamboo_2';
folder_label1{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\bandage_1';
folder_label1{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\bandage_2';
folder_label1{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\cave_2';
folder_label1{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\cave_4';
folder_label1{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\market_2';
folder_label1{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\market_5';
folder_label1{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\market_6';
folder_label1{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\mountain_1';
folder_label1{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\shaman_2';
folder_label1{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\shaman_3';
folder_label1{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\sleeping_1';
folder_label1{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\sleeping_2';
folder_label1{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\temple_2';
folder_label1{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\albedo\temple_3';

folder_label2{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\alley_1';
folder_label2{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\alley_2';
folder_label2{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\bamboo_1';
folder_label2{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\bamboo_2';
folder_label2{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\bandage_1';
folder_label2{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\bandage_2';
folder_label2{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\cave_2';
folder_label2{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\cave_4';
folder_label2{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\market_2';
folder_label2{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\market_5';
folder_label2{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\market_6';
folder_label2{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\mountain_1';
folder_label2{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\shaman_2';
folder_label2{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\shaman_3';
folder_label2{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\sleeping_1';
folder_label2{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\sleeping_2';
folder_label2{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\temple_2';
folder_label2{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\shading\temple_3';

%% initialization
count = 0;

for ii = 1:18
    fprintf('image sequence: %d\n',ii);
    
    %% generate data
    filepaths_data = dir(fullfile(folder_data{ii},'*.png'));
    filepaths_label = dir(fullfile(folder_label{ii},'*.png'));
    filepaths_label1 = dir(fullfile(folder_label1{ii},'*.png'));
    filepaths_label2 = dir(fullfile(folder_label2{ii},'*.png'));

    for i = 1:length(filepaths_data)    
        count=count+1;
        
        im_input = double(imread(fullfile(folder_data{ii},filepaths_data(i).name)));
        im_label1 = double(imread(fullfile(folder_label{ii},filepaths_label(i).name)));
        im_label2 = double(imread(fullfile(folder_label1{ii},filepaths_label1(i).name)));
        im_label3 = double(imread(fullfile(folder_label2{ii},filepaths_label2(i).name)));
        
        im_input = imresize(im_input,[218,512]);
        im_label1 = imresize(im_label1,[218,512]);
        im_label2 = imresize(im_label2,[218,512]);
        im_label3 = imresize(im_label3,[218,512]);
        
        im_input1 = mat2gray(im_input);
        im_input1 = max(log(im_input1),-2);

        im_label1 = mat2gray(im_label1);
        im_label1 = max(log(im_label1),-2);

        im_label2 = mat2gray(im_label2);
        im_label2 = max(log(im_label2),-2);
        
        im_label3 = mat2gray(im_label3);
        im_label3 = max(log(im_label3),-2);        
        
        [Gmag,Gdir] = imgradient(im_label1);
        [hei,wid,~] = size(im_label1);
                    
        [dx,dy] = gradient(im_input1);
        im_input1 = single(cat(3,dx,dy)); 
        [dx,dy] = gradient(im_label1);
        im_label1 = single(cat(3,dx,dy));
        [dx,dy] = gradient(im_label2);
        im_label2= single(cat(3,dx,dy));
        [dx,dy] = gradient(im_label3);
        im_label3 = single(cat(3,dx,dy));
                
        %% Load the pre-trained CNN model
        load('../Depth_Intrinsic_Gradient_Network/data/depth-intrinsic-gradient-experiment/net-epoch-400.mat');
        net_gradient = dagnn.DagNN.loadobj(net);
        net_gradient.mode = 'test';
        net_gradient.move('gpu');

        depth_gradient_id = net_gradient.getVarIndex('x11');
        net_gradient.vars(depth_gradient_id).precious = 1;
        albedo_gradient_id = net_gradient.getVarIndex('x12');
        net_gradient.vars(albedo_gradient_id).precious = 1;
        shading_gradient_id = net_gradient.getVarIndex('x13');
        net_gradient.vars(shading_gradient_id).precious = 1;
        
        % depth/intrinsic gradient network
        inputs = {'input', gpuArray(single(im_input))};
        net_gradient.eval(inputs);
        depth_gradient = gather(net_gradient.vars(depth_gradient_id).value);
        albedo_gradient = gather(net_gradient.vars(albedo_gradient_id).value);
        shading_gradient = gather(net_gradient.vars(shading_gradient_id).value);
        
        dataPath = 'data\DB_MPI_SINTEL_Gradient_Scale';
        save_folder_name = sprintf('%d',count);
        mkdir(fullfile(dataPath,save_folder_name));
        save(fullfile(fullfile(dataPath,save_folder_name),'im_input1.mat'),'im_input1');
        save(fullfile(fullfile(dataPath,save_folder_name),'im_label1.mat'),'im_label1');
        save(fullfile(fullfile(dataPath,save_folder_name),'im_label2.mat'),'im_label2');
        save(fullfile(fullfile(dataPath,save_folder_name),'im_label3.mat'),'im_label3');        
        save(fullfile(fullfile(dataPath,save_folder_name),'depth_gradient.mat'),'depth_gradient');
        save(fullfile(fullfile(dataPath,save_folder_name),'albedo_gradient.mat'),'albedo_gradient');
        save(fullfile(fullfile(dataPath,save_folder_name),'shading_gradient.mat'),'shading_gradient');
        data{count} = fullfile(dataPath,save_folder_name);                  
    end
end

order = randperm(count);
data = data(:,order);

imdb = struct;
imdb.images.data = data;
imdb.images.set = single(ones(1,length(data)));
imdb.images.set(1,880+1:end) = 2;
save('data/imdb_gradient_scale.mat','imdb','-v7.3');
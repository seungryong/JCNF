clc; clear; close all;
%% settings
folder_data{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\alley_1';
folder_data{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\alley_2';
folder_data{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\ambush_2';
folder_data{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\ambush_4';
folder_data{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\ambush_5';
folder_data{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\ambush_6';
folder_data{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\ambush_7';
folder_data{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bamboo_1';
folder_data{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bamboo_2';
folder_data{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bandage_1';
folder_data{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\bandage_2';
folder_data{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\cave_2';
folder_data{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\cave_4';
folder_data{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_2';
folder_data{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_5';
folder_data{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\market_6';
folder_data{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\mountain_1';
folder_data{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\shaman_2';
folder_data{19} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\shaman_3';
folder_data{20} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\sleeping_1';
folder_data{21} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\sleeping_2';
folder_data{22} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\temple_2';
folder_data{23} = '..\Dataset\MPI-Sintel\MPI-Sintel-training_images\training\clean\temple_3';

folder_label{1} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\alley_1';
folder_label{2} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\alley_2';
folder_label{3} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\ambush_2';
folder_label{4} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\ambush_4';
folder_label{5} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\ambush_5';
folder_label{6} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\ambush_6';
folder_label{7} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\ambush_7';
folder_label{8} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bamboo_1';
folder_label{9} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bamboo_2';
folder_label{10} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bandage_1';
folder_label{11} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\bandage_2';
folder_label{12} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\cave_2';
folder_label{13} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\cave_4';
folder_label{14} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_2';
folder_label{15} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_5';
folder_label{16} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\market_6';
folder_label{17} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\mountain_1';
folder_label{18} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\shaman_2';
folder_label{19} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\shaman_3';
folder_label{20} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\sleeping_1';
folder_label{21} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\sleeping_2';
folder_label{22} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\temple_2';
folder_label{23} = '..\Dataset\MPI-Sintel\MPI-Sintel-stereo-training-20150305\training\disparities_viz\temple_3';


%% initialization
count = 0;

for ii = 1:23
    
    %% generate data
    filepaths_data = dir(fullfile(folder_data{ii},'*.png'));
    filepaths_label = dir(fullfile(folder_label{ii},'*.png'));

    for i = 1:length(filepaths_data)    
        count = count+1;
        
        im_input = imread(fullfile(folder_data{ii},filepaths_data(i).name));        
        [hei,wid,z] = size(im_input);
        im_label = double(imread(fullfile(folder_label{ii},filepaths_label(i).name)));
        
        im_input = imresize(im_input,[218,512]);
        im_label = imresize(im_label,[13,32]);

        dataPath = 'data\DB_MPI_SINTEL_Global_Depth';
        save_folder_name = sprintf('%d',count);
        mkdir(fullfile(dataPath,save_folder_name));
        imwrite(uint8(im_input),fullfile(fullfile(dataPath,save_folder_name),'im_input.png'));
        imwrite(uint8(im_label),fullfile(fullfile(dataPath,save_folder_name),'im_label.png'));
        data{count} = fullfile(dataPath,save_folder_name);  
    end
end

order = randperm(count);
data = data(:,order);

imdb = struct;
imdb.images.data = data;
imdb.images.set = single(ones(1,length(data)));
imdb.images.set(1,1024+1:end) = 2;
save('data/imdb_depth.mat','imdb','-v7.3');

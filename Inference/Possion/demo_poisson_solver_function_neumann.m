%% Example
image = im2double(rgb2gray(imread('img0001.png')));
figure; imshow(image);
[gx,gy] = gradient(image);
rimage = poisson_solver_function_neumann(gx, gy);
rimage = mat2gray(rimage);
figure; imshow(rimage);

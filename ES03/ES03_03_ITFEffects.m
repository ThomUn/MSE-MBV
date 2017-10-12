clear all;

% Add noise with http://pinetools.com/add-noise-image 
% 50% Amount of noise
% 50% Strength of noise

%% read original image
IM_original = imread('castle.jpg');


%% read image with noise
IM_effect = imread('castle-noise.jpg'); 

%% show original image
subplot(4,2,1);
imshow(IM_original);
title('Original image');

%% show image with effect
subplot(4,2,2);
imshow(IM_effect);
title('Image with effect');

%% show histogram of original image
subplot(4,2,3);
imhist(IM_original);
title('Histogram of original image');

%% show histogram of image with effect
subplot(4,2,4);
imhist(IM_effect);
title('Histogram of image with effect');

%% use medfilt2 for each channel
red = medfilt2(IM_effect(:, :, 1), [3 3]);
green = medfilt2(IM_effect(:, :, 2), [3 3]);
blue = medfilt2(IM_effect(:, :, 3), [3 3]);

%% combine the 3 RGB channels to one "noise free" picture
IM_effect = cat(3, red, green, blue);

%% show restored image
subplot(4,2,5);
imshow(IM_effect);
title('Restored image');

%% add noise to picture
IM_noise = imnoise(IM_original, 'salt & pepper', 0.09);

%% show approximated effect image
subplot(4,2,6);
imshow(IM_noise);
title('Approximated effect image');

%% show histogram of approximated effect image
subplot(4,2,8);
imhist(IM_noise);
title('Histogram of approximated effect image ');


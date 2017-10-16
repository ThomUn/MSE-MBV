clear all;

% Read image
IM = rgb2gray(imread('ES04/castle.jpg'));

% Apply 1.level of gaussian noise to image
figure(1);
subplot(3,2,1);
IMg = imnoise(IM,'gaussian', 0.01);
imshow(IMg);
title('1. Gaussian noise 0.01');

% Apply 1.level of salt & pepper noise to image
IMsp = imnoise(IM, 'salt & pepper', 0.01);
subplot(3,2,2);
imshow(IMsp);
title('1. Salt & Pepper 0.01');

% Apply 2.level of gaussian noise to image
IMg = imnoise(IM,'gaussian', 0.5);
subplot(3,2,3);
imshow(IMg);
title('2. Gaussian noise 0.5');

% Apply 2.level of salt & pepper noise to image
IMsp = imnoise(IM, 'salt & pepper', 0.5);
subplot(3,2,4);
imshow(IMsp);
title('2. Salt & Pepper 0.5');

% Apply 3.level of gaussian noise to image
IMg = imnoise(IM,'gaussian', 0.2);
subplot(3,2,5);
imshow(IMg);
title('3. Gaussian noise  0.2');

% Apply 3.level of salt & pepper noise to image
IMsp = imnoise(IM, 'salt & pepper', 0.2);
subplot(3,2,6);
imshow(IMsp);
title('3. Salt & Pepper 0.2');

%% Noise removal
%--------------------------------------------------------------------------
figure('name', 'Average Filter');
subplot(2,2,1);
imshow(IM);
title('Original image');

IM_noise_sp = imnoise(IM, 'salt & pepper', 0.01); 
IM_noise_g = imnoise(IM, 'gaussian', 0.01); 

% Averaging
average = fspecial('average',3);

IM_gaussian_sp = imfilter(IM_noise_sp, average);
subplot(2,2,2);
imshow(IM_gaussian_sp);
title('Averaged s&p image');

IM_gaussian_g = imfilter(IM_noise_g, average);
subplot(2,2,3);
imshow(IM_gaussian_g);
title('Averaged gaussian image');

IM_gaussian = imfilter(IM, average);
subplot(2,2,4);
imshow(IM_gaussian);
title('Averaged original image');

%--------------------------------------------------------------------------
figure('name', 'Gaussian blurring filter');
subplot(2,2,1);
imshow(IM);
title('Original image');

% Gaussian Blurring
h = fspecial('gaussian',10,10);

IM_gaussian_sp = imfilter(IM_noise_sp, h);
subplot(2,2,2);
imshow(IM_gaussian_sp);
title('Gaussian blurring s&p image');

IM_gaussian_g = imfilter(IM_noise_g, h);
subplot(2,2,3);
imshow(IM_gaussian_g);
title('Gaussian blurring gaussian image');

IM_gaussian = imfilter(IM, h);
subplot(2,2,4);
imshow(IM_gaussian);
title('Gaussian blurring original image');

%--------------------------------------------------------------------------
figure('name', 'Median filter');
subplot(2,2,1);
imshow(IM);
title('Original image');

% Median filtering
IM_medfilt2_sp = medfilt2(IM_noise_sp);
subplot(2,2,2);
imshow(IM_medfilt2_sp);
title('Median filtered s&p image');

IM_medfilt2_g = medfilt2(IM_noise_g);
subplot(2,2,3);
imshow(IM_medfilt2_g);
title('Median filtered gaussian image');

IM_medfilt2 = medfilt2(IM);
subplot(2,2,4);
imshow(IM_medfilt2);
title('Median filtered original image');

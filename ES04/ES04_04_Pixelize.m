clear all;

%% Read image
%IM = rgb2gray(imread('castle.jpg'));
IM = rgb2gray(imread('ramsay.jpg'));

%% Choose area to pixelize
mask = roipoly(IM);

%% Apply pixelize function to image
IM_new = pixelize(IM, 5, mask);

%% Display image
figure(1);
subplot(1,2,1);
imshow(IM);
title('Orignal image');

subplot(1,2,2);
imshow(IM_new);
title('Pixelized image');

%% Pixelize function
function IM_new = pixelize(image, pixelsize, mask)
    fun = @(x) uint8(ones(size(x))).*mean(x(:));
    IM_new = blkproc(image, [pixelsize pixelsize], fun);
    IM_new(~mask) = image(~mask);
end
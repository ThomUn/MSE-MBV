clear all;

%% Read image and convert to gray
%IM = rgb2gray(imread('ramsay.jpg'));
IM = rgb2gray(imread('beans.jpg'));

%% Median function --------------------------------------------------------
% Show original
figure(1);
subplot(1,3,1);
imshow(IM);
title('Original image')

% Show 10x10 median function
subplot(1,3,2);
imshow(medianFunction(IM, 10));
title('10x10 median image');

% Show 15x15 median function
subplot(1,3,3);
imshow(medianFunction(IM, 15));
title('15x15 median image');

%% Rotating mask function --------------------------------------------------------
figure(2);
subplot(1,2,1);
imshow(IM);
title('Original image')

subplot(1,2,2);
imshow(rotate(IM, 10, 10));
title('Rotating mask image');

%% Contrast function ------------------------------------------------------
% Show original image
figure(3);
subplot(1,3,1);
imshow(IM);
title('Original image');

% Show 5x5 contract image
subplot(1,3,2);
imshow(contrast(IM, 5));
title('5x5 contrast image');

% Show 10x10 contract image
subplot(1,3,3);
imshow(contrast(IM, 10));
title('10x10 contrast image');

%% Median function
function IM = medianFunction(image, effectSize)
    fun = @(x) median(x(:));
    IM = nlfilter(image, [effectSize effectSize], fun);
end

%% Rotating mask function
 function [img] = rotate(img, filterSize, rotatingSize)
    rotatingFun = @(x) rotatingBlockCalculation(x,rotatingSize);
    img = nlfilter(img, [filterSize filterSize], rotatingFun);
 end
function [value] = rotatingBlockCalculation(x, size)  
    % Apply function to get the variation of the block
    lowestVariationFun = @(y) var(double(y(:)));    
    rotatingBlockVariation = uint8(blkproc(x, [size size], lowestVariationFun));
    
    % Get index of lowest variation
    [rotatingBlockVar,indexOfLowestVariation] = min(rotatingBlockVariation);

    % Apply function to get mean of block
    meanFun = @(y) mean(double(y(:)));    
    rotatingBlockMean = uint8(blkproc(x, [size size], meanFun));

    % Set value to the index of the lowest mean
    value = uint8(rotatingBlockMean(indexOfLowestVariation));  
end 

%% Contrast function
function IM = contrast(image, effectSize)
    fun = @(x) max(x(:)) - min(x(:));
    IM = nlfilter(image, [effectSize effectSize], fun);
end
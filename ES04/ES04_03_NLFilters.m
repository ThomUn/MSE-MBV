clear all;

%% Read image and convert to gray
IM = rgb2gray(imread('ramsay.jpg'));

%% Median function --------------------------------------------------------
% Show original
figure(1);
subplot(1,3,1);
imshow(IM);
title('Original')

% Show 10x10 median function
subplot(1,3,2);
imshow(medianFunction(IM, 10));
title('10x10 median');

% Show 15x15 median function
subplot(1,3,3);
imshow(medianFunction(IM, 15));
title('15x15 median');

%% Rotate function --------------------------------------------------------
figure(2);
subplot(1,3,1);
imshow(IM);
title('Original')

subplot(1,3,2);
imshow(rotate2(IM, 3));
title('rotate');

%% Contrast function ------------------------------------------------------
% Show original image
figure(3);
subplot(1,3,1);
imshow(IM);
title('original');

% Show 5x5 contract image
subplot(1,3,2);
imshow(contrast(IM, 5));
title('5x5 contrast');

% Show 10x10 contract image
subplot(1,3,3);
imshow(contrast(IM, 10));
title('10x10 contrast');

%% Median function
function IM = medianFunction(image, effectSize)
    fun = @(x) median(x(:));
    IM = nlfilter(image, [effectSize effectSize], fun);
end

%% Rotate function -> not working
%function IM = rotate(image, effectSize)
%    meanHandle = @(x) mean2(x(:));
%    varianceHandle = @(x) var(nlfilter(image, [effectSize effectSize], meanHandle));
%    minHandle = @(x) min(nlfilter(image, [effectSize effectSize], varianceHandle));
%    IM = nlfilter(image, [effectSize effectSize], minHandle);
%end

 function [img] = rotate(img,filterSize,rotatingSize)
    rotatingAynFunc = @(x) roatatingBlockCalc(x,rotatingSize);
    img = nlfilter(img, [filterSize filterSize], rotatingAynFunc);
end

function [value] = roatatingBlockCalc(x,size)  
    %%% Get Index of Block with the least Standard Devitation
    stdAynFunc = @(y) std(double(y(:)));    
    rotatingBlocksStd = uint8(blkproc(x, [size size], stdAynFunc));
    % Convert to one dimension
    rotatingBlocksStd = rotatingBlocksStd(:);
    % Get Index
    [rBStd,indexMinStd] = min(rotatingBlocksStd);

    %%% Get Mean of Rotating Blocks
    meanAynFunc = @(y) mean(double(y(:)));    
    rotatingBlocksMean = uint8(blkproc(x, [size size], meanAynFunc));

    %%% Value is Rotating Block with the least Standard Devitation (by index)
    value = uint8(rotatingBlocksMean(indexMinStd));  
end 

%% Contrast function
function IM = contrast(image, effectSize)
    fun = @(x) max(x(:)) - min(x(:));
    IM = nlfilter(image, [effectSize effectSize], fun);
end
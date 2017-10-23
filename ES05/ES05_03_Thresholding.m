%Compare and evaluate the following thresholding methods:
%a. Otsu (MATLAB built in)
%b. Iterative optimal thresholding
%c. A mode method
%Compare and evaluate them for the images
%a. Cameraman
%b. Page
%c. Ean
%When evaluating, use a human-generated ground truth. That means manually threshold the images
%yourself and compare the results of the automatic methods to your results.
%For each image, create a neat figure that displays
%• original image
%• segmented images
%• interesting stats (e.g. percentage object pixles, comparison to ground truth)
%Include a conclusion.
clear all;

%% Read images
IM_cameraman = imread('cameraman.tif');
IM_ean = rgb2gray(imread('PICS/ean.jpg'));
IM_page = rgb2gray(imread('PICS/page.jpg'));

%% cameraman.tif
level = graythresh(IM_cameraman);
IM_otsu = imbinarize(IM_cameraman,level);
[IM_iot, optimalThreshold] = IterativeOptimalThreshold(IM_cameraman);
[IM_mode, mode_level]= ModeMethod(IM_cameraman);

% Self evaluated
self_level = 0.31;
IM_self = imbinarize(IM_cameraman, self_level);

figure(1);
subplot(2,3,1); imshow(IM_cameraman); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
%TODO
subplot(2,3,6); diplayStats(IM_iot, IM_cameraman); title('Stats');

%% ean.jpg
level = graythresh(IM_ean);
IM_otsu = imbinarize(IM_ean,level);
[IM_iot, optimalThreshold] = IterativeOptimalThreshold(IM_ean);
[IM_mode, mode_level]= ModeMethod(IM_ean);

% Self evaluated
self_level = 0.8;
IM_self = imbinarize(IM_ean, self_level);

figure(2);
subplot(2,3,1); imshow(IM_ean); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
%TODO
subplot(2,3,6); diplayStats(IM_iot, IM_ean); title('Stats');

%% page.jpg
level = graythresh(IM_page);
IM_otsu = imbinarize(IM_page,level);
IM_iot = IterativeOptimalThreshold(IM_page);
IM_mode = ModeMethod(IM_page);

% Self evaluated
self_level = 0.25;
IM_self = imbinarize(IM_page, self_level);

figure(3);
subplot(2,3,1); imshow(IM_page); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
%TODO
subplot(2,3,6); diplayStats(IM_iot, IM_page); title('Stats');

%% Conclusion

%% Functions
function [IM_new, result] = ModeMethod(IM)
    [counts] = imhist(IM);

    size = 5;
    mask = linspace(1/size, 1/size, size);
    counts = conv(counts, mask, 'same');
    
    maxima{1} = [0, 1];
    maxima{2} = [0, 1];
    
    for i = 2:254
        if (counts(i-1) < counts(i) && counts(i+1) < counts(i))
           if (counts(i) >  maxima{1}(1))
               maxima{1} = [counts(i), i];
           elseif (counts(i) > maxima{2}(1))
               maxima{2} = [counts(i), i];
           end
        end
    end
    
    result = ((maxima{1}(2) + maxima{2}(2)) / 2) / 256;
    IM_new = imbinarize(IM, result);
end

function diplayStats(IM, IM_original) 
    %imshow(IM_original);
    cb = sum(IM(:));
    labels = {'Black','White'};
    pie([cb, 100], labels);
end
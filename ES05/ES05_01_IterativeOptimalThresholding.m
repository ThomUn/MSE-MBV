clear all;

%% 1. abstergo logo----------------------------------------------------------------
IM = rgb2gray(imread('PICS/abstergo.jpg'));
figure(1);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = applyIterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ',num2str(optimalThreshold)]);

%% 2. coins----------------------------------------------------------------
IM = rgb2gray(imread('PICS/coins2.jpg'));
figure(2);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = applyIterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ',num2str(optimalThreshold)]);

%% 3. coins----------------------------------------------------------------
IM = rgb2gray(imread('PICS/coins3.jpg'));
figure(3);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = applyIterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ',num2str(optimalThreshold)]);

%% 4. twitter logo---------------------------------------------------------

IM = rgb2gray(imread('PICS/twitter.jpg'));
figure(4);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = applyIterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ',num2str(optimalThreshold)]);

%% 5. pigeon---------------------------------------------------------------
IM = rgb2gray(imread('PICS/pigeon.jpg'));
figure(5);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = applyIterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ',num2str(optimalThreshold)]);

%% Function to find optimal threshold
function [newImage, optimalThreshold] = applyIterativeOptimalThreshold(IM)
    backgroundValues = getCornerValues(IM);

    % Calc mean of background
    backgroundMeanWithouThreshold = mean(backgroundValues);

    %Set first Threshold as mean of background
    tresholdIterator = 1;
    treshold(tresholdIterator) = backgroundMeanWithouThreshold;

    %Get mean of Background with Treshold
    backgroundWithTreshold = backgroundValues <= treshold(tresholdIterator); 
    meanOfBackground = mean(backgroundValues(backgroundWithTreshold));

    %Get mean of Foreground with Treshold
    foregroundVector = getForegroundValues (IM);
    foregroundWithTreshold = foregroundVector > treshold(tresholdIterator);
    meanOfForeground = mean(foregroundVector(foregroundWithTreshold));

    %Get new Treshold
    tresholdIterator = tresholdIterator + 1;
    treshold(tresholdIterator) = (meanOfBackground + meanOfForeground)./2;

    while treshold(tresholdIterator) ~= treshold(tresholdIterator - 1)
        %Get mean of Background with Treshold
        backgroundWithTreshold = backgroundValues <= treshold(tresholdIterator); 
        meanOfBackground = mean(backgroundValues(backgroundWithTreshold));

        %Get mean of Foreground with Treshold
        foregroundVector = getForegroundValues (IM);
        foregroundWithTreshold = foregroundVector > treshold(tresholdIterator);
        meanOfForeground = mean(foregroundVector(foregroundWithTreshold));

        %Get new Treshold
        tresholdIterator = tresholdIterator + 1;
        treshold(tresholdIterator) = (meanOfBackground + meanOfForeground)./2;
    end

    optimalThreshold = treshold(tresholdIterator)./256;
    newImage = imbinarize(IM, optimalThreshold);
end

%% Function to get corner values for start
function cornerValues = getCornerValues(image)
    numberOfRows = size(image, 1);
    numberOfColumns = size(image, 2);
    
    cornerLT = image(1,1);
    cornerRT = image(1,numberOfColumns);
    cornerLB = image(numberOfRows, 1);
    cornerRB = image(numberOfRows, numberOfColumns);
    
    cornerValues = [cornerLT, cornerRT, cornerLB, cornerRB];
end

function allValuesExceptCorners = getForegroundValues(image)
    numberOfRows = size(image, 1);
    numberOfColumns = size(image, 2);
    
    firstColumnWithoutCorners = image([2:numberOfRows-1], 1);
    lastColumnWithoutCorners = image([2:numberOfRows-1], numberOfColumns);
    allOtherValues = image([2:numberOfRows-1], [2:numberOfColumns-1]);
    
    newMatrix = cat(2, firstColumnWithoutCorners,allOtherValues, lastColumnWithoutCorners);
    
    allValuesExceptCorners = reshape(newMatrix,1,[]);
end




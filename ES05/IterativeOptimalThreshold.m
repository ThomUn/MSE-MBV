%% Function to find optimal threshold
function [newImage, optimalThreshold] = IterativeOptimalThreshold(IM)
    backgroundValues = getCornerValues(IM);

    % Set first threshold to mean of background
    thresholdIterator = 1;
    threshold(thresholdIterator) = mean(backgroundValues);

    % Get mean of background with applied threshold
    backgroundWithThreshold = backgroundValues <= threshold(thresholdIterator); 
    meanOfBackground = mean(backgroundValues(backgroundWithThreshold));

    % Get mean of foreground with applied threshold
    foregroundVector = getForegroundValues (IM);
    foregroundWithThreshold = foregroundVector > threshold(thresholdIterator);
    meanOfForeground = mean(foregroundVector(foregroundWithThreshold));

    % Get new threshold
    thresholdIterator = thresholdIterator + 1;
    threshold(thresholdIterator) = (meanOfBackground + meanOfForeground)./2;

    % Search for new optimal threshold
    % Repeat until T(t+1) = T(t)
    while threshold(thresholdIterator) ~= threshold(thresholdIterator - 1)
        % Get mean of background with applied threshold
        backgroundWithThreshold = backgroundValues <= threshold(thresholdIterator); 
        meanOfBackground = mean(backgroundValues(backgroundWithThreshold));

        % Get mean of foreground with applied threshold
        foregroundVector = getForegroundValues (IM);
        foregroundWithThreshold = foregroundVector > threshold(thresholdIterator);
        meanOfForeground = mean(foregroundVector(foregroundWithThreshold));

        % Get new threshold
        thresholdIterator = thresholdIterator + 1;
        threshold(thresholdIterator) = (meanOfBackground + meanOfForeground)./2;
    end

    % Get optimal threshold divided by the maximum of values
    optimalThreshold = threshold(thresholdIterator)./255;
    
    % Apply optimalThreshold to image
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

%% Function to get foreground values
function allValuesExceptCorners = getForegroundValues(image)
    numberOfRows = size(image, 1);
    numberOfColumns = size(image, 2);
    
    firstColumnWithoutCorners = image([2:numberOfRows-1], 1);
    lastColumnWithoutCorners = image([2:numberOfRows-1], numberOfColumns);
    allOtherValues = image([2:numberOfRows-1], [2:numberOfColumns-1]);
    
    newMatrix = cat(2, firstColumnWithoutCorners,allOtherValues, lastColumnWithoutCorners);
    
    allValuesExceptCorners = reshape(newMatrix,1,[]);
end
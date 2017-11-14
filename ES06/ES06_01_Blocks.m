%Block-Counting
%Develop and implement a method to detect the number of blocks in the BLOCKS\_\*.jpg images.
%MATLAB’s bwabeln and regionprop might help in counting and/or classifying.
%See Figure3 for help in setting up the processing stept – other ways are possible and welcome!
%Requirements:
%DONE 1. a function that accepts an image and returns the total number of blocks in the image
%DONE 2. a function that accepts an image and returns the total number of blocks for each color in the image
%DONE 3. a function that accepts an image and returns the total number of blocks for each shape in the image
%DONE 4. a function that accepts an image and returns the total number of blocks for each color and
%shape in the image and bounding boxes for all blocks. A script that produces figures of the
%results (of all sample images) with recognized shapes highlighted in the image(s) using the
%information returned by the above function(s)

clear all;
warning('off', 'all');

%% Read different images
IM_block = imread('BLOCKS/BLOCKS_001.jpg');
%IM_block = imread('BLOCKS/BLOCKS_002.jpg');
%IM_block = imread('BLOCKS/BLOCKS_003.jpg');
%IM_block = imread('BLOCKS/BLOCKS_004.jpg');

%% Requirement 1 ----------------------------------------------------------
disp(['NumberOfBlocks:', char(9), num2str(GetNumberOfBlocks(IM_block))]);

%% Requirement 2 ----------------------------------------------------------
resultOfColors = GetNumberOfBlocksForEachColor(IM_block);
disp('NumberOfBlocksForEachColor:');
disp(['- Red blocks:', char(9), num2str(resultOfColors{1}(1))]); 
disp(['- Green blocks:', char(9), num2str(resultOfColors{2}(1))]);
disp(['- Blue blocks:', char(9), num2str(resultOfColors{3}(1))]);

%% Requirement 3 ----------------------------------------------------------
resultOfShapes = GetNumberOfBlocksForEachShape(IM_block);
disp('NumberOfBlocksForEachShape:');
disp(['- Circle shapes:', char(9), num2str(resultOfShapes{1}(1))]); 
disp(['- Rectangle shapes:', char(9), num2str(resultOfShapes{2}(1))]);

%% Requirement 4 ----------------------------------------------------------
boxesForImage = GetNumberOfColorAndShapeAndBoundingBox(IM_block);
plotBoundingBoxesAndLabels(IM_block, boxesForImage);

%% Script for plotting the figures
plotFigures(IM_block)


%% Function for labeling the image
function void = plotBoundingBoxesAndLabels(IM_block, boxesForImage)
    figure(1);
    imshow(IM_block);
    hold on;
    % Iterate over results and plot  them
    for i = 1:size(boxesForImage, 2)
        
        % Get values of result
        boxCenter = boxesForImage{i}{1};
        boundingBoxValues = boxesForImage{i}{3};
        
        % Plot the rectangle and according text
        rectangle('Position', boundingBoxValues, 'EdgeColor', 'r', 'LineWidth', 3);
        plot(boxCenter(1), boxCenter(2))
        str = text(boxCenter(1), boxCenter(2), boxesForImage{i}{2});
        set(str, 'FontName', 'Arial', 'FontSize', 12, 'Color', 'black');
        hold on;
    end
end

%% Function for plotting the figures and diagrams
function void = plotFigures(IM_block)
    IM_block_gray = rgb2gray(IM_block);

    figure(2);
    % 1. Show original image
    subplot(3,3,1); imshow(IM_block); title('original color');

    % 2. Show gray image
    subplot(3,3,2); imshow(IM_block_gray); title('original gray');
    
    % 3. Plot cumhist
    subplot(3,3,3); imhist(IM_block_gray); title('threshold');

    % 4. Plot thresholded image
    [threshold, EM] = graythresh(IM_block_gray);
    thresholdedImage = imbinarize(IM_block_gray, threshold);
    subplot(3,3,4); imshow(~thresholdedImage); title('threshold');
    
    % 5. Plot morphed image
    thresholdedImage = bwmorph(~ thresholdedImage, 'dilate', 20);
    thresholdedImage = bwmorph(thresholdedImage, 'erode', 40);
    subplot(3,3,5); imshow(thresholdedImage); title('morph');
    
    % 6. Plot colored holes
    subplot(3,3,6); imshow(thresholdedImage, jet); title('colormap');
    
    % 7. Intensity vs. Area
    imageMask = GetImageMask(IM_block);
    stats = regionprops(imageMask, 'all');
    areaData = stats.Area;
    intensityData = mean2(IM_block_gray);
    sz = 25;
    subplot(3,3,7); scatter(areaData, intensityData, sz);  title('Intensity vs. Area');
    
    % 8. Eccentricity vs. Area
    imageMask = GetImageMask(IM_block);
    stats = regionprops(imageMask, 'all');
    areaData = stats.Area;
    eccentricityData = stats.Eccentricity;
    sz = 25;
    subplot(3,3,8); scatter(areaData, eccentricityData, sz);  title('Eccentricity vs. Area');
    
end
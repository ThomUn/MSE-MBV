%Block-Counting
%Develop and implement a method to detect the number of blocks in the BLOCKS\_\*.jpg images.
%MATLAB’s bwabeln and regionprop might help in counting and/or classifying.
%See Figure3 for help in setting up the processing stept – other ways are possible and welcome!
%Requirements:
%DONE 1. a function that accepts an image and returns the total number of blocks in the image
%DONE 2. a function that accepts an image and returns the total number of blocks for each color in the image
%DONE 3. a function that accepts an image and returns the total number of blocks for each shape in the image
%4. a function that accepts an image and returns the total number of blocks for each color and
%shape in the image and bounding boxes for all blocks. A script that produces figures of the
%results (of all sample images) with recognized shapes highlighted in the image(s) using the
%information returned by the above function(s)
clear all;
warning('off','all');

IM_block = imread('BLOCKS/BLOCKS_001.jpg');
%IM_block = imread('BLOCKS/BLOCKS_002.jpg');
%IM_block = imread('BLOCKS/BLOCKS_003.jpg');---
%IM_block = imread('BLOCKS/BLOCKS_004.jpg');---

%% Requirement 1 ----------------------------------------------------------
disp(['NumberOfBlocks:', char(9), num2str(GetNumberOfBlocks(IM_block))]);

%% Requirement 2 ----------------------------------------------------------
numbers = GetNumberOfBlocksForEachColor(IM_block);
disp('NumberOfBlocksForEachColor:');
disp(['- Red blocks:', char(9), num2str(numbers(1))]); 
disp(['- Green blocks:', char(9), num2str(numbers(2))]);
disp(['- Blue blocks:', char(9), num2str(numbers(3))]);

%% Requirement 3 ----------------------------------------------------------
numbers = GetNumberOfBlocksForEachShape(IM_block);
disp('NumberOfBlocksForEachShape:');
disp(['- Circle shapes:', char(9), num2str(numbers(1))]); 
disp(['- Rectangle shapes:', char(9), num2str(numbers(2))]);

%% Requirement 4 ----------------------------------------------------------
maskObjects(IM_block);

subplot(3,3,1); imshow(IM_block); title('original color');

%% function for labeling the image
function [mask] = maskObjects(data)
    %get each color
    red = imsubtract(data(:, :, 1), rgb2gray(data));
    green = imsubtract(data(:, :, 2), (data(:, :, 1)));
    blue = imsubtract(data(:, :, 3), rgb2gray(data));

    imshow(data)

    %plot each mask
    plotMask(red, 'red');
    plotMask(green, 'green');
    plotMask(blue, 'blue');

end

function plotMask(diff_im, color)

    diff_im = medfilt2(diff_im, [3 3]);
    diff_im = imbinarize(diff_im, 0.18);

    %remove small objects
    diff_im = bwareaopen(diff_im, 300);

    bw = bwlabel(diff_im, 8);
    stats = regionprops(bw, 'BoundingBox', 'Centroid', 'Area');

    hold on;
    for object = 1:length(stats)
        %ignore small objects
        if stats(object).Area > 10000
            %mask the objects label in center with boundingbox
            bb = stats(object).BoundingBox;
            bc = stats(object).Centroid;
            rectangle('Position', bb, 'EdgeColor', 'r', 'LineWidth', 1)
            plot(bc(1), bc(2))
            a = text(bc(1), bc(2), color);
            set(a, 'FontName', 'Arial', 'FontSize', 12, 'Color', 'black');
        end
    end
end

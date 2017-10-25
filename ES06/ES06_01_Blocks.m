%Block-Counting
%Develop and implement a method to detect the number of blocks in the BLOCKS\_\*.jpg images.
%MATLAB’s bwabeln and regionprop might help in counting and/or classifying.
%See Figure3 for help in setting up the processing stept – other ways are possible and welcome!
%Requirements:
%DONE 1. a function that accepts an image and returns the total number of blocks in the image
%2. a function that accepts an image and returns the total number of blocks for each color in the image
%3. a function that accepts an image and returns the total number of blocks for each shape in the image
%4. a function that accepts an image and returns the total number of blocks for each color and
%shape in the image and bounding boxes for all blocks. A script that produces figures of the
%results (of all sample images) with recognized shapes highlighted in the image(s) using the
%information returned by the above function(s)
clear all;
warning('off','all');

IM_block1 = imread('BLOCKS/BLOCKS_001.jpg');

disp(GetNumberOfBlocks(IM_block1));

subplot(3,3,1); imshow(IM_block1); title('original color');


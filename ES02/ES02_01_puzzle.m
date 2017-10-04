clear all;

%% Read image
img = imread('15-puzzle_scrambled.jpg');

%% Rotate image
rotatedImg = imrotate(img,-35);

%% Crop away the black frame
backgroundCropped = imcrop(rotatedImg, [700, 700, 1468, 1470]);

%%Shift picture horizontally and vertically
%shiftedCropped = circshift(cropped, -600);
restoredImg = circshift(circshift(backgroundCropped, -600), -400, 2);
%% Save image
imwrite(restoredImg,  'ES02/15-puzzle_restored.jpg');

%%Crop picture without background
onlyPuzzleCropped = imcrop(restoredImg, [142, 179, 1180, 1150]);
imwrite(onlyPuzzleCropped, 'ES02/15-puzzle_cropped.png');

%%Crop all tiles in one
allTiles = imcrop(onlyPuzzleCropped, [90 75 990 990]);

%% Extract all individual tiles
tileWidth = 245;
tileHeight = 245;

tile1 = imcrop(allTiles, [13, 1, tileWidth, tileHeight]);
tile2 = imcrop(allTiles, [255, 3, tileWidth, tileHeight]);
tile3 = imcrop(allTiles, [505, 3, tileWidth, tileHeight]);
tile4 = imcrop(allTiles, [748, 1, tileWidth, tileHeight]);

tile5 = imcrop(allTiles, [10, 246, tileWidth, tileHeight]);
tile6 = imcrop(allTiles, [261, 246, tileWidth, tileHeight]);
tile7 = imcrop(allTiles, [507, 243, tileWidth, tileHeight]);
tile8 = imcrop(allTiles, [759, 242, tileWidth, tileHeight]);

tile9 = imcrop(allTiles, [18, 497, tileWidth, tileHeight]);
tile10 = imcrop(allTiles, [264, 493, tileWidth, tileHeight]);
tile11 = imcrop(allTiles, [516, 494, tileWidth, tileHeight]);
tile12 = imcrop(allTiles, [765, 491, tileWidth, tileHeight]);

tile13 = imcrop(allTiles, [4, 762, tileWidth, tileHeight]);
tile14 = imcrop(allTiles, [256, 756, tileWidth, tileHeight]);
tile15 = imcrop(allTiles, [510, 756, tileWidth, tileHeight]);
tile16 = imcrop(allTiles, [758, 760, tileWidth, tileHeight]);

% Resize to 64x64
resizeWidth = 64;
resizeHeight = 64;

tile1Resized = imresize(tile1, [resizeWidth, resizeHeight]); 
tile2Resized = imresize(tile2, [resizeWidth, resizeHeight]);
tile3Resized = imresize(tile3, [resizeWidth, resizeHeight]);
tile4Resized = imresize(tile4, [resizeWidth, resizeHeight]);
tile5Resized = imresize(tile5, [resizeWidth, resizeHeight]);
tile6Resized = imresize(tile6, [resizeWidth, resizeHeight]);
tile7Resized = imresize(tile7, [resizeWidth, resizeHeight]);
tile8Resized = imresize(tile8, [resizeWidth, resizeHeight]);
tile9Resized = imresize(tile9, [resizeWidth, resizeHeight]);
tile10Resized = imresize(tile10, [resizeWidth, resizeHeight]);
tile11Resized = imresize(tile11, [resizeWidth, resizeHeight]);
tile12Resized = imresize(tile12, [resizeWidth, resizeHeight]);
tile13Resized = imresize(tile13, [resizeWidth, resizeHeight]);
tile14Resized = imresize(tile14, [resizeWidth, resizeHeight]);
tile15Resized = imresize(tile15, [resizeWidth, resizeHeight]);
tile16Resized = imresize(tile16, [resizeWidth, resizeHeight]); 

imwrite(tile1Resized, 'ES02/tile_1.png');
imwrite(tile2Resized, 'ES02/tile_2.png');
imwrite(tile3Resized, 'ES02/tile_3.png');
imwrite(tile4Resized, 'ES02/tile_4.png');
imwrite(tile5Resized, 'ES02/tile_5.png');
imwrite(tile6Resized, 'ES02/tile_6.png');
imwrite(tile7Resized, 'ES02/tile_7.png');
imwrite(tile8Resized, 'ES02/tile_8.png');
imwrite(tile9Resized, 'ES02/tile_9.png');
imwrite(tile10Resized, 'ES02/tile_10.png');
imwrite(tile11Resized, 'ES02/tile_11.png');
imwrite(tile12Resized, 'ES02/tile_12.png');
imwrite(tile13Resized, 'ES02/tile_13.png');
imwrite(tile14Resized, 'ES02/tile_14.png');
imwrite(tile15Resized, 'ES02/tile_15.png');
imwrite(tile16Resized, 'ES02/tile_16.png');

%% Reverse puzzle
reversedPuzzle = [tile16Resized, tile15Resized, tile14Resized, tile13Resized; 
                  tile12Resized, tile11Resized, tile10Resized, tile9Resized; 
                  tile8Resized, tile7Resized, tile6Resized, tile5Resized; 
                  tile4Resized, tile3Resized, tile2Resized, tile1Resized];
imwrite(reversedPuzzle, 'ES02/15-puzzle_reversed.jpg');

%% Create a plot of the intensity values on the main diagonal in 15-puzzle_scrambled.jpg
figure(1);
plot(diag(img));

%% Create plot with sum mean, usw
tilesArray{1} = tile1;
tilesArray{2} = tile2;
tilesArray{3} = tile3;
tilesArray{4} = tile4;
tilesArray{5} = tile5;
tilesArray{6} = tile6;
tilesArray{7} = tile7;
tilesArray{8} = tile8;
tilesArray{9} = tile9;
tilesArray{10} = tile10;
tilesArray{11} = tile11;
tilesArray{12} = tile12;
tilesArray{13} = tile13;
tilesArray{14} = tile14;
tilesArray{15} = tile15;
tilesArray{16} = tile16;

minimumValues = cellfun(@(x) min(min(x)), tilesArray);
maximumValues = cellfun(@(x) max(max(x)), tilesArray);
meanValues = cellfun(@(x) mean(mean(x)), tilesArray);
medianValues = cellfun(@(x) median(median(x)), tilesArray);

figure('name','Minimum, Maximum, Mean and Median of the individual tiles');
bar(horzcat(transpose(minimumValues), transpose(maximumValues), transpose(meanValues), transpose(medianValues)));
title('Minimum, Maximum, Mean and Median of the individual tiles');
xlabel('Tile Number');
ylabel('Result Value');
grid on;
legend('MIN','MAX','MEAN', 'MEDIAN');

%%fürs flugzeug bereich ausschneiden
%%roipoly(img)

%%find first black dot and last dot
%%test = min(find(rotatedImg ~= 0));
%%test2 = last(find(rotatedImg ~= 0));

%%[693.5 689.5 1479 1495]
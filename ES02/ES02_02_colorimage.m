clear all
IM = imread('mountain.jpg');

%Create RGB channels
channelRed = IM(:,:,1);
channelGreen = IM(:,:,2);
channelBlue = IM(:,:,3);

%Create matrix with zero values to display the channels the right way
zeroMatrix = zeros(size(IM,1),size(IM,2));
redImage = cat(3, channelRed, zeroMatrix, zeroMatrix);
greenImage = cat(3, zeroMatrix, channelGreen, zeroMatrix);
blueImage = cat(3, zeroMatrix, zeroMatrix, channelBlue);

%Convert to gray image
grayImage = rgb2gray(IM);

%Convert to indexed image with a 16-color map
[indexedImage16, map] = rgb2ind(IM, 16);

%Display the different versions of the image
figure(1);
subplot(2,3,1); 
imshow(IM);
title('Original image');

subplot(2,3,2);
imshow(redImage);
title('Red image');

subplot(2,3,3);
imshow(greenImage);
title('Green image');

subplot(2,3,4); 
imshow(blueImage);
title('Blue image');

subplot(2,3,5);
imshow(grayImage);
title('Gray image');

subplot(2,3,6);
imshow(indexedImage16, map);
title('Indexed image with 16-color map');

%Display original image
figure(2);
subplot(2,2,1);
imshow(IM);
title('Original');

subplot(2,2,2);
%Convert rgb image to HSV
HSV = rgb2hsv(IM);

%Intensify color saturation by 50%
HSVincreasedSaturation = cat(3, HSV(:,:,1), HSV(:,:,2) * 1.50, HSV(:,:,3));
imshow(hsv2rgb(HSVincreasedSaturation));
title('Intensified colors by 50%');

%Brightness increased by 50%
subplot(2,2,3);
HSVincreasedBrightness = cat(3, HSV(:,:,1), HSV(:,:,2), HSV(:,:,3) * 1.50);
imshow(hsv2rgb(HSVincreasedBrightness));
title('Increased brightness by 50%');

%Shift colors by 180 degrees -> display complementary colors
subplot(2,2,4);
HSVcomplementary = cat(3, mod(HSV(:,:,1) + 180/360,1.0) , HSV(:,:,2), HSV(:,:,3));
imshow(hsv2rgb(HSVcomplementary));
title('Display image with Complementary colors');
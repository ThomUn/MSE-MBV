clear all
IM = imread('bmw.jpg');

%Tolerance how much the colors can be different
tolerance = 0.1;

%Get the selected poly mask
polyMask = roipoly(IM);

%Convert RGB to HSV
HSV = rgb2hsv(IM);
hueChannel = HSV(:,:,1);
poly = hueChannel.*polyMask;

%Calculates the middle value of the selected area
dominantColor = mean2(poly);

%To calculate the color mask, I double-checked with the following solution
%of stackoverflow:
%https://stackoverflow.com/questions/14446061/a-boolean-function-for-finding-if-a-hsl-based-color-is-near-to-another-color 
colorMask = logical(mod(abs(dominantColor - hueChannel), (1 - tolerance)) > tolerance);

%Every element in this colormask and the marked area gets the saturation 0
%-> pixel looks like it is gray
saturationChannel = HSV(:,:,2);
saturationChannel(colorMask) = 0;
HSV(:,:,2) = saturationChannel;

%Convert from HSV to RGB image
colorIsolatedImage = hsv2rgb(HSV);

%Display original
subplot(1,2,1);
imshow(IM);
title('Original image');

%Display color isolated image
subplot(1,2,2);
imshow(colorIsolatedImage);
title('Color isolated image');

%Save image with isolation effect
imwrite(colorIsolatedImage, 'ES02/bmw_isolated.png');
clear all
IM = imread('bmw.jpg');

image = rgb2hsv(IM);
degrees = 0.1;

%Calculate middle points
Xmid = ceil(size(image,1)/2);
Ymid = ceil(size(image,2)/2);

%Calculate from which radius the vignette should be cut off
cutoffRadius = ((1-degrees) * max([Xmid Ymid]));

%Create meshgrid with maximum numbers of pixels
[X,Y] = meshgrid(1:1:2*Xmid, 1:1:2*Ymid);

%Calculates distance of vectors to middle point
distances = sqrt((Xmid-X).^2 + (Ymid-Y).^2);
distances = distances';

%Calculate values which are outside the radius
notInCircle = distances > cutoffRadius;

%Calculates distance of vectors to middle point
distances = 1- distances ./ sqrt((Xmid^2 + Ymid^2));

valueChannel = image(:,:,3);

%Set value V in the image according to the distances
valueChannel(notInCircle) = valueChannel(notInCircle) .* min(5*distances(notInCircle),1);
image(:,:,3) = valueChannel;

%Convert hsv2rgb
vignettedImage = hsv2rgb(image);

%Save vignetted image
imwrite(vignettedImage, 'ES02/bmw_vignetted.png');

%Display original and vignetted image
subplot(1,2,1);
imshow(IM);
title('Original image');

subplot(1,2,2);
imshow(vignettedImage);
title('Image with vignette effect');
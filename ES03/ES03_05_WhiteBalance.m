clear all;

%% Read picture 
IM = imread('white-picture.jpg');
polyMask = roipoly(IM);

%% Extract RGB canals
red = IM(:,:,1);
green = IM(:,:,2);
blue = IM(:,:,3);

%% Calculate average value in the selected area and factors according to exercise sheet
Rfactor = 255 / mean2(red(polyMask));
Gfactor = 255 / mean2(green(polyMask));
Bfactor = 255 / mean2(blue(polyMask));

%% Re-calculate RGB values according to exercise sheet
%R [255/Rw 0 0] [R']
%G=[0 255/Gw 0] [G']
%B [0 0 255/Bw] [B']
newIM(:,:,1) = Rfactor.*IM(:,:,1);
newIM(:,:,2) = Gfactor.*IM(:,:,2);
newIM(:,:,3) = Bfactor.*IM(:,:,3);

imwrite(newIM, 'ES03/white-picture-enhanced.jpg');

%% Show original
subplot(2,2,1);
imshow(IM)
title('Original picture');

%% Show histogram of original
subplot(2,2,2);
plot(imhist(IM))
title('Original picture histogram');

%% Show enhanced image
subplot(2,2,3);
imshow(newIM);
title('Enhanced picture');

%% Show histogram of enhanced image
subplot(2,2,4);
plot(imhist(newIM))
title('Enhanced picture histogram');
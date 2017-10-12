original = imread('white-picture.jpg');
sepia = imread('castle_sepia.jpg');

figure;
subplot(1,3,1);
hold on;
redOrig = original(:,:,1);
redSepia = sepia(:,:,1);
scatter(redOrig(:), redSepia(:));

redItf = linspace(107, 117, 125);

redItf = [redItf linspace(117,190, 130)];

plot(redItf);
legend('Scatter plot', 'Approximated IFT');
title('Red');


subplot(1,3,2);
hold on;
greenOrig = original(:,:,2);
greenSepia = sepia(:,:,2);
scatter(greenOrig(:),greenSepia(:));

greenItf = linspace(50,190,255);

plot(greenItf);
legend('Scatter plot', 'Approximated IFT');
title('Green');


subplot(1,3,3);
hold on;
blueOrig = original(:,:,3);
blueSepia = sepia(:,:,3);
scatter(blueOrig(:),blueSepia(:));

blueItf = linspace(20, 120, 110);

blueItf = [blueItf linspace(120, 180, 145)];

plot(blueItf);
legend('Scatter plot', 'Approximated IFT');
title('Blue');



newRed = applyITF(original(:,:,1), redItf);
newGreen = applyITF(original(:,:,2), greenItf);
newBlue = applyITF(original(:,:,3), blueItf);


newImage = uint8(cat(3, newRed, newGreen, newBlue));

figure;
subplot(1,3,1);
imshow(original);
title('Original');

subplot(1,3,2);
imshow(sepia);
title('Original sepia filter from GIMP');

subplot(1,3,3);
imshow(newImage);
title('Approximated sepia filter');

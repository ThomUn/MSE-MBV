%% Read image
img = imread('15-puzzle_scrambled.jpg');

%% Rotate image
rotatedImg = imrotate(img,-35);
imshow(rotatedImg);
%% Save image
imwrite(rotatedImg, 'ES02/15-puzzle_restored.jpg');

%%
cropped = imcrop(rotatedImg, [693.5 689.5 1479 1495]);
imshow(cropped);


%%fürs flugzeug bereich ausschneiden
%%roipoly(img)

%%find first black dot and last dot
%%test = min(find(rotatedImg ~= 0));
%%test2 = last(find(rotatedImg ~= 0));

%%[693.5 689.5 1479 1495]
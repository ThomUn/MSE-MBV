clear all;

%% Read original image
%IM=rgb2gray(imread('castle.jpg'));
IM=imread('castle.jpg');

%% Show original image
subplot(2,2,1);
imshow(IM);
title('original image');

%% Show posterized image
subplot(2,2,2);
[IM_P, itf] = posterize(IM,4);
%posterize(IM, [0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1]);
%posterize(IM, [0.2 0.2 0.2 0.2]);
%posterize(IM, [0.4 0.3 0.3]);
%posterize(IM, [0.5 0.5]);
imshow(IM_P);
title('posterized image');

%% Show histogram of original image
subplot(2,2,3);
hist = imhist(IM) / max(imhist(IM_P));
cumHist = cumsum(hist) / max(cumsum(hist));
plot(hist);hold on;
plot(cumHist);hold on;
plot(itf);
ylim([0 1]);
title('original image histogram');
hold off;

%% Show histogram of posterized image
subplot(2,2,4);
hist = imhist(IM_P) / max(imhist(IM_P));
cumHist = cumsum(hist) / max(cumsum(hist));
plot(hist);hold on;
plot(cumHist);hold on;
ylim([0 1]);
title('Histogram of posterized image');

%% Functions
function image = applyITF(image, itf)
    image = itf(image+1);
end
function [image,itf] = posterize(img, numberOfLevels) 
    if nargin == 1
        numberOfLevels = 3;
    end
    if size(numberOfLevels) == 1
        matrix = linspace(0,1,numberOfLevels);
        matrix = repmat(matrix,round(255/numberOfLevels),1);
        itf = reshape(matrix, [], 1);
    else
        cumHist = cumsum(imhist(img));
        cumHist = cumHist / max(cumHist);
        cumlevels = [cumsum(numberOfLevels) 1];
        colors = linspace(0,1, length(cumlevels));
        
        lower = repmat(cumHist', [length(cumlevels) 1]) <= repmat(cumlevels', [1 length(cumHist)]);

        upper = circshift(~lower,1,1);

        itf = (sum(lower.*upper.*repmat(colors', [1 length(cumHist)])));
    end
    
    image = applyITF(img, itf);
end

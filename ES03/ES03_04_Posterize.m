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
[IM_posterized, itf] = posterize(IM,[0.3 0.2 0.1 0.2]);
%[IM_posterized, itf] = posterize(IM, 5);
imshow(IM_posterized);
title('posterized image');

%% Show histogram of original image
subplot(2,2,3);
hist = imhist(IM) / max(imhist(IM));
cumHist = cumsum(hist) / max(cumsum(hist));
plot(hist);hold on;
plot(cumHist);hold on;
plot(itf);
ylim([0 1]);
title('histogram of original image');
hold off;

%% Show histogram of posterized image
subplot(2,2,4);
hist = imhist(IM_posterized) / max(imhist(IM_posterized));
cumHist = cumsum(hist) / max(cumsum(hist));
plot(hist); hold on;
plot(cumHist); hold on;
ylim([0 1]);
title('histogram of posterized image');

imwrite(IM_posterized, 'ES03/castle-posterized.jpg');

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

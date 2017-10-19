clear all;

IM = rgb2gray(imread('ramsay.jpg'));

figure;
subplot(3,2,1);
imshow(IM);
title('original')

subplot(3,2,2);
imshow(medianFilter(IM, 10));
title('median 10')

subplot(3,2,3);
imshow(IM);
title('original')

subplot(3,2,4);
%imshow(rotate(IM, 10));
title('rotate')

subplot(3,2,5);
imshow(IM);
title('original')

subplot(3,2,6);
imshow(contrast(IM, 5));
title('contrast')

%median
function IM = medianFilter(image, effectSize)
medianHandle = @(x) median(x(:));
IM = nlfilter(image, [effectSize effectSize], medianHandle);
end

%rotate -> not working
function IM = rotate(image, effectSize)
medianHandle = @(x) ones(5);
IM = nlfilter(image, [effectSize effectSize], medianHandle);
end

%local contracts
function IM = contrast(image, effectSize)
cont = @(x) max(x(:)) - min(x(:));
IM = nlfilter(image, [effectSize effectSize], cont);
end
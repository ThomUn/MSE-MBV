function [imageMask] = GetImageMask(image)

    IM_block1_gray = rgb2gray(image);
    subplot(3,3,2); imshow(IM_block1_gray); title('original gray');

    [threshold, EM] = graythresh(IM_block1_gray);
    thresholdedImage = imbinarize(IM_block1_gray, threshold);
    
    % can be used instead of imfill
    %thresholdedImage= bwmorph(~thresholdedImage, 'dilate', 20);
    %thresholdedImage= bwmorph(thresholdedImage, 'erode', 40);
    %figure(2);
    %imshow(thresholdedImage);
    %figure(3);
    %imshow(~thresholdedImage);
    
    thresholdedImage = bwmorph(~ thresholdedImage, 'dilate', 20);
    thresholdedImage = bwmorph(thresholdedImage, 'erode', 40);
    imageMask = thresholdedImage;
    %imageMask = imfill(~thresholdedImage, 'holes');
end


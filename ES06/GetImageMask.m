function [imageMask] = GetImageMask(image)

    IM_block_gray = rgb2gray(image);

    [threshold, EM] = graythresh(IM_block_gray);
    thresholdedImage = imbinarize(IM_block_gray, threshold);
    
    thresholdedImage = bwmorph(~ thresholdedImage, 'dilate', 20);
    thresholdedImage = bwmorph(thresholdedImage, 'erode', 40);
    
    imageMask = thresholdedImage;
end


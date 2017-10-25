function number = GetNumberOfBlocks( image )

    IM_block1_gray = rgb2gray(image);
    subplot(3,3,2); imshow(IM_block1_gray); title('original gray');

    [threshold, EM] = graythresh(IM_block1_gray);
    thresholdedImage = imbinarize(IM_block1_gray, threshold);
    imageMask = imfill(~thresholdedImage, 'holes');
    
    stats = regionprops(imageMask, 'Area');
   
   statsAreaVector = cat(1, stats.Area);
   relevantStats = statsAreaVector > 10000;
   
   number = sum(relevantStats);
end


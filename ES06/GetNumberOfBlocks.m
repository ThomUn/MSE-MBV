function number = GetNumberOfBlocks( image )

   imageMask = GetImageMask(image);
   
   stats = regionprops(imageMask, 'Area');
   statsAreaVector = cat(1, stats.Area);
   relevantStats = statsAreaVector > 10000;

   number = sum(relevantStats);
end


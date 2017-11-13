function number = GetNumberOfBlocks( image )

   imageMask = GetImageMask(image);
   
   % Remove smaller objects
   stats = regionprops(imageMask, 'Area');
   statsAreaVector = cat(1, stats.Area);
   relevantStats = statsAreaVector > 10000;

   number = sum(relevantStats);
end


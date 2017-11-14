function number = GetNumberOfBlocks( image )

   imageMask = GetImageMask(image);
   stats = regionprops(imageMask, 'Area');
   
   % Remove smaller objects
   statsAreaVector = cat(1, stats.Area);
   relevantStats = statsAreaVector > 10000;

   % Return sum of stats
   number = sum(relevantStats);
end


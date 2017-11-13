function [numbers] = GetNumberOfBlocksForEachColor(image)

    imageMask = GetImageMask(image);
    
    hsvImage = rgb2hsv(image);
    
    stats = regionprops(imageMask, 'all');
    
    % Remove smaller objects
    statsAreaVector = cat(1, stats.Area);
    relevantStats = statsAreaVector > 10000;
    
    statsCentroidVector = cat(1, stats.Centroid);
    relevantCentroidStats = statsCentroidVector(relevantStats, :);
    
    [sizeOfRelevantCentroids, ~] = size (relevantCentroidStats);
    red = 0;
    green = 0;
    blue = 0;
    
    for i = 1 : sizeOfRelevantCentroids 
        colorOnCenter = 360.*hsvImage(floor(relevantCentroidStats(i,2)), floor(relevantCentroidStats(i,1)),1);
        if (colorOnCenter > 215 && colorOnCenter < 270)
            blue = blue + 1;
        else if (colorOnCenter > 340 && colorOnCenter < 360)
            red = red + 1;
        else if (colorOnCenter > 115 && colorOnCenter < 150)
            green = green + 1;
        else
            % JUST FOR DEBUGGING
            % disp(colorOnCenter);
            end
            end
        end
    end

    numbers = [red, green, blue];
end


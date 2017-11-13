function [counter] = GetNumberOfBlocksForEachShape(image)

    IM = rgb2gray(image);
    treshold = graythresh(IM);
    IM_b = imbinarize(IM, treshold);

    %fill holes
    IM_b = bwmorph(~ IM_b, 'dilate', 20);
    IM_b = bwmorph(IM_b, 'erode', 40);
    stats = regionprops(IM_b, 'Area', 'Centroid', 'BoundingBox');

    countCircle = 0;
    countRect = 0;
    [B, L] = bwboundaries(IM_b, 'noholes');
    result = [];

    for object = 1:length(B)
        % Remove smaller objects
        if stats(object).Area > 10000

            % get objects perimeter
            boundary = B{object};
            delta = diff(boundary) .^ 2;
            perimeter = sum(sqrt(sum(delta, 2)));

            % get roundness
            roundness = 4 * pi * stats(object).Area / perimeter ^ 2;

            % check roundness to a certain threshold
            if roundness > 0.75
                % circle
                countCircle = countCircle + 1;
                result{object} = {stats(object).Centroid {'circle'} stats(object).BoundingBox};
                %
            else
                % rectangle
                countRect = countRect + 1;
                result{object} = {stats(object).Centroid {'rectangle'} stats(object).BoundingBox};
            end
        end

    end
    
    counter = [countCircle, countRect, result];
end


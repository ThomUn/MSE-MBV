function [counter] = GetNumberOfBlocksForEachShape(image)

    IM = rgb2gray(image);
    treshold = graythresh(IM);
    IM_b = imbinarize(IM, treshold);

    % Fill holes
    IM_b = bwmorph(~ IM_b, 'dilate', 20);
    IM_b = bwmorph(IM_b, 'erode', 40);
    [B, L] = bwboundaries(IM_b, 'noholes');

    stats = regionprops(IM_b, 'Area', 'Centroid', 'BoundingBox');

    countCircle = 0;
    countRect = 0;
    result = [];

    for object = 1:size(stats)
        % Ignore smaller objects
        if stats(object).Area > 10000

            % Get objects perimeter
            boundary = B{object};
            delta = diff(boundary) .^ 2;
            perimeter = sum(sqrt(sum(delta, 2)));

            % Calculate roundness
            roundness = 4 * pi * stats(object).Area / perimeter ^ 2;

            % Check roundness to a certain threshold
            if roundness > 0.75
                % Circle
                countCircle = countCircle + 1;
                result{object} = {stats(object).Centroid {'circle'} stats(object).BoundingBox};
                %
            else
                % Rectangle
                countRect = countRect + 1;
                result{object} = {stats(object).Centroid {'rectangle'} stats(object).BoundingBox};
            end
        end
    end

    counter = [countCircle, countRect, result];
end
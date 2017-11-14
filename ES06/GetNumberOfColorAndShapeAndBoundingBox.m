function [result] = GetNumberOfColorAndShapeAndBoundingBox(image)

    % Get the two results of the functions
    resultsForEachColor = GetNumberOfBlocksForEachColor(image);
    resultsForEachShape = GetNumberOfBlocksForEachShape(image);
    
    result = [];
    count = 1;
    
    for i  = 3: size(resultsForEachShape, 2)
        for j = 4:size(resultsForEachColor, 2)
            
            % Ignore empty cell array
            if(isempty(resultsForEachShape{i}))
               continue; 
            end
            
            %X-point of centroid to get matching color and shape
            x_centroid_shape = resultsForEachShape{i}{1}(1);
            x_centroid_color = resultsForEachColor{j}{1}(1);
            
            if (x_centroid_shape == x_centroid_color)
                % Set different values
                complete_centroid = resultsForEachShape{i}{1};
                text = {[resultsForEachColor{j}{2}{1} ' ' resultsForEachShape{i}{2}{1}]};
                boundingBox = resultsForEachShape{i}{3};
                
                % Add centroid, text and boundingbox to result-array
                result{count} = {complete_centroid text boundingBox};
                count = count + 1;
            end
        end
    end
end


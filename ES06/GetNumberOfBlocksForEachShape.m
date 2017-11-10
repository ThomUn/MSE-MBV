function [counter] = GetNumberOfBlocksForEachColor(image)


BW = GetImageMask(image);
%figure(2)
%imshow(BW);
% Step 5: Find the boundaries Concentrate only on the exterior boundaries.
% Option 'noholes' will accelerate the processing by preventing
% bwboundaries from searching for inner contours. 
[B,L] = bwboundaries(BW, 'noholes');

% Step 6: Determine objects properties
STATS = regionprops(L, 'all'); % we need 'BoundingBox' and 'Extent'

% Step 7: Classify Shapes according to properties
% Square = 3 = (1 + 2) = (X=Y + Extent = 1)
% Rectangular = 2 = (0 + 2) = (only Extent = 1)
% Circle = 1 = (1 + 0) = (X=Y , Extent < 1)
% UNKNOWN = 0
countCircle = 0;
countSquare= 0;
countRect= 0;

     for i = 1 : length(STATS)
          W(i) = uint8(abs(STATS(i).BoundingBox(3)-STATS(i).BoundingBox(4)) < 0.1);
          W(i) = W(i) + 2 * uint8((STATS(i).Extent - 1) == 0 );
          centroid = STATS(i).Centroid;
          switch W(i)
              case 1
                  plot(centroid(1),centroid(2),'wO');
                  countCircle = countCircle + 1;
              case 2
                  countSquare = countSquare + 1;
                    plot(centroid(1),centroid(2),'wX');
              case 3
                  countRect = countRect + 1;
                  plot(centroid(1),centroid(2),'wS');
          end
     end
     

     counter = [countCircle, countRect];
end


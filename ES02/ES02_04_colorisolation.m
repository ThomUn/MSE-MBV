I = imread('mountain.jpg');

ISinCity = SinCity(I, 0.1);
imshow(ISinCity);


function image = SinCity(image, tolerance)
   polyMask = roipoly(image);
   HSV = rgb2hsv(image);
   poly = HSV(:,:,1).*polyMask;
     
   dominantColor = mean2(poly);
   
   hueChannel = HSV(:,:,1);
   
   %dominantColor = 0.78
   %tolerance = 0.25
   %min = 0.53
   %max = 0.03
   
   minDominantColor = abs(dominantColor - tolerance); %0,53
   maxDominantColor = mod(dominantColor + tolerance, 1);%0,03
   
   colorMask = find(logical(hueChannel(abs(hueChannel))>=minDominantColor && mod(hueChannel)<=maxDominantColor));
   %colorMask = logical(hueChannel(abs(hueChannel-band)>dominantColor));

   saturationChannel = HSV(:,:,2);
   saturationChannel(colorMask) = 0;
   HSV(:,:,2) = saturationChannel;
   
   image = hsv2rgb(HSV);
end
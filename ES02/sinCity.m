I = imread('ferrari.jpg');

ISinCity = SinCity(I, 0.1);

subplot(1,2,1);
imshow(I);

subplot(1,2,2);
imshow(ISinCity);

imwrite(ISinCity, 'sinCity.png');

function image = SinCity(image, tolerance)
   polyMask = roipoly(image);
   HSV = rgb2hsv(image);
   hueChannel = HSV(:,:,1);
   poly = hueChannel.*polyMask;
     
   %Berechnen des durchschnittlichen HUE-Wertes in der (zweidimensionalen)
   %Auswahl
   dominantColor = mean2(poly);
   
   %Berechnet die Differenz aus der dominanten Farbe und dem jeweiligen
   %HUE-Wert Modulo 1 minus dem Toleranzbereich.
   %Je höher der Toleranzwert (bis 1) ist, desto geringer ist der Modulus
   %und desto kleiner die Ergebnisse.
   %Je kleiner der Toleranzwert (bis 0) ist, desto größer ist der Modulus 
   %und desto größer die Ergebnisse.
   %Frei nach
   %https://stackoverflow.com/questions/14446061/a-boolean-function-for-finding-if-a-hsl-based-color-is-near-to-another-color 
   colorMask = logical(mod(abs(dominantColor - hueChannel), (1 - tolerance)) > tolerance);

   %Jedes Element innerhalb dieser Marke wird auf 0% Sättigung gesetzt, was
   %den jeweiligen Bildpunkt Grau erscheinen lässt
   saturationChannel = HSV(:,:,2);
   saturationChannel(colorMask) = 0;
   HSV(:,:,2) = saturationChannel;
   
   image = hsv2rgb(HSV);
end
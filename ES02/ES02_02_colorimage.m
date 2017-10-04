clear all
RGB = imread('mountain.jpg');

%Kanäle werden aus den jeweiligen Matrix-Dimensionen des eingelesenen
%Bildes berechnet (1. Dim = Rot, 2. Dim = Grün, 3. Dim = Blau)
Cred = RGB(:,:,1);
Cgreen = RGB(:,:,2);
Cblue = RGB(:,:,3);

%Die Null-Matrix wird benötigt um das Bild im jeweiligen Kanal korrekt
%anzuzeigen. Würde man lediglich den Kanal anzeigen, so interpretiert
%Matlab das (zurecht) als Monochromes Bild
zeroMatrix = zeros(size(RGB,1),size(RGB,2));
Ired = cat(3, Cred, zeroMatrix, zeroMatrix);
Igreen = cat(3, zeroMatrix, Cgreen, zeroMatrix);
Iblue = cat(3, zeroMatrix, zeroMatrix, Cblue);

%Graustufenbild aus RGB mittels rgb2gray
Igray = rgb2gray(RGB);

%Konvertieren in ein indiziertes Bild mit einer Farbpalette von lediglich
%16 Farben
[Iindexed, map] = rgb2ind(RGB, 16);
figure(1);
subplot(2,3,1); imshow(RGB);
subplot(2,3,2); imshow(Ired);
subplot(2,3,3); imshow(Igreen);
subplot(2,3,4); imshow(Iblue);
subplot(2,3,5); imshow(Igray);
subplot(2,3,6); imshow(Iindexed, map);

%Anzeigen des Originalbilds
figure(2);
subplot(2,2,1);
imshow(RGB);
title('Original');

subplot(2,2,2);
%Konvertieren des RGB-Bildes in den HSV-Farbraum
HSV = rgb2hsv(RGB);

%Intensivieren der Farben um 50%
HSVintensified = cat(3, HSV(:,:,1), HSV(:,:,2) * 1.50, HSV(:,:,3));
imshow(hsv2rgb(HSVintensified));
title('Intensified colors by 50%');

%Helligkeit um 50% erhöht
subplot(2,2,3);
HSVbrightned = cat(3, HSV(:,:,1), HSV(:,:,2), HSV(:,:,3) * 1.50);
imshow(hsv2rgb(HSVbrightned));
title('Increased Brightness by 50%');

%Nachdem Hue einen Wert zwischen 0 und 1 annehmen kann, können die Farben
%nicht einfach mit einem Prozentwert multipliziert werden. HUE gibt die
%Position auf einem geschlossenen Farbkreis an (d.h. die Werte 0 und 1 sind
%idente Farben). Ein Verschub der Farben muss mit einer Addition um
%den Prozentwert MODULO 1 erfolgen. Wenn ein Farbton daher über 1
%hinausragt muss der entsprechende Umkreisabstand vom Wert 0 (bzw. 1) berechnet
%werden.
%In diesem Fall wird also jeder VALUE-Wert mit 90/360 (90°/360° = 0.25 =
%25%) MODULO 1 berechnet
subplot(2,2,4);
HSVshifted = cat(3, mod(HSV(:,:,1) + 180/360,1.0) , HSV(:,:,2), HSV(:,:,3));
imshow(hsv2rgb(HSVshifted));
title('Colors shifted by 25%/90°');
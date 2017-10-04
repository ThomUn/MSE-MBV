I = imread('bmw.jpg');

subplot(2,1,1);
imshow(I);
subplot(2,1,2);
Ivignetted = vignette(I,0.1);
imshow(Ivignetted);
imwrite(Ivignetted, 'vignetted.png');

function image = vignette(image, degrees)
    image = rgb2hsv(image);
    %Berechnet den Bildmittelpunkt
    Xmid = ceil(size(image,1)/2);
    Ymid = ceil(size(image,2)/2);
    
    %Berechnet ab welchem Radius vom Mittelpunkt aus die Vignettierung
    %abgeschnitten wird
    cutoffRadius = ((1-degrees) * max([Xmid Ymid]));
    
    [X,Y] = meshgrid(1:1:2*Xmid, 1:1:2*Ymid);
    
    %Berechnet die Distanz der Vektoren zum Mittelpunkt
    distances = sqrt((Xmid-X).^2 + (Ymid-Y).^2);
    distances = distances';
    
    %Alle Distanzen die größer als der berechnete cutoff-Radius sind werden
    %Teil der Vignettierung
    notInCircle = distances > cutoffRadius;
    
    %Berechnet die Distanz der Vektoren zum Mittelpunkt hin
    distances = 1- distances ./ sqrt((Xmid^2 + Ymid^2));
    
    valueChannel = image(:,:,3);
    
    %Der Faktor 5 verhindert, dass die Multiplikation mit der jeweiligen
    %Distanz zur Mitte hin einen zu harten Rand erzeugt - es wird
    %zusätzlich maximal mit 1 multipliziert, da Bildbereiche sonst
    %aufgehellt würden
    valueChannel(notInCircle) = valueChannel(notInCircle) .* min(5*distances(notInCircle),1);
    image(:,:,3) = valueChannel;
    
    image = hsv2rgb(image);
end
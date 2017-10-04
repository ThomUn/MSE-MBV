clear all
I = imread('mountain.jpg');
vignette(I,0.1);
subplot(2,1,1);
imshow(I);
subplot(2,1,2);
imshow(vignette(I, 0.1));

function image = vignette(image, degrees)
    image = rgb2hsv(image);
    Xmid = ceil(size(image,1)/2);
    Ymid = ceil(size(image,2)/2);
    
    cutoffRadius = ((1-degrees) * max([Xmid Ymid]));
    
    [X,Y] = meshgrid(1:1:2*Xmid, 1:1:2*Ymid);
    
    %inCircle ist eine zweidimensionale Matrix über alle Indizes des Bildes,
    %die Teil der Vignettierung sein sollen
    distances = sqrt((Xmid-X).^2 + (Ymid-Y).^2);
    distances = distances';
    notInCircle = distances > cutoffRadius;
    
    distances = 1- distances ./ sqrt((Xmid^2 + Ymid^2));
    distances(1,1)
    
    valueChannel = image(:,:,3);
    valueChannel(notInCircle) = valueChannel(notInCircle) .* distances(notInCircle);
    image(:,:,3) = valueChannel;
    
    image = hsv2rgb(image);
end
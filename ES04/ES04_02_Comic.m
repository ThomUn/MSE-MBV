clear all;

%% Read image
IM=rgb2gray(imread('ramsay.jpg'));
%IM=rgb2gray(imread('beans.jpg'));

%% Call comic function
comic(IM);

function image = comic(image)
    % Display original image
    figure(1);
    subplot(1,3,1);
    imshow(image);
    title('Original image');

    % Apply sharpening to edges and get edges
    image = imfilter(image,fspecial('unsharp'));
    image = edge(image,'prewitt');
    
    % Display edges of image
    subplot(1,3,2);
    imshow(image);
    title('Edges of image');
    
    % Invert image
    logMask = fspecial('LoG');
    image = conv2(image, logMask);
    image = abs(image);
   
    % Display finished image
    subplot(1,3,3);
    imshow(250 - abs(image),[]);
    title('Edge enhancing & inverted image');
end
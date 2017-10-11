clear all

%% read image & rgb2grey();
IM = rgb2gray(imread('ES03/room.jpg'));

%% ----- WINDOW -----
figure(1);
subplot(1,2,1);
plot(window(50,49));
title('window function');
hold on

subplot(1,2,2);
imshow(applyITF(IM, window(50,49)));
title('Image after window function');

%% ----- GAMMA -----
figure(2);
subplot(1,2,1);
plot(gamma(0.25,128,127));
title('gamma function');
hold on

subplot(1,2,2);
imshow(applyITF(IM, gamma(0.25,128,127)));
title('Image after gamma function');

%% ----- SIGMOID -----
figure(3);
subplot(1,2,1);
plot(gamma(0.25,128,127));
title('sigmoid function');
hold on

subplot(1,2,2);
imshow(applyITF(IM, sigmoid(50, 75)));
title('Image after sigmoid function');

%% functions
function image = applyITF(image, itf)
    image = itf(image+1);
end

function w = window(center, width)
    w = zeros(1,256);
    temp = linspace(0,1,2*width+1);
    w(center-width:center+width) = temp;
end

function g = gamma(gamma, center, width) %the latter two arguments are optional
    g = (0:255);
    g = window(center, width).^gamma;
end

%% NOT FINISHED
function s = sigmoid(center, width)
    center = center / 255;
    width = width / 255;
    vector = linspace(0,1, 256);
    s = (1./(1+exp(-((vector-center)./(width/2)))));
end
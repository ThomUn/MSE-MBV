clear all;

%% 1. abstergo logo----------------------------------------------------------------
IM = rgb2gray(imread('PICS/abstergo.jpg'));
figure(1);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = IterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ', num2str(optimalThreshold)]);

%% 2. coins----------------------------------------------------------------
IM = rgb2gray(imread('PICS/coins.jpg'));
figure(2);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = IterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ', num2str(optimalThreshold)]);

%% 3. coin-----------------------------------------------------------------
IM = rgb2gray(imread('PICS/coin.jpg'));
figure(3);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = IterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ', num2str(optimalThreshold)]);

%% 4. twitter logo---------------------------------------------------------

IM = rgb2gray(imread('PICS/twitter.jpg'));
figure(4);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = IterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ', num2str(optimalThreshold)]);

%% 5. pigeon---------------------------------------------------------------
IM = rgb2gray(imread('PICS/pigeon.jpg'));
figure(5);

subplot(1,2,1);
imshow(IM);
title('Original image in gray');

subplot(1,2,2);
[newIM, optimalThreshold] = IterativeOptimalThreshold(IM);
imshow(newIM);
title(['Optimal threshold: ', num2str(optimalThreshold)]);
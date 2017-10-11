clear all;

%% read image & rgb2grey();
IM = rgb2gray(imread('ES03/room.jpg'));

%% define Intensity Transform Function (ITF)
itf = uint8(255:-1:0);

%% cumulative histogram of original
[x,n] = imhist(IM);
cum_hist = cumsum(x)/numel(IM);

%% a
afterApplyingITF = applyITF(IM, cum_hist);

%% cumulative histogram after applying ITF to original
[x,n] = imhist(afterApplyingITF);
cum_hist_afterApplyingITF = cumsum(x)/numel(afterApplyingITF);

%% Show original image
figure(1);
subplot(3,2,1);
imshow(IM);
title('Before applying ITF');

%% Show enhanced image
subplot(3,2,2)
imshow(afterApplyingITF);
title('After applying ITF');
imwrite(afterApplyingITF,  'ES03/room_enhanced.jpg');

%% Show cumulative histogram of original image
subplot(3,2,3)
plot(cum_hist);
title('Cumulative Histogram before applying');

%% Show cumulative histogram of enhanced image
subplot(3,2,4)
plot(cum_hist_afterApplyingITF);
title('Cumulative histogram after applying');

%% Show ITF
subplot(3,2,5)
plot(itf);
title('ITF');

function image = applyITF(image, itf)
    image = itf(image+1); %+1 because 0 can not be displayed
end
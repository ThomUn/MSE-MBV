clear all;

%% Read images
IM_cameraman = imread('cameraman.tif');
IM_ean = rgb2gray(imread('PICS/ean.jpg'));
IM_page = rgb2gray(imread('PICS/page.jpg'));

%% cameraman.tif
[n, EM] = imhist(IM_cameraman);
level = otsuthresh(n);
IM_otsu = imbinarize(IM_cameraman,level);
[IM_iot, optimalThreshold] = IterativeOptimalThreshold(IM_cameraman);
[IM_mode, mode_level]= ModeMethod(IM_cameraman);

% Self evaluated
self_level = 0.27;
IM_self = imbinarize(IM_cameraman, self_level);

% Diagram for statistics of different thresholds
x = categorical({'Otsu', 'Iot', 'Mode', 'Self'});
y = [level, optimalThreshold, mode_level, self_level];

% Show images
figure(1);
subplot(2,3,1); imshow(IM_cameraman); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
subplot(2,3,6); bar(x,y); title('Differences in thresholds');

% Ratios black/white pixels
figure(2);
subplot(1,4,1); diplayStats(IM_otsu); title('Otsu');
subplot(1,4,2); diplayStats(IM_iot); title('Iterative optimal threshold');
subplot(1,4,3); diplayStats(IM_mode); title('Mode method');
subplot(1,4,4); diplayStats(IM_self); title('Self-evaluated');

%% ean.jpg
[n,EM] = imhist(IM_ean);
level = otsuthresh(n);
IM_otsu = imbinarize(IM_ean,level);
[IM_iot, optimalThreshold] = IterativeOptimalThreshold(IM_ean);
[IM_mode, mode_level]= ModeMethod(IM_ean);

% Self evaluated
self_level = 0.56;
IM_self = imbinarize(IM_ean, self_level);

% Diagram for statistics of different thresholds
x = categorical({'Otsu', 'Iot', 'Mode', 'Self'});
y = [level, optimalThreshold, mode_level, self_level];

% Show images
figure(3);
subplot(2,3,1); imshow(IM_ean); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
subplot(2,3,6); bar(x,y); title('Differences in thresholds');

% Ratios black/white pixels
figure(4);
subplot(1,4,1); diplayStats(IM_otsu); title('Otsu');
subplot(1,4,2); diplayStats(IM_iot); title('Iterative optimal threshold');
subplot(1,4,3); diplayStats(IM_mode); title('Mode method');
subplot(1,4,4); diplayStats(IM_self); title('Self-evaluated');

%% page.jpg
[n, EM] = imhist(IM_page);
level= otsuthresh(n);
IM_otsu = imbinarize(IM_page,level);
[IM_iot, optimalThreshold] = IterativeOptimalThreshold(IM_page);
[IM_mode, mode_level]= ModeMethod(IM_page);

% Self evaluated
self_level = 0.25;
IM_self = imbinarize(IM_page, self_level);

% Diagram for statistics of different thresholds
x = categorical({'Otsu', 'Iot', 'Mode', 'Self'});
y = [level, optimalThreshold, mode_level, self_level];

figure(5);
subplot(2,3,1); imshow(IM_page); title('Original');
subplot(2,3,2); imshow(IM_otsu); title(['Otsu: ', num2str(level)]);
subplot(2,3,3); imshow(IM_iot); title(['Iterative optimal threshold: ', num2str(optimalThreshold)]);
subplot(2,3,4); imshow(IM_mode); title(['Mode method: ', num2str(mode_level)]);
subplot(2,3,5); imshow(IM_self); title(['Self evaluated: ', num2str(self_level)]);
subplot(2,3,6); bar(x,y); title('Differences in thresholds');

% Ratios black/white pixels
figure(6);
subplot(1,4,1); diplayStats(IM_otsu); title('Otsu');
subplot(1,4,2); diplayStats(IM_iot); title('Iterative optimal threshold');
subplot(1,4,3); diplayStats(IM_mode); title('Mode method');
subplot(1,4,4); diplayStats(IM_self); title('Self-evaluated');

%% Conclusion
%%cameraman.tif
%The human-generated ground truth is at 27%.
%Otsu came to 34% and mode method threshold came to 24%.
%Both were near the ground truth.
%Iterative optimal threshold is about double the ground truth at about 55%
%and so kind of far away from ground truth and not really suitable for this
%picture.

%%ean.jpg
%The human-generated ground truth is at 56%.
%Otsu and iterative optimal threshold are close to the ground truth. 
%Otsu is at 56% and iot at 51%. Both came exactly and very close to the
%ground-truth.
%The mode method threshold is far away at about 6%. This one was far away
%from the ground truth and is not suitable for EAN-codes.

%%page.jpg
%The human-generated ground truth is at 25%.
%Basically all thresholds are near the ground truth.
%The Otsu threshold is at about 29%-30%.
%The iterative optimal threshold is at about 25%.
%The mode method threshold is at about 7%.

%% Functions
function [IM_new, result] = ModeMethod(IM)
    [n, x] = imhist(IM);

    [~,peakIndex] = sort(findpeaks(n), 'descend');

    result = (x(peakIndex(end-1))+x(peakIndex(end)))/2/256;
    IM_new = imbinarize(IM, result);
end

function diplayStats(IM)
    pixels_white = sum(IM(:));
    pixels_black = numel(IM) - pixels_white;
    values = [pixels_black, pixels_white];
    colormap([0 0 0; 1 1 1]);
    pie(values);
end
% rgb = imread('aerial.png');
% I = rgb2gray(rgb);
% imshow(I)
% 
% hy = fspecial('sobel');
% hx = hy';
% Iy = imfilter(double(I), hy, 'replicate');
% Ix = imfilter(double(I), hx, 'replicate');
% gradmag = sqrt(Ix.^2 + Iy.^2);
% figure
% imshow(gradmag,[]), title('Gradient magnitude (gradmag)')


% clc;    % Clear the command window.
% close all;  % Close all figures (except those of imtool.)
 imtool close all;  % Close all imtool figures.
% clear;  % Erase all existing variables.
% workspace;  % Make sure the workspace panel is showing.
 format longg;
 format compact;
 fontSize = 20;

img = imread('aerial.png');
img2 = rgb2gray(img);
grayImage = img2;
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% Let's compute and display the histogram.
[pixelCount grayLevels] = imhist(grayImage);
subplot(2, 2, 2); 
bar(pixelCount);
grid on;
title('Histogram of Original Image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

gaussian1 = fspecial('Gaussian', 21, 15);
gaussian2 = fspecial('Gaussian', 21, 20);
dog = gaussian1 - gaussian2;
dogFilterImage = conv2(double(grayImage), dog, 'same');
subplot(2, 2, 3); 
imshow(dogFilterImage, []);
title('DOG Filtered Image', 'FontSize', fontSize);

% Let's compute and display the histogram.
[pixelCount grayLevels] = hist(dogFilterImage(:));
subplot(2, 2, 4); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of DOG Filtered Image', 'FontSize', fontSize);

level = graythresh(dogFilterImage)
BW = imbinarize(dogFilterImage,level);
imshow(BW)
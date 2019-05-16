%% 1a)
% https://de.mathworks.com/company/newsletters/articles/the-watershed-transform-strategies-for-image-segmentation.html
I = im2double(imread("grains.jpg"));
I = rgb2gray(I);
I = imgaussfilt(I);
I = imadjust(I);
%I = imhmin(I,20); %20 is the height threshold for suppressing shallow minima
L = watershed(imcomplement(I))
%L = imhmin(L,20); %20 is the height threshold for suppressing shallow minima
Lrgb = label2rgb(L);
imshow(Lrgb); figure;
%imshow(I); figure;
%I = imhmin(I,20); %20 is the height threshold for suppressing shallow minima
%I2 = imcomplement(I);
%imshow(I2); figure;
%L = watershed(I2);
%imshow(L); figure;
%imshow(L, 'jet', 'b')
%% 1b)
b = L;
b(L>0) = 1
overlay = imoverlay(I, b, [1 0 0]); % [r g b]
imshow(overlay);
%% 1c)
segments = max(L, [],'all')
%% 2
ifm = imread('ifm_seg.jpg');
imshow(ifm); figure;
% Wie findet man die Abstände raus
D = bwdist(~bw);
imshow(D,[],'InitialMagnification','fit')
title('Distance transform of ~bw')
D = -D;
D(~bw) = Inf;
L = watershed(D);
L(~bw) = 0;
rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure
imshow(rgb,'InitialMagnification','fit')
title('Watershed transform of D')
%%
imhmin
imcomplement
imgaussfilt
imadjust
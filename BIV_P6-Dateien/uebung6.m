%% 1a)
I = imread("grains.jpg");
I = rgb2gray(I);
I = imgaussfilt(I);
I = imcomplement(I);
I = imhmin(I,20);
L = watershed(I);
figure; imshow(L>0,[]); 
%% 1b)
b = zeros(300,400);
b(L == 0) = 1;
I = imcomplement(I);
overlay = imoverlay(I, b, 'r'); % [r g b]
imshow(overlay);
%% 1c)
segments = max(L, [], 'all')
%% 2
ifm = imread('ifm_seg.jpg');
figure; imshow(ifm); 
figure; imshow(imcomplement(ifm)); 
pic(ifm>0) = 1;
D = bwdist(imcomplement(pic));
figure; imshow(D,[],'InitialMagnification','fit'); 
title('Distance transform of ~bw')
% Complement the distance transform, and force pixels that don't belong to the objects to be at Inf .
D = -D;
D(~pic) = Inf;
D = imhmin(D, 1);
L = watershed(D);
L(~pic) = 0;
rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure;
imshow(rgb,'InitialMagnification','fit')
title('Watershed transform of D')
%% 1a)
dreieck = imread("Dreieck.png");
ableitung_x = [1 0 -1] ./2;
ableitung_y = [1; 0; -1] ./2;
x_kanten = conv2(dreieck, ableitung_x, 'same');
y_kanten = conv2(dreieck, ableitung_y, 'same');
imshow(dreieck); figure;
imshow(x_kanten, []); figure;
imshow(y_kanten, []); figure;
%% 1b)
a = x_kanten .^2 + y_kanten.^2;
betrag = sqrt(a);
imshow(betrag, []); figure;
%% 1c)
laplace_mask = [0 1 0; 1 -4 1 ;0 1 0];
laplace = conv2(dreieck, laplace_mask);
imshow(laplace, []); figure;
% die Kanten sind sichtbar und liegen genau im Übergang von dunkel und hell
%% 1d)
mond = double(imread("Mond.png"))./255;
imshow(mond); figure;
faktor = 0.5;
laplace_mond = conv2(mond, faktor*laplace_mask, 'same');
ergebnis = mond - laplace_mond;
imshow(ergebnis); figure;
%% 2a)
biv = imread("BIVn.png");
bivhist = imhist(biv);
bins = bivhist>0;
sum(bins==1)
%% 3b)
%1)
maske = [1 0 -1] ./2;
maskeT = [1; 0; -1] ./2;
bildNoise = imread('HausNoisy.png');
bildNoiseD = double(bildNoise) ./ 255;
imshow(bildNoiseD); title('Original') ;figure;
gradientNoiseX = conv2(bildNoiseD, maske, "same");
gradientNoiseY = conv2(bildNoiseD, maskeT, "same");
betragNoise = (gradientNoiseX .^2 + gradientNoiseY .^2).^0.5;

imshow(betragNoise); title('Betrag des Gradienten des HausNoisy Bildes'); figure;

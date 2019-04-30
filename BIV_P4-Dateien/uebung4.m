shadingimage = double(imread('shading.jpg'))/255;
shadingimage = shadingimage(:,:,1);
imshow(shadingimage);
%% 1a)
mask = [1 2 1];
ergebnis = conv2(shadingimage, mask);
figure;
imshow(ergebnis);
% Warum ist das Ergebnis heller?
% weil nicht durch die Summe aller Werte geteilt wird
newmask = [1 2 1] ./4;
ergebnis = conv2(shadingimage, newmask);
figure;
imshow(ergebnis);
%% 1b)
ergebnis = shadingimage;
figure;
imshow(ergebnis);
for m = 1:50
ergebnis = conv2(ergebnis, newmask);
end;
figure;
imshow(ergebnis);
% a) das bild ist komplett schwarz?
% b) das Bild bestand vorher aus 218x303 Pixel und besteht danach aus 218x403 Pixeln
% c) 

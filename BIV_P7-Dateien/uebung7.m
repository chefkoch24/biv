%% 1a)
bild = im2double(imread("bild.png"));
bild_nearest = bild;
bild_bilinear = bild;
bild_bicubic = bild;
for i=0:36
    bild_nearest = imrotate(bild_nearest,10,'nearest','crop');
    bild_bilinear = imrotate(bild_bilinear,10,'bilinear','crop');
    bild_bicubic = imrotate(bild_bicubic,10,'bicubic','crop');
end

imshow(bild); title("Original"); figure;
imshow(bild_nearest); title("Nearest"); figure;
imshow(bild_bilinear); title("Bilinear"); figure;
imshow(bild_bicubic); title("Bicubic"); figure;
% Beschreibung Ergebnis
%% 1b)
%Warum entstehen bei Nächster-Nachbar-Interpolation starke Artefakte?
%% 1c)
fourier = fft2(bild);
fourier = ShowLogPower(fourier, "Fourier");
imshow(fourier);
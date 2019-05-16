% Hilfsfunktion zur Erzeugung eines zentrierten Kreises als Maske
function mask = CreateCenteredCircle(fft_image, radius)
  h = double(fspecial('disk', radius) > 0);
  mask = 1-padarray(h,floor((size(fft_image)-size(h))/2));
  mask = imresize(mask, size(fft_image));
end

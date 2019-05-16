% Hilfsfunktion zur Anzeige von Ortsfrequenzraum-Bildern mit mittlerem Grauwert in der Mitte
function fftShiftedSquare = ShowShifted(fft_image, caption)
  imageSize = size(fft_image);
  dispSize = max(imageSize(:));
  fftShifted = fftshift(fft_image);
  fftShiftedSquare = imresize(fftShifted, [dispSize dispSize],'bilinear');
%  imshow(fftShiftedSquare,[-1 50],'InitialMagnification','fit');
  imshow(fftShiftedSquare,[0 18],'InitialMagnification','fit');
  set(gcf, 'name', caption);
  title(caption)
  colormap(jet);
%   fft_shifted = CONGRID(SHIFT(fft_image, (imageSize[0]/2), (imageSize[1]/2)), dispSize, dispSize)
%   IIMAGE, fft_shifted, TITLE=caption 
end

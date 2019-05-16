% logarithmiertes Powerspektrum anzeigen
function logpower=ShowLogPower(fft_image, caption)
  logpower = log(abs(fft_image));
  ShowShifted(logpower, caption);
end

shadingimage = double(imread('shading.jpg'))/255;
shadingimage = shadingimage(:,:,1);


% Aufgabe 1a)
maske = [1 2 1];
ergebnisA = conv2(shadingimage, maske);
figure;
imshow(ergebnisA);
title('ergebnisA');


maskeKorrigiert = maske ./ 3;
ergebnisAKorrigiert = conv2(shadingimage, maskeKorrigiert);
figure;
imshow(ergebnisAKorrigiert);
title('ergebnisAKorrigiert');

%%
% Aufgabe 1b)
ergebnisB = shadingimage;
ergebnisBS = shadingimage;
ergebnisBV = shadingimage;
for m = 1:50
    ergebnisB = conv2(ergebnisB, maskeKorrigiert);
    ergebnisBS = conv2(ergebnisBS, maskeKorrigiert, 'same');
    ergebnisBV = conv2(ergebnisBV, maskeKorrigiert, 'valid');
end

figure;
imshow(ergebnisB, []);
title('ergebnisB');
figure;
imshow(ergebnisBS, []);
title('ergebnisB mit shpae=same');
figure;
imshow(ergebnisBV, []);
title('ergebnisB mit shape=valid');
%%
% Wie hat sich das Bild optisch verändert? = Zwei Schwarze Streifen am linken und rechten Rand sind 
% durch das padding dazugekommen im Vergleich zum Orginal und die Helligkeit hat überall im Bild zugenommen.
% Wie hat sich die Größe verändert? = Die Spaltenanzahl hat sich in jedem Durchlauf um 2
% erhöht.
% Woher kommen die schwarzen Streifen? =  Werden zum berechnen der Faltung
% eingefügt in der ersten und letzten Spalte des
% urprünglichen Bildes um die notwendigen Rechenschritte auch an den Rändern durchführen zu
% können. 

% Aufgabe 1c)
ergebnisT = shadingimage;
maskeT = [1;2;1];

for i = 1:50
    ergebnisT = conv2(ergebnisT, maskeT ./ 3, 'same');
end

figure;
imshow(ergebnisT, []);
title('Ergebnis mit transponierter Maske');

% Gleiche Ergebnis wie in Aufgabe 1b) nur in vertikaler Richtung.
%%
% Aufgabe 1d)
ergebnisT2 = ergebnisBS;

for i = 1:50
    ergebnisT2 = conv2(ergebnisT2, maskeT ./ 3, 'same');
end

figure;
imshow(ergebnisT2, []);
title('Erst Zeilenvektor, dann Spaltenvektor')

ergebnisT3 = ergebnisT;

for i = 1:50
    ergebnisT3 = conv2(ergebnisT3, maske ./ 3, 'same');
end

figure;
imshow(ergebnisT3, []);
title('Erst Spaltenvektor, dann Zeilenvektor')

% Ändert sich etwas, wenn Sie es in der anderen
% Reihenfolge (zuerst Spalten-, dann Zeilenvektor als Maske) durchführen? 
% = Keine Unterschiede .
%%
% Aufgabe 1e)

ergebnisMaskenFaltung = conv2(maske, maskeT)

%%
% Aufgabe 1f)

maskeK = [1 0 -1];
maskeKT = [1;0;-1];

ergebnisK = conv2(shadingimage, maskeK ./ 2);
figure;
imshow(ergebnisK, []);
title('maskeK');

ergebnisKT = conv2(shadingimage, maskeKT ./ 2);
figure;
imshow(ergebnisKT, []);
title('maskeKT');


%%
% Wie kommt es du den hellen und dunklen Stellen im Ergebnisbild? = 
% Grund dafür könnte eine Lichtquelle sein, die vom oberen und linken 
% Bildschirmrand oberhalb der Kugeln im Bild auf sie einstrahlt und durch die Abnahme der Helligkeit 
% mit steigender Distanz zur Lichtquelle für eine minimale Abnahme der Helligkeit mit 
% steigender x - und abnehmender y- und der nicht vorhandenen z- Koordinate sorgt, was sich im Gradienten an 
% den Pixel mit positiver Helligkeit äußert.


% Aufgabe 2

bildKorrektur = shadingimage;

maskeG = [1 2 1] ./ 4;
maskeGT = [1;2;1] ./ 4;

for i=1:800
    bildKorrektur = padarray(bildKorrektur, [1 1], 'replicate', 'both');
    bildKorrektur = conv2(maskeG, maskeGT, bildKorrektur, 'valid');
end

figure;
imshow(bildKorrektur)
title('Korrekturbild');

korrigiertesBild = shadingimage ./ bildKorrektur;

figure;
imshow(korrigiertesBild);
title('Korrigiertes Bild');

figure;
plot(hist(shadingimage(:), 255));
title('Histogramm Original');

figure;
plot(hist(korrigiertesBild(:), 255));
title('Histogramm korrigiertes Bild');
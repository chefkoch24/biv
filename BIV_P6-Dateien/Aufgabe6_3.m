%% 
%% Aufgabe 1: Wasserscheidentransformation zur Bildsegmentierung
%% a)

% Bild einlesen
bildGrainsRGB = imread('grains.jpg');
bildGrains = rgb2gray(bildGrainsRGB);

figure;
imshow(bildGrains);
title('Original');

% Bild glätten
bildGrains = imgaussfilt(bildGrains);

% Komplement erstellen
bildGrains = imcomplement(bildGrains);

% Flache Pools entfernen 
bildGrains = imhmin(bildGrains,20);

% Wasserscheidentransformation
wasserscheidenT = watershed(bildGrains);

% Labels in RGB Bild umwandeln
rgb = label2rgb(wasserscheidenT,'jet',[.5 .5 .5]);
figure; 
imshow(rgb);
title('label2rgb');

%% b)

wasserscheiden = zeros(300, 400);
wasserscheiden(wasserscheidenT == 0) = 1;

bildGrainsRot = bildGrainsRGB;
bildGrainsRot = imoverlay(bildGrainsRot, wasserscheiden, 'r');

figure;
imshow(bildGrainsRot);
title('Wasserscheiden');

%% c)

anzahlSegmente = max(wasserscheidenT(:))

%% d)

% Anzahl Pixel der Wasserscheiden
countSegmente = histcounts(wasserscheidenT, anzahlSegmente);
pixelWasserscheide = countSegmente(1,1)

% Anzahl Pixel des groeßten Segments 
countSegmente(1,1) = 0; 
maxSegment = max(countSegmente(:))

% Größte Segment in Grün überlagern
segmentGruen = zeros(300, 400);
segmentGruenLabel = find(countSegmente == maxSegment);
segmentGruen (wasserscheidenT == segmentGruenLabel) = 1;

bildGrainsGruen = imoverlay(bildGrainsRGB, segmentGruen, 'g');

figure;
imshow(bildGrainsGruen);
title('Groeßte Segment');

%% Aufgabe 2: Trennung von Segmenten

bildIfm = imread('ifm.jpg');
figure;
imshow(bildIfm);
title('Original');

bildIfmSeg = imread('ifm_seg.jpg');
figure;
imshow(bildIfmSeg);
title('Segmentiert');

% Distanztransformation 
distanzT = bwdist(~bildIfmSeg);
figure;
imshow(distanzT, []);
title('Distanztransformation');

distanzT = -distanzT;
distanzT(~bildIfmSeg) = inf;

distanzT = imhmin(distanzT, 1);

% Wasserscheidentransformation
wasserscheidenIfm = watershed(distanzT);
wasserscheidenIfm(~bildIfmSeg) = 0;

% Labels in RGB Bild umwandeln
rgb = label2rgb(wasserscheidenIfm,'jet',[.5 .5 .5]);
figure; 
imshow(rgb);
title('label2rgb');

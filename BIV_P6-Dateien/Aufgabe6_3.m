%% Aufgabe 1: Wasserscheidentransformation zur Bildsegmentierung
% doc imcomplement
% doc imhmin
% doc imgradient
% doc watershed
% doc imadjust
%imhmin(bildGrains, 0.05, 4);
% doc histcounts
% doc label2rgb
% doc imoverlay
%% a)

% Bild einlesen
bildGrainsRGB = imread('grains.jpg');
bildGrains = rgb2gray(bildGrainsRGB);

%figure;
%imshow(bildGrains);

%bildGrains = imadjust(bildGrains);

% Bild glätten
bildGrains = imgaussfilt(bildGrains);

% Flache Pools entfernen 
%bildGrains = imhmin(bildGrains,100);

% Bild in Binärbild umwandeln
binGrains = zeros(300, 400);
binGrains(bildGrains >= 150) = 1;

figure;
imshow(binGrains);

histogramm = imhist(bildGrains);
figure;
plot(histogramm);

% Distanztransformation 
distanzT = bwdist(~binGrains);
figure;
imshow(distanzT, []);

distanzT = imadjust(distanzT);

distanzT = -distanzT;
distanzT(~binGrains) = inf;

% Wasserscheidentransformation
wasserscheidenT = watershed(distanzT);
wasserscheidenT(~binGrains) = 0;

% Labels in RGB Bild umwandeln
rgb = label2rgb(wasserscheidenT,'jet',[.5 .5 .5]);
figure; 
imshow(rgb);

%% b)

wasserscheiden = zeros(300, 400);
wasserscheiden(wasserscheidenT == 0) = 1;

bildGrainsRot = bildGrainsRGB;
bildGrainsRot = imoverlay(bildGrainsRot, wasserscheiden, 'r');

figure;
imshow(bildGrainsRot);

%% c)

anzahlSegmente = max(wasserscheidenT(:))

%% d)

% Anzahl Pixel der Wasserscheiden
countSegmente = histcounts(wasserscheidenT, anzahlSegmente+1);
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

%% Aufgabe 2: Trennung von Segmenten

bildIfm = imread('ifm.jpg');
%figure;
imshow(bildIfm);

bildIfmSeg = imread('ifm_seg.jpg');
%figure;
imshow(bildIfmSeg);

% Distanztransformation 
distanzT = bwdist(~bildIfmSeg);
%figure;
imshow(distanzT, []);

distanzT = imhmin(distanzT, 1);

distanzT = -distanzT;
distanzT(~bildIfmSeg) = inf;

% Wasserscheidentransformation
wasserscheidenIfm = watershed(distanzT);
wasserscheidenIfm(~bildIfmSeg) = 0;

% Labels in RGB Bild umwandeln
rgb = label2rgb(wasserscheidenIfm,'jet',[.5 .5 .5]);
figure; 
imshow(rgb);

% 
anzahlSegmente = max(wasserscheidenIfm(:))


%% Aufgabe 3: Wasserscheidentransformation zur Bildsegmentierung - Teil 2
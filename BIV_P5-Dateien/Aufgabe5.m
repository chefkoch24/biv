bildDreieck = imread('Dreieck.png');
bildDreieckD = double(bildDreieck)./ 255;

figure;
imshow(bildDreieckD);

%% 1. Kanten

%% a)
maske = [1 0 -1] ./2;
maskeT = [1; 0; -1] ./2;

gradientX = conv2(bildDreieckD, maske, 'same');
gradientY = conv2(bildDreieckD, maskeT, 'same');

figure;
imshow(gradientX, []);
title('Gradient X');
figure;
imshow(gradientY, []);
title('Gradient Y');

% Welche Werte des jeweiligen Ergebnisbildes sind positiv, welche negativ?
% Die Bildunkte der Hypotenuse des Dreiecks haben den 
% Wert -0.5 im Ergebnisbild der Ableitung in x- und y-Richtung. 
% Die Bildpunkte der horizontalen Kathete des Dreiecks der Ableitung in
% y-Richtung und die vertikale Kathete des Dreiecks in x-Richtung 
% haben den Wert +0.5 im Ergebnisbild. Die Übrigen Seiten des Dreiecks
% haben den Wert 0.

% Warum? 
% Grund dafür ist die Faltungsoperation, die bspw. bei der Berechnung des 
% Gradienten in x- Richtung den Bildpunkten den Wert -0.5 zuweist, deren  
% links benachbarter Pixel +1 entspricht und deren rechts benachbarter
% Pixel 0 entspricht, was an der Hypotenuse des Orginalbildes der Fall ist. 

% Überlegen Sie sich, in welche Richtung der Gradient auf den Seiten des 
% Dreiecks zeigt.
% Der Gradient der Hypotenuse zeigt in Richtung der Ecke oben, links. 
% Der Gradient der vertikalen Kathete zeigt in Richtung rechten Randes.
% Der Gradient der horizontalen Kathete zeigt in Richtung des unteren
% Randes.

%% b)
betrag = (gradientX.^2 + gradientY .^2).^0.5;
figure;
imshow(betrag, []);
title('Betrag Dreieck');

%% c)
maskeLaplace = [1 -2 1];

laplaceDreieckX = conv2(maskeLaplace, bildDreieckD);
laplaceDreieckX = laplaceDreieckX(:,2:160);
laplaceDreieckY = conv2(maskeLaplace.', bildDreieckD);
laplaceDreieckY = laplaceDreieckY(2:151,:);

laplaceDreieck = laplaceDreieckX + laplaceDreieckY;

figure;
imshow(laplaceDreieck, []);
title('Laplace Dreieck');

% Können Sie die Kanten sehen? Wo genau liegen die Kanten?
% Die Kanten befinden sich zwischen den parallel verlaufenden weißen und
% schwarzen Linien, also an den Stellen, an denen ein Vorzeichenwechsel
% stattfindet.

%% d) 

bildMond = imread('Mond.png');
bildMondD = double(bildMond)./ 255;

figure;
imshow(bildMondD);
title('Original');

gauss7 = [1 6 15 20 15 6 1] ./ 64;

% Glättung
for i = 0:500
    gaussMond = conv2(gauss7, gauss7.', bildMondD);
    gaussMond = gaussMond(2:301,2:298);
end

figure;
imshow(gaussMond);
title('Mond Glatt');

laplaceMondX = conv2(maskeLaplace, gaussMond);
laplaceMondX = laplaceMondX(:,2:298);

laplaceMondY = conv2(maskeLaplace.', gaussMond);
laplaceMondY = laplaceMondY(2:301,:);

laplaceMond = laplaceMondX + laplaceMondY;

maxWert = max(max(laplaceMond).');
bildMondScharf = gaussMond - laplaceMond ./ maxWert;

figure;
imshow(bildMondScharf);
title('Mond scharfgezeichnet');

%% 2. Kanten

%% a)

bildBiv = imread('BIVn.png');
bildBivD = double(bildBiv) ./ 255;

figure;
imshow(bildBiv);
title('Original');

% Histogramm erzeugen und Klassen zählen
histBiv = imhist(bildBiv);
bins = histBiv > 0;
bins = sum(bins == 1)

% Wie viele verschiedene Grauwerte hat das Bild?
% Das Histogramm besitzt nur 2 Klassen, es handelt sich dabei um ein
% Binärbild

%% b)

% Gradienten berechnen
gradientBivX = bildBivD;
gradientBivY = bildBivD;

gradientBivX = conv2(maske, gradientBivX);
gradientBivX = gradientBivX(:,2:587);
gradientBivY = conv2(maskeT, gradientBivY);
gradientBivY = gradientBivY(2:378,:);

% Betrag berechnen
betragBiv = (gradientBivX.^2 + gradientBivY .^2).^0.5;

% Ausgabe
figure;
imshow(betragBiv, []);
title('Betrag');,

%% c)

% Gauss Masken
gauss3 = [1 2 1] ./ 4;
gauss5 = [1 4 6 4 1] ./ 16;
gauss7 = [1 6 15 20 15 6 1] ./ 64;

% Glättung mit Gauss Masken

ergebnisGauss3 = bildBivD;
ergebnisGauss5 = bildBivD;
ergebnisGauss7 = bildBivD;

for i = 0:200
    ergebnisGauss3 = conv2(gauss3, gauss3.', ergebnisGauss3, 'same');
    ergebnisGauss5 = conv2(gauss5, gauss5.', ergebnisGauss5, 'same');
    ergebnisGauss7 = conv2(gauss7, gauss7.', ergebnisGauss7, 'same');
    
    % Ausgabe jeder 50. durchlauf
    if mod(i, 50) == 0
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('3x3 Gaußfilter nach %i durchläufen', i+1));
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('5x5 Gaußfilter nach %i durchläufen', i+1));
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('7x7 Gaußfilter nach %i durchläufen', i+1));
        
        %% d) 
        
        gradientGauss3X = ergebnisGauss3;
        gradientGauss3Y = ergebnisGauss3;
        gradientGauss5X = ergebnisGauss5;
        gradientGauss5Y = ergebnisGauss5;
        gradientGauss7X = ergebnisGauss7;        
        gradientGauss7Y = ergebnisGauss7;
        
        % Berechnung der Stärke der Kanten (Betrag des Gradienten) 
        gradientGauss3X = conv2(maske, gradientGauss3X);
        gradientGauss3X = gradientGauss3X(:,2:587);
        gradientGauss3Y = conv2(maskeT, gradientGauss3Y);
        gradientGauss3Y = gradientGauss3Y(2:378,:);
            
        gradientGauss5X = conv2(maske, gradientGauss5X);
        gradientGauss5X = gradientGauss5X(:,2:587);
        gradientGauss5Y = conv2(maskeT, gradientGauss5Y);
        gradientGauss5Y = gradientGauss5Y(2:378,:);
            
        gradientGauss7X = conv2(maske, gradientGauss7X);
        gradientGauss7X = gradientGauss7X(:,2:587);
        gradientGauss7Y = conv2(maskeT, gradientGauss7Y);
        gradientGauss7Y = gradientGauss7Y(2:378,:);
        
        
        % Betrag des Gradienten berechnen
        betragGauss3 = (gradientGauss3X.^2 + gradientGauss3Y .^2).^0.5;
        betragGauss5 = (gradientGauss5X.^2 + gradientGauss5Y .^2).^0.5;
        betragGauss7 = (gradientGauss7X.^2 + gradientGauss7Y .^2).^0.5;

        if i == 0
            glattBivBetrag = betragGauss3;
        end
        
        % Ausgabe
        figure;
        imshow(betragGauss3, []);
        title(sprintf('Betrag des 3x3 Gaußfilter nach %i durchläufen', i+1));
        figure;
        imshow(betragGauss5, []);
        title(sprintf('Betrag des 5x5 Gaußfilter nach %i durchläufen', i+1));
        figure;
        imshow(betragGauss7, []);        
        title(sprintf('Betrag des 7x7 Gaußfilter nach %i durchläufen', i+1));

    end
end

%% e) 
betragBivGlatt = betragBiv;

% Glätten
for i = 1:1
    betragBivGlatt = conv2(gauss3, gauss3.', betragBivGlatt, 'same');
end

% Ausgabe 
figure;
imshow(betragBivGlatt, []);
title('1 x mit einem 3x3 Gaussfilter geglätteter Betrag von Bivn');

figure;
imshow(glattBivBetrag, []);
title('Betrag des 1 x mit einem 3x3 Gaussfilter geglätteten Bildes von Bivn aus Teilaufgabe b');

% Warum ist das Ergebnis ein anderes als das in Teilaufgabe b, obwohl die Faltung kommutativ ist?
% Bei der Berechnung des Betrags wird auf weitere Rechenoperationen
% zurückgegriffen, wie der Multiplikation, die nicht assoziativ mit dem
% Faltungsoperator ist und deshalb eine andere Reihenfolge
% der Rechenschritte zu unterschiedlichen Ergebnissen führt.

%% f)

% RGB Bild erzeugen von Bivn
bildBivRGB = bildBivD;
bildBivRGB(:,:,2) = bildBivD;
bildBivRGB(:,:,3) = bildBivD;

figure;
imshow(bildBivRGB);

% Ersetze alle Bildpunkte des G-Kanals des RGB Bildes deren Kantenstärke
% größer dem Mittelwert aller Beträge ist mit 1.
mittelwertBetragBiv = sum(sum(betragGauss3).')/220922

deutlicheKantenBiv = betragGauss3;
deutlicheKantenBiv(betragGauss3 > mittelwertBetragBiv) = 1;
deutlicheKantenBiv(deutlicheKantenBiv < 1) = 0;

deutlicheKantenBiv(bildBivD < deutlicheKantenBiv) = 1;
bildBivRGB(:,:,2) = deutlicheKantenBiv;

% Ausgabe
figure;
imshow(bildBivRGB); 
title('Starke Kanten');

%% 3. Reduktion von Rauschen

bildNoise = imread('HausNoisy.png');
bildNoiseD = double(bildNoise)./ 255;

figure;
imshow(bildNoiseD);
title('Original');

%% a)

 % Mittelwertfilter
mittelwertFilter = [1 1 1 1 1] ./ 5;
mittelwert = conv2(mittelwertFilter, mittelwertFilter.', bildNoiseD, 'same');
 
figure;
imshow(mittelwert);
title('Mittelwertfilter');
  
 % Gaussfilter
gaussFilter = [1 4 6 4 1] ./ 16;
gauss = conv2(gaussFilter, gaussFilter.', bildNoiseD, 'same');
 
figure;
imshow(gauss);
title('Gaussfilter');

 % Medianfilter
medianFilter = ones(5,5);
median = ordfilt2(bildNoiseD, 13, medianFilter);

figure;
imshow(median);
title('Medianfilter');


% Wo sind Artefakte zu erkennen?
% Der Medianfilter lässt schmale Streifen wie den äußeren, weißen Rand
% des linken Fensters im Turm, verschwinden.
% Der Mittelwertfilter erzeugt ebenso an schmalen Kanten Artefakte
% aufgrund der glättenden Eigenschaften des Filters, die deutlich stärker
% ausfallen, als diejenigen des zentral orientierten Gaussfilters.


%% b) 

%% 1)

% Welche Berechnung (aus der Aufgabe zu Kanten) liefert einen Wert, der 
% angibt, wie deutlich eine Kante ist?
% Der Betrag der ersten Ableitung. 

gradientNoiseX = conv2(maske, bildNoiseD);
gradientNoiseX = gradientNoiseX(:,2:635);
gradientNoiseY = conv2(maskeT, bildNoiseD);
gradientNoiseY = gradientNoiseY(2:701,:);

betragNoise = sqrt((gradientNoiseX.^2 + gradientNoiseY .^2));

figure;
imshow(betragNoise, []);
title('Betrag des Gradienten des HausNoisy Bildes');

%% 2) 

mittelwertBetragNoise = sum(sum(betragNoise).')/443800
deutlicheKanten = betragNoise;
deutlicheKanten(betragNoise > mittelwertBetragNoise) = 1;
figure;
imshow(deutlicheKanten);
title('deutliche Kanten');

%% 3) 

ergebnisNoisy = bildNoiseD .* deutlicheKanten + abs(gauss .* (deutlicheKanten - 1));

figure;
imshow(ergebnisNoisy);
title('Ergebnis Vereinigung');

%% 4)

% Vergleichen Sie die Ergebnisse der Gaußfilterung und dieser inhomogenen
% Filterung.
% Die verschwommenen Stellen aus der Gaußfilterung wurden beseitigt, das 
% Bild besitzt stärkere Kanten. Die Dachziegel im Turm sind schärfer
% gezeichnet.


%% 4. Verkleinern eines Bildes 

bildRinge = imread('ringe.png');
bildRingeD = double(bildRinge(:,:,1)) ./ 255;

figure;
imshow(bildRingeD);
title('Original');

%% a) 

bildRingeKlein = imresize(bildRingeD, 0.1, 'nearest');

figure;
imshow(bildRingeKlein);
title('Verkleinert');

% Was beobachten Sie?
% Das Muster ist nach der Verkleinerung ein ganz anderes, es entsteht 
% Aliasing aufgrund des Moiré Effekts.

%% b) 
% Rand entfernen
bildRingeGlatt = bildRingeD;

for i = 1:40
    bildRingeGlatt = conv2(gauss3, gauss3.', bildRingeGlatt, 'same');
    
end

figure;
imshow(bildRingeGlatt);
title('Geglättet');

bildRingeGlattKlein = imresize(bildRingeGlatt, 0.1, 'nearest');

figure;
imshow(bildRingeGlattKlein);
title('Verkleinertung des geglätteten Bildes');

% Je öfter das Bild geglättet wird, desto schwächer fällt das
% Aliasing aus.
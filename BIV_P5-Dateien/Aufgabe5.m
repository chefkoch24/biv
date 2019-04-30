bildDreieck = imread('Dreieck.png');
bildDreieckD = double(bildDreieck ./ 255);

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
figure;
imshow(gradientY, []);

% Welche Werte des jeweiligen Ergebnisbildes sind positiv, welche negativ?
% Die Bildunkte der Hypotenuse des Dreiecks und des rechten Rands haben den 
% Wert -1 im Ergebnisbild der Ableitung in x-Richtung. 
% Die Bildpunkte der vertikalen Kathete des Dreiecks und des linken Rands
% haben den Wert +1 im Ergebnisbild der Ableitung in y-Richtung.  

% Warum? 
% Grund daf¸r ist die Faltungsoperation, die bspw. bei der Berechnung des 
% Gradienten in x- Richtung den Bildpunkten den Wert -1 zuweist, deren  
% links benachbarter Pixel +1 entspricht und deren rechts benachbarter
% Pixel 0 entspricht, was an der Hypotenuse und am rechten Rand des 
% Orginalbildes der Fall ist.. 

% ‹berlegen Sie sich, in welche Richtung der Gradient auf den Seiten des 
% Dreiecks zeigt.
% Der Gradient der Hypotenuse zeigt in Richtung der Ecke unten, links. 
% Der Gradient der vertikalen Kathete zeigt in Richtung rechten Randes.
% Der Gradient der horizontalen Kathete zeigt in Richtung des oberen
% Randes.

%% b)
betrag = (gradientX.^2 + gradientY .^2).^0.5;
figure;
imshow(betrag, []);

%% c)




%% d) 



%% 2. Kanten

%% a)
bildBiv = imread('BIVn.png')
bildBivD = double(bildBiv ./ 255);

figure;
imshow(bildBiv);

histBiv = imhist(bildBiv);
bins = 0;

% Histogramm Klassen z‰hlen
for i = 1:256
    if histBiv(i) > 0 
        bins = bins + 1;
    end
end

% Ausgaben
bins
figure;
plot(histBiv)

% Wie viele verschiedene Grauwerte hat das Bild?
% Das Histogramm besitzt nur 2 Klassen

%% b)

gradientBivX = bildBiv;
gradientBivY = bildBiv;

% Bild nach x und y ableiten
% ?? 50x?
for i = 1:1
    gradientBivX = conv2(maske, gradientBivX);
    gradientBivX = gradientBivX(:,2:587);
    gradientBivY = conv2(maskeT, gradientBivY);
    gradientBivY = gradientBivY(2:378,:);
end

% Betrag berechnen
% ?? was ist mit dem Kantenbild gemeint?
betragBiv = (gradientBivX.^2 + gradientBivY .^2).^0.5;

% Ausgabe
figure;
imshow(betragBiv, []);

%% c)

% Gauss Masken
gauss3 = [1 2 1] ./ 4;
gauss5 = [1 4 6 4 1] ./ 16;
gauss7 = [1 6 15 20 15 6 1] ./ 64;

% Gl‰ttung mit Gauss Masken

ergebnisGauss3 = bildBivD;
ergebnisGauss5 = bildBivD;
ergebnisGauss7 = bildBivD;

for i = 1:200
    ergebnisGauss3 = conv2(gauss3, gauss3.', ergebnisGauss3, 'same');
    ergebnisGauss5 = conv2(gauss5, gauss5.', ergebnisGauss5, 'same');
    ergebnisGauss7 = conv2(gauss7, gauss7.', ergebnisGauss7, 'same');
    if mod(i, 50) == 0
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('3x3 Gauﬂfilter nach %i durchl‰ufen', i));
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('5x5 Gauﬂfilter nach %i durchl‰ufen', i));
        figure;
        imshow(ergebnisGauss3);
        title(sprintf('7x7 Gauﬂfilter nach %i durchl‰ufen', i));
        
        %% d) 
        
        gradientGauss3X = ergebnisGauss3;
        gradientGauss3Y = ergebnisGauss3;
        gradientGauss5X = ergebnisGauss5;
        gradientGauss5Y = ergebnisGauss5;
        gradientGauss7X = ergebnisGauss7;        
        gradientGauss7Y = ergebnisGauss7;
        
        % Berechnung der St‰rke der Kanten (Betrag des Gradienten)
        % ?? Wie viele durchl‰ufe beim berechnen des Gradienten notwendig?
        % Auch in Aufgabe b)
        for i = 1:1
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
        end
        
        % Betrag des Gradienten berechnen
        betragGauss3 = (gradientGauss3X.^2 + gradientGauss3Y .^2).^0.5;
        betragGauss5 = (gradientGauss5X.^2 + gradientGauss5Y .^2).^0.5;
        betragGauss7 = (gradientGauss7X.^2 + gradientGauss7Y .^2).^0.5;

        % Ausgabe
        figure;
        imshow(betragGauss3, []);
        figure;
        imshow(betragGauss5, []);
        figure;
        imshow(betragGauss7, []);
        
        %%
    end
end

%% e) 

% ?? Das Kantenbild aus d)?

% Warum ist das Ergebnis ein anderes, obwohl die Faltung kommutativ ist?

%% f)



%% 3. Reduktion von Rauschen
%% a)

bildNoise = imread('HausNoisy.png');
bildNoiseD = double(bildNoise ./ 255);

figure;
imshow(bildNoiseD);
title('Original');

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
median = medfilt2(bildNoiseD, [5 5]);
figure;
imshow(median);
title('Medianfilter');

% Wo sind Artefakte zu erkennen?
% Der Mittelwertfilter erzeugt vor allem an den Stellen Bildfehler, an
% denen Impulsrauschen exestiert.
% Der Medianfilter beseitigt Impulsrauschen, erzeugt allerdings dabei 
% ebenso Bildfehler an den betroffenen Stellen.  ?? 
%% b) 

%% 1)

% Welche Berechnung (aus der Aufgabe zu Kanten) liefert einen Wert, der 
% angibt, wie deutlich eine Kante ist?
% Der Betrag der ersten Ableitung. ??

gradientNoiseX = conv2(maske, bildNoiseD);
gradientNoiseX = gradientNoiseX(:,2:635);
gradientNoiseY = conv2(maskeT, bildNoiseD);
gradientNoiseY = gradientNoiseY(2:701,:);

betragNoise = (gradientNoiseX.^2 + gradientNoiseY .^2).^0.5;

figure;
imshow(betragNoise);
title('Betrag des Gradienten des HausNoisy Bildes');

%% 2) 

deutlicheKanten = round(betragNoise);

figure;
imshow(deutlicheKanten);
title('deutliche Kanten');

%% 3) 

ergebnisNoisy = bildNoiseD .* deutlicheKanten + abs(gauss .* (deutlicheKanten - 1));

figure;
imshow(ergebnisNoisy);

%% 4)

% Vergleichen Sie die Ergebnisse der Gauﬂfilterung und dieser inhomogenen
% Filterung.
% Die verschwommenen Stellen aus der Gauﬂfilterung wurden beseitigt.


%% 4. Verkleinern eines Bildes 

bildRinge = imread('ringe.png');
bildRingeD = double(bildRinge(:,:,1) ./ 255);

figure;
imshow(bildRingeD);

%% a) 

bildRingeKlein = imresize(bildRingeD, 0.1, 'nearest');

figure;
imshow(bildRingeKlein);

% Was beobachten Sie?
% Das Muster ist nach der Verkleinerung ein ganz anderes, es entsteht 
% Aliasing aufgrund des MoirÈ Effekts.

%% b) 

bildRingeGlatt = bildRingeD;

for i = 1:20
    bildRingeGlatt = conv2(gauss3, gauss3.', bildRingeGlatt);
end

figure;
imshow(bildRingeGlatt);

bildRingeGlattKlein = imresize(bildRingeGlatt, 0.1, 'nearest');

figure;
imshow(bildRingeGlattKlein);

% Je ˆfter das Bild gegl‰ttet wird, desto schw‰cher f‰llt das
% Aliasing aus.
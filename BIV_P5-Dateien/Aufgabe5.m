bild = imread('Dreieck.png');
bildD = double(bild ./ 255);

figure;
imshow(bildD);

%% 1. Kanten

%% a)
maske = [1 0 -1];
maskeT = [1; 0; -1];

gradientX = conv2(bildD, maske, 'same');
gradientY = conv2(bildD, maskeT, 'same');

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
% Grund dafür ist die Faltungsoperation, die bspw. bei der Berechnung des 
% Gradienten in x- Richtung den Bildpunkten den Wert -1 zuweist, deren  
% links benachbarter Pixel +1 entspricht und deren rechts benachbarter
% Pixel 0 entspricht, was an der Hypotenuse und am rechten Rand des 
% Orginalbildes der Fall ist.. 

% Überlegen Sie sich, in welche Richtung der Gradient auf den Seiten des 
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

%% b)

%% c)

%% d) 

%% e) 

%% f)



%% 3. Reduktion von Rauschen

%% a)

%% b) 

%% 1)

%% 2) 

%% 3) 

%% 4)



%% 4. Verkleinern eines Bildes 

%% a) 

%% b) 
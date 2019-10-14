function [Iout] = ex1(I)
Iout = I;

%agafem window de 3*3
margin = 2;
[f,c] = size(I);
for i = 1: (f-margin)
    %per a cada volta de fila, generem les 3 columnes
    left = mean(I(i:i+margin, 1))/3;
    center = mean(I(i:i+margin, 2))/3;
    right = mean(I(i:i+margin, 3))/3;
    generalMean = left+center+right;
    for j =  1 : (c-margin)
       Iout(i,j) = generalMean;
       
       %agafem el window d'1px a la dreta de forma optimitzada
       generalMean = generalMean - left;
       left = center;
       center = right;
       right = mean(I(i:i+margin, j+2))/3;
       generalMean = generalMean + right;
    end
end
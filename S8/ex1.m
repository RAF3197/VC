function [] = ex1(I)
IB = rgb2gray(I);
BW = IB < 50;
components = bwconncomp(BW);
stats = regionprops(components,'all');

%aqui hem de normalitzar ->  Mirant com es fa 

testI = imread('Joc_de_caracters.jpg');
testI = rgb2gray(testI);
testR = flipdim(testI ,1);
imshow(testR);
BW = testR < 50
components = bwconncomp(BW);
statsR = regionprops(components,'all');
%Normalitzar 


%Comparar
end
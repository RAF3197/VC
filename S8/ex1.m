function [] = ex1()
I = imread('Joc_de_caracters.jpg');
IB = rgb2gray(I);
BW = IB < 50;
imshow(BW);
components = bwconncomp(BW);
stats = regionprops(components,'all');

%aqui hem de normalitzar ->  Mirant com es fa 
for i = 1:size(stats)
    statsValue1(i) = 1-stats(i).EulerNumber;
    statsValue2(i) = stats(i).Extent;
    statsValue3(i) = stats(i).MajorAxisLength;
    statsValue4(i) = stats(i).Area;
    statsValue5(i) = stats(i).Perimeter;
    statsValue6(i) = stats(i).Area/(stats(i).Perimeter*stats(i).Perimeter);
    statsValue7(i) = stats(i).Solidity;
    statsValue8(i) = stats(i).Eccentricity;
end

statsValue1 = normalize(statsValue1, 'range');
statsValue2 = normalize(statsValue2, 'range');
statsValue3 = normalize(statsValue3, 'range');
statsValue4 = normalize(statsValue4, 'range');
statsValue5 = normalize(statsValue5, 'range');
statsValue6 = normalize(statsValue6, 'range');
statsValue7 = normalize(statsValue7, 'range');
statsValue8 = normalize(statsValue8, 'range');

total = statsValue1 + statsValue2 + statsValue3 + statsValue4 + statsValue5 + statsValue6 + statsValue7 + statsValue8;
    
total = normalize(total, 'range');

testI = imread('Joc_de_caracters_deformats.jpg');
testR = rgb2gray(testI);
%testR = flipdim(testR ,1);
%imshow(testR);
figure;
BW = testR < 50
imshow(BW);
components = bwconncomp(BW);
statsR = regionprops(components,'all');
%Normalitzar 

for i = 1:size(stats)
    statsValueRes1(i) = 1-statsR(i).EulerNumber;
    statsValueRes2(i) = statsR(i).Extent;
    statsValueRes3(i) = statsR(i).MajorAxisLength;
    statsValueRes4(i) = statsR(i).Area;
    statsValueRes5(i) = statsR(i).Perimeter;
    statsValueRes6(i) = statsR(i).Area/(statsR(i).Perimeter*statsR(i).Perimeter);
    statsValueRes7(i) = statsR(i).Solidity
    statsValueRes8(i) = statsR(i).Eccentricity;
end

statsValueRes1 = normalize(statsValueRes1, 'range');
statsValueRes2 = normalize(statsValueRes2, 'range');
statsValueRes3 = normalize(statsValueRes3, 'range');
statsValueRes4 = normalize(statsValueRes4, 'range');
statsValueRes5 = normalize(statsValueRes5, 'range');
statsValueRes6 = normalize(statsValueRes6, 'range');
statsValueRes7 = normalize(statsValueRes7, 'range');
statsValueRes8 = normalize(statsValueRes8, 'range');

totalRes = statsValueRes1 + statsValueRes2 + statsValueRes3 + statsValueRes4 + statsValueRes5 + statsValueRes6 + statsValueRes7 + statsValueRes8;

%totalRes = statsValueRes1 + statsValueRes6;
    
totalRes = normalize(totalRes, 'range');

for i = 1:30
    minI = 99;
    minJ = 99;
    totalMin = 99;
    for j=1:30
        if abs(total(i)-totalRes(j)) < totalMin
            minI = i;
            minJ = j;
            totalMin = abs(total(i)-totalRes(j));
        end
    end
    matrixRes(minI,minJ) = 1;
end
figure;
imagesc(matrixRes);
end
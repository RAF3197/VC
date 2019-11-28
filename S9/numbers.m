function [] = numbers(matricula_posible)
    I = imread('Joc_de_caracters.jpg');
    IB = rgb2gray(I);
    BW = IB < 50;
    components = bwconncomp(BW);
    stats = regionprops(components,'all');
    
    %aqui hem de normalitzar 
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
    
    matricula_posible = matricula_posible < 70;
    components = bwconncomp(matricula_posible);
    statsR = regionprops(components,'all');
    %Normalitzar 
    
    if size(statsR)<7
        %no hi han suficients regions
        return
    end
    
    figure;
    imshow(matricula_posible);
    hold on;
    
    count = 1;
    for i = 1:size(statsR)
        left = statsR(i).BoundingBox(1);
        top = statsR(i).BoundingBox(2);
        width = statsR(i).BoundingBox(3);
        height = statsR(i).BoundingBox(4);
        ar = height/width;
        if ar > 1.5 && ar <= 4 && height>10
            rectangle('Position',[left, top, width, height], 'Edgecolor', 'r');
            statsValueRes1(count) = 1-statsR(i).EulerNumber;
            statsValueRes2(count) = statsR(i).Extent;
            statsValueRes3(count) = statsR(i).MajorAxisLength;
            statsValueRes4(count) = statsR(i).Area;
            statsValueRes5(count) = statsR(i).Perimeter;
            statsValueRes6(count) = statsValueRes4(count) / (statsValueRes5(count) * statsValueRes5(count) );
            statsValueRes7(count) = statsR(i).Solidity;
            statsValueRes8(count) = statsR(i).Eccentricity;
            count = count+1;
        end
    end
    
    if (count<7)
        %no hi han suficients numeros/lletres valides
        close
        return
    end
    
    for i = 1:size(count)
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
        
    totalRes = normalize(totalRes, 'range');
    
    total = total'
    totalRes = totalRes'
    Y = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';'R';'S';'T';'V';'W';'X';'Y';'Z'];
    F = fitcecoc(total,Y);
    Yp = predict(F,totalRes);
    Yp'
    
    %confusionchart(Y,Yp)
end


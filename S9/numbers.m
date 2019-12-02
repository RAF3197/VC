function [] = numbers(matricula_posible)
    I = imread('Joc_de_caracters.jpg');
    IB = rgb2gray(I);
    BW = IB < 50;
    components = bwconncomp(BW);
    stats = regionprops(components,'all');
    
    weight_1 = 0.3;
    weight_2 = 0.05;
    weight_3 = 0;
    weight_4 = 0;
    weight_5 = 0;
    weight_6 = 0.35;
    weight_7 = 0.2;
    weight_8 = 0.09;
    
    Y = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';'R';'S';'T';'V';'W';'X';'Y';'Z'];

        
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
        
        matrix(i,1)=Y(i);
        matrix2(i,1)=statsValue1(i);
        matrix2(i,2)=statsValue2(i);
        matrix2(i,3)=statsValue3(i);
        matrix2(i,4)=statsValue4(i);
        matrix2(i,5)=statsValue5(i);
        matrix2(i,6)=statsValue6(i);
        matrix2(i,7)=statsValue7(i);
        matrix2(i,8)=statsValue8(i);

    end
    
    
    total = statsValue1 + statsValue2 + statsValue3 + statsValue4 + statsValue5 + statsValue6 + statsValue7 + statsValue8;
    total = statsValue1*weight_1+statsValue2*weight_2+statsValue3*weight_3+statsValue4*weight_4+statsValue5*weight_5+statsValue6*weight_6+statsValue7*weight_7+statsValue8*weight_8;
    
    %total = normalize(total, 'range');
    
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
            
            matrix3(count,1)=statsValueRes1(count);
            matrix3(count,2)=statsValueRes2(count);
            matrix3(count,3)=statsValueRes3(count);
            matrix3(count,4)=statsValueRes4(count);
            matrix3(count,5)=statsValueRes5(count);
            matrix3(count,6)=statsValueRes6(count);
            matrix3(count,7)=statsValueRes7(count);
            matrix3(count,8)=statsValueRes8(count);
        
        
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
    
    
    totalRes = statsValueRes1 + statsValueRes2 + statsValueRes3 + statsValueRes4 + statsValueRes5 + statsValueRes6 + statsValueRes7 + statsValueRes8;
    totalRes = statsValueRes1*weight_1+statsValueRes2*weight_2+statsValueRes3*weight_3+statsValueRes4*weight_4+statsValueRes5*weight_5+statsValueRes6*weight_6+statsValueRes7*weight_7+statsValueRes8*weight_8;
    
    for i = 1:8
        rest(i) = matrix2(26, i)-matrix3(7, i);
    end
    
    
    %totalRes = normalize(totalRes, 'range');
    
    total = total'
    totalRes = totalRes'
    Y = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';'R';'S';'T';'V';'W';'X';'Y';'Z'];
    F = fitcecoc(total,Y);
    Yp = predict(F,totalRes);
    Yp'
    
    %confusionchart(Y,Yp)
end


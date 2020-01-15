function [] = detector2(I)
    close all;
    IM = imresize(I, [4096, 4096]);
    imshow(IM);
    h = imrect; %draw something
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    [rows, cols, color] = size(I);
    color
    cells = mat2tiles(IM, [64, 64]);
    hog2 = extractHOGFeatures(cells{1, 1});
    [cellRows, cellCols] = size(cells);
    labels = zeros(1, cellCols * cellRows);
    [hogRows, hogCols] = size(hog2);
    hog = zeros(cellCols * cellRows, hogCols);
    color = zeros(cellCols * cellRows,1);
    color2 = zeros(cellCols * cellRows,1);
    labels = repelem("Background", cellCols * cellRows);
    
    SX = userBox(1);
    SY = userBox(2);
    SXMax = userBox(1)+userBox(3);
    SYMax = userBox(2)+userBox(4);
    
    z=0;
    
    IM2 = imread('cow2.jpg');
    IM2 = imresize(IM2, [4096, 4096]);
    cells2 = mat2tiles(IM, [64, 64]);
    hog2 = extractHOGFeatures(cells2{1, 1});
    [cell2Rows,cell2Cols] = size(hog2);
    hog2 = zeros(64*64,cell2Cols);
    aux = IM;
    backHogs = 4096;
    for i = 1:cellRows
        for j = 1:cellCols
            k = 1;
            l = 1;
            x = (i-1)*64+l;
            y = (j-1)*64+k;
            z = z + 1;
            hog(z, :) = extractHOGFeatures(cells{i, j});
            hog2(z,:) = extractHOGFeatures(cells2{i, j});
            result = histRGB(cells{i, j});
            color(z,:)=mean(mean(result(1))+mean(result(2))+mean(result(3)));
%             result = histRGB(cells2{i, j});
%             color2(z,:)=mean(mean(result(1))+mean(result(2))+mean(result(3)));
            if (y>SX && x>SY && y<SXMax && x< SYMax  )
                %Punt minim caixa fora selecio
                labels(z) = "Foreground";
                backHogs = backHogs - 1;
                continue;
            end
            k = 1;
            l = 64;
            x = (i-1)*64+l;
            y = (j-1)*64+k;
            if (y>SX && x>SY && y<SXMax && x< SYMax  )
                %X maxima caixa fora selecio
                labels(z) = "Foreground";backHogs = backHogs - 1;
                continue;
            end
             k = 64;
             l = 1;
             x = (i-1)*64+l;
             y = (j-1)*64+k;
             if (y>SX && x>SY && y<SXMax && x< SYMax )
                 labels(z) = "Foreground";backHogs = backHogs - 1;
                 continue;
                 %Y max fora
             end
             k = 64;
             l = 64;
             x = (i-1)*64+l;
             y = (j-1)*64+k;
             if (y>SX && x>SY && y<SXMax && x< SYMax )
                 labels(z) = "Foreground";backHogs = backHogs - 1;
                 continue;
             end
        end
    end
    %Obtenim la informacio de color del fons 
    x=0;
    backColors = 0;
    firstB = 1;
%     firstF = 1;
%     color3 = 0;
    hog3It = 1;
%     hog4It = 1;
    hog3 = zeros(backHogs,hogCols);
%     hog4 = zeros(4096-backHogs,hogCols);
    for i = 1:cellRows
        for j = 1:cellCols
            x=x+1;
            if labels(x) == "Background"
                if firstB == 1
                firstB = 0;
                backColors = color(x);
%               hog3(hog3It) = hog(x);
%               hog3It = hog3It + 1;
                else
                    backColors = [backColors color(x)];
                    hog3(hog3It) = hog(x);
                    hog3It = hog3It + 1;
                end
%             else
%                 if firstF == 1
%                     firstF = 0;
%                     color4 = color(x);
%                     hog4(hog4It) = hog(x);
%                     hog4It = hog4It + 1;
%                 else
%                     color4 = [color4 color(x)];
%                     hog4(hog4It) = hog(x);
%                     hog4It = hog4It + 1;
%                 end
            end
        end
    end
%     %color3 -> color de fons
%     %color4 -> color de interes
    [rowsColorBack,columnsColorBack] = size(backColors);
%     [rowsColor4,columnsColor4] = size(color4);
%     BackLabels = repelem("Background", columnsColor3);
%       backColors = reshape(backColors,columnsColorBack,1);
%     color4 = reshape(color4,columnsColor4,1);
%     clasColor = fitcecoc([hog3 color3], BackLabels);
%     backgroundPredict = predict(clasColor,[hog3 color3]);
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            if labels(x) == "Foreground"
                k = 1;
                trobat = 0;
                while (k< columnsColorBack && trobat == 0)
                    if backColors(k) == color(x) %&& hog3(k) == hog(x)
                   xs     labels(x) = "Background";
                        trobat=1;
                    end
                    k = k + 1;
                end
            end
        end
    end
    
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            for k = 1:64
                for l = 1:64
                    if labels(x) == "Foreground"
                    aux((i-1)*64+l,(j-1)*64+k,1) = 256;
%                     IM((i-1)*64+l,(j-1)*64+k,2) ;
%                     IM((i-1)*64+l,(j-1)*64+k,3) = 0;
                    end
                end
            end
        end
    end
    figure;
    imshow(aux);
    
    
    
%     %Binaritzem imatge 
%     IMBin = imcrop(IM,userBox);
%     figure;
%     imshow(IMBin);
%     
%     IMBin = rgb2gray(IMBin);
%     figure;
%     imshow(IMBin);
    
    
%     
%     clasificador = fitcecoc([hog color], labels, "Prior", [15,8]);
    clasificador = fitcecoc([hog color], labels);
%     clasificador = fitcecoc(hog, labels);
    [label, score, cost] = predict(clasificador, [hog color]);
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            for k = 1:64
                for l = 1:64
                    if label(x) == "Foreground"
                    IM((i-1)*64+l,(j-1)*64+k,1) = 256;
%                     IM((i-1)*64+l,(j-1)*64+k,2) ;
%                     IM((i-1)*64+l,(j-1)*64+k,3) = 0;
                    end
                end
            end
        end
    end
    figure;
    imshow(IM);
    [label, score, cost] = predict(clasificador,[hog2 color2]);
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            for k = 1:64
                for l = 1:64
                    if label(x) == "Foreground"
                    IM2((i-1)*64+l,(j-1)*64+k,1) = 256;
%                     IM((i-1)*64+l,(j-1)*64+k,2) ;
%                     IM((i-1)*64+l,(j-1)*64+k,3) = 0;
                    end
                end
            end
        end
    end
    figure;
    title("Prediction");
    imshow(IM2);
    
end

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
            result = histRGB(cells2{i, j});
            color2(z,:)=mean(mean(result(1))+mean(result(2))+mean(result(3)));
            if (y>SX && x>SY && y<SXMax && x< SYMax  )
                %Punt minim caixa fora selecio
                labels(z) = "Foreground";
            end
            k = 1;
            l = 64;
            x = (i-1)*64+l;
            y = (j-1)*64+k;
            if (y>SX && x>SY && y<SXMax && x< SYMax  )
                %X maxima caixa fora selecio
                labels(z) = "Foreground";
            end
             k = 64;
             l = 1;
             x = (i-1)*64+l;
             y = (j-1)*64+k;
             if (y>SX && x>SY && y<SXMax && x< SYMax )
                 labels(z) = "Foreground";
                 %Y max fora
             end
             k = 64;
             l = 64;
             x = (i-1)*64+l;
             y = (j-1)*64+k;
             if (y>SX && x>SY && y<SXMax && x< SYMax )
                 labels(z) = "Foreground";
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
    title("Prediction");
    imshow(aux);
    
    
%     
    clasificador = fitcecoc([hog color], labels, "Prior", [15,8]);
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

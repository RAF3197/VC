function [] = detector4(I)
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
    colorR = zeros(cellCols * cellRows,256);
    colorG = zeros(cellCols * cellRows,256);
    colorB = zeros(cellCols * cellRows,256);
    color2R = zeros(cellCols * cellRows,256);
    color2G = zeros(cellCols * cellRows,256);
    color2B = zeros(cellCols * cellRows,256);
    labels = repelem("Background", cellCols * cellRows);
    
    SX = userBox(1);
    SY = userBox(2);
    SXMax = userBox(1)+userBox(3);
    SYMax = userBox(2)+userBox(4);
    
    z=0;
    
    IM2 = imread('Snow2.png');
    IM2 = imresize(IM2, [4096, 4096]);
    cells2 = mat2tiles(IM2, [64, 64]);
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
            colorR(z,:)=result(1);
            colorG(z,:)=result(2);
            colorB(z,:)=result(3);
            result = histRGB(cells2{i, j});
            color2R(z,:)=result(1);
            color2G(z,:)=result(2);
            color2B(z,:)=result(3);
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
    backColorsR = zeros(backHogs,256);
    backColorsG = zeros(backHogs,256);
    backColorsB = zeros(backHogs,256);
    firstB = 1;
%     firstF = 1;
%     color3 = 0;
    hog3It = 1;
%     hog4It = 1;
backColorIt = 1;
    hog3 = zeros(backHogs,hogCols);
%     hog4 = zeros(4096-backHogs,hogCols);
    for i = 1:cellRows
        for j = 1:cellCols
            x=x+1;
            if labels(x) == "Background"
                backColorsR(backColorIt,:) = colorR(x,:);
                backColorsG(backColorIt,:) = colorG(x,:);
                backColorsB(backColorIt,:) = colorB(x,:);
                backColorIt = backColorIt +1;
%               hog3(hog3It) = hog(x);
%               hog3It = hog3It + 1;
            end
        end
    end
%     %color3 -> color de fons
%     %color4 -> color de interes
    [rowsColorBack,columnsColorBack] = size(backColorsR);
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            if labels(x) == "Foreground"
                k = 1;
                trobat = 0;
                while (k< columnsColorBack && trobat == 0)
                    a = ((sum(backColorsR(k,:)) +  sum(backColorsB(k,:)) + sum(backColorsG(k,:)))) - (sum(colorR(x,:)) +  sum(colorB(x,:)) + sum(colorG(x,:)));
                    if hog3(k) == hog(x) && (-20 <= a || a >= 20)
                        labels(x) = "Background";
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
    
    
    clasificador = fitcecoc([hog colorR colorG colorB ], labels);
%     clasificador = fitcecoc(hog, labels);
    [label, score, cost] = predict(clasificador, [hog colorR colorG colorB ]);
%     x = 0;
%     for i=1:64
%         for j=1:64
%             x = x + 1; 
%             for k = 1:64
%                 for l = 1:64
%                     if label(x) == "Foreground"
%                     IM((i-1)*64+l,(j-1)*64+k,1) = 0;
%                     IM((i-1)*64+l,(j-1)*64+k,2) = 0  ;
%                     IM((i-1)*64+l,(j-1)*64+k,3) = 0;
%                     end
%                 end
%             end
%         end
%     end
%     figure;
%     imshow(IM);
    
    %Binaritzem i eliminem soroll 
    
    IMGray = rgb2gray(IM);
    fores = 0;
        x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            for k = 1:64
                for l = 1:64
                    if label(x) == "Foreground"
                    IMGray((i-1)*64+l,(j-1)*64+k) = 0;
                    fores = fores + 1;
                    if labels(x) == "Background"
                        IMGray((i-1)*64+l,(j-1)*64+k) = 256;
                    end
                    else
                    IMGray((i-1)*64+l,(j-1)*64+k) = 256;
                    end
                    
                end
            end
        end
    end

%     BW = imbinarize(IMGray,'global');
figure;
    imshow(IMGray);
%     IMGray = imcrop(IMGray,userBox);
    
    BW = bwareaopen(IMGray,64 * 64 * 64,18);
    figure;
    imshow(BW);
    se = strel('disk',8);
    closeBW = imclose(BW,se); figure, imshow(closeBW)
    %a = bwconncomp(closeBW,18);
    a = bwareafilt(closeBW,1);
    
    figure;
    imshow(a);
    
    BW2 = bwareafilt(closeBW);
    figure;
    imshow(BW2)
    
    %Reseguim amb un Marker la CC + gran que trobem en la imatge.
    
    
    [label2, score, cost] = predict(clasificador,[hog2 color2R color2G color2B]);
    x = 0;
    for i=1:64
        for j=1:64
            x = x + 1; 
            for k = 1:64
                for l = 1:64
                    if label2(x) == "Foreground"
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


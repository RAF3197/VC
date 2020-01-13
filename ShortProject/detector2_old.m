function [] = detector2(I)
    imshow(I);
    h = imrect; %draw something 
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    %Background vs Foreground
    %si esta dins de la seleccio Foreground, si esta fora Background
    [rows,cols,color] = size(I);
    color
    %celes de 15x15     
    IM = imresize(I,[2048,2048]);
    cells = mat2tiles(IM,[32,32]);
    cells(1,1)
    hog2 = extractHOGFeatures(cells{1,1});
    [cellRows,cellCols] = size(cells);
    %re = reshape(cells,[512,512]);
    %image(cells)
    %figure;
    labels = zeros(1,32*32);
    x = 1;
   [hogRows,hogCols] =  size(hog2);
    hog = zeros(32*32,hogCols);
    labels = repelem("Background",32*32);
    %[freq, freq_emph, freq_app] = image_hist_RGB_3d(cells{1,1});
   % rgb = histRGB(cells{1,1});
    rgbHisto = zeros(32,32);
    for i = 1:cellRows
        for j = 1:cellCols
            if ((i<userBox(1) && j<=userBox(2)) || (i>=userBox(1) + userBox(3) && j>=userBox(2)+userBox(4)))
                %Backgroud
                if((i*32<userBox(1) && j*32<=userBox(2)) || (i*32>=userBox(1) + userBox(3) && j*32>=userBox(2)+userBox(4)))
                    %Background
                    labels(x) = "Background";
                    hog(x,:) = extractHOGFeatures(cells{i,j});
                    x = x + 1;
                    %rgbHisto(i,j) = RGBhistogram(cells{i,j});
%                    imshow(cells{i,j});
                else
                    %Foreground
                    labels(x) = "Foreground";
                    hog(x,:) = extractHOGFeatures(cells{i,j});
                    x = x + 1;
                   % rgbHisto(i,j) = RGBhistogram(cells{i,j});
                end
            else
                %Foreground
                labels(x) = "Foreground";
                hog(x,:) = extractHOGFeatures(cells{i,j});
                x = x + 1;
                %rgbHisto(i,j) = RGBhistogram(cells{i,j});
            end
        end
    end
    %Entrenem
    hogF = hog(:);
    clasificador = fitcecoc(hog,labels);
    [label,score,cost] = predict(clasificador,hog);
    reimage = zeros(2048,2048);
    for i = 1:size(label)
        if (label(i) == "Background")
            for j = 1:32
                for k = 1:32
                    cell = cells{i*32,i*32}
                    reimage(j*i,k*i)=cell{j,k};
                end
            end
        end
    end
    %Histograma de color 
    red = I(:,:,1);
    blue = I(:,:,2);
    green = I(:,:,3);
    %Obtenim Histogrames
    
    [yred,x] = imhist(red);
    [ygreen,x] = imhist(green);
    [yblue,x] = imhist(blue);
    plot(x, yred, 'Red', x, ygreen, 'Green', x, yblue, 'Blue');
    
    %Apliquem HOG
   % crop = imcrop(I,userBox);
    %figure;
    %imshow(crop);
    %[features,visual] = extractHOGFeatures(crop);
    %hold on;
    %plot(visual);
    %RGB3D_Histogram;
end


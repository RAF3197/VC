function [] = detector2(I)
    close all;
    IM = imresize(I, [4096, 4096]);
    imshow(IM);
    h = imrect; %draw something
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    IM2 = IM(:,:);
    %Background vs Foreground
    %si esta dins de la seleccio Foreground, si esta fora Background
    [rows, cols, color] = size(I);
    color
    %celes de 15x15
    %IM = imresize(I, [4096, 4096]);
    cells = mat2tiles(IM, [64, 64]);
    cells(1, 1)
    hog2 = extractHOGFeatures(cells{1, 1});
    [cellRows, cellCols] = size(cells);
    %re = reshape(cells,[512,512]);
    %image(cells)
    %figure;
    labels = zeros(1, 64 * 64);
    x = 1;
    [hogRows, hogCols] = size(hog2);
    hog = zeros(64 * 64, hogCols);
    labels = repelem("Background", 64 * 64);
    %[freq, freq_emph, freq_app] = image_hist_RGB_3d(cells{1,1});
    % rgb = histRGB(cells{1,1});
    rgbHisto = zeros(64, 64);
    for i = 1:cellRows
        for j = 1:cellCols
            if ((i <= userBox(1) && j <= userBox(2)) || (i >= userBox(1) + userBox(3) && j >= userBox(2) + userBox(4)))
                %Backgroud
                if ((i * 64 <= userBox(1) && j * 64 <= userBox(2)) || (i * 64 >= userBox(1) + userBox(3) && j * 64 >= userBox(2) + userBox(4)))
                    %Background
                    labels(x) = "Background";
                    hog(x, :) = extractHOGFeatures(cells{i, j});
                    x = x + 1;
                   % cells{i,j} = 0;
                    %rgbHisto(i,j) = RGBhistogram(cells{i,j});
                    %imshow(cells{i,j});
                else
                    %Si Tile no esta sancera fora de la selecio, veiem si
                    %la majoria esta dins o fora
                    if ((i * 32 <= userBox(1) && j * 32 <= userBox(2)) || (i * 32 >= userBox(1) + userBox(3) && j * 32 >= userBox(2) + userBox(4)))
                        %Background
%                         cells{i,j} = 0;
                        labels(x) = "Background";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                        %rgbHisto(i,j) = RGBhistogram(cells{i,j});
                        %imshow(cells{i,j});
                    else
%                         cells{i,j} = 0;
                        %Foreground
                        labels(x) = "Foreground";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                        % rgbHisto(i,j) = RGBhistogram(cells{i,j});
                    end
                end
            else
                %El principi del Tile esta dins la selecio, mirem si el
                %final també ho esta
                if ((i >= userBox(1) && j >= userBox(2)) && (i <= userBox(1) + userBox(3) && j <= userBox(2) + userBox(4)))

                    if ((i * 64 >= userBox(1) && j * 64 >= userBox(2)) && (i * 64 <= userBox(1) + userBox(3) && j * 64 <= userBox(2) + userBox(4)))
                        %Esta integrament dins la selecio
                        %Foreground
%                         cells{i,j} = 0;
                        labels(x) = "Foreground";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                        %rgbHisto(i,j) = RGBhistogram(cells{i,j});
                    elseif ((i * 32 >= userBox(1) && j * 32 >= userBox(2)) && (i * 32 <= userBox(1) + userBox(3) && j * 32 <= userBox(2) + userBox(4)))
                        %No esta integrament dins la selecio, pero el 50%
                        %si ho esta, és Foreground
                        %Foreground
%                         cells{i,j} = 0;
                        labels(x) = "Foreground";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                        %rgbHisto(i,j) = RGBhistogram(cells{i,j});
                    else
                        %Si el 50% no esta dins la selecio es Background
%                         cells{i,j} = 0;
                        labels(x) = "Background";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                        %rgbHisto(i,j) = RGBhistogram(cells{i,j});
                        %imshow(cells{i,j});
                    end
                end
            end
        end
    end
    figure;
    imshow(IM);
    %Entrenem
    %hogF = hog(:);
    clasificador = fitcecoc(hog, labels);
    [label, score, cost] = predict(clasificador, hog);
    reimage = zeros(4096, 4096);
%     figure;
%     res = zeros(4096,4096,3,'uint8');
%     x=1;
%     for i=1:cellRows
%         for j=1:cellCols
%             result=cells{i,j};
%             for j = 1:64
%                 for k = 1:64
%                     aux = j*k;
%                     res(x,1) = result(j,k,1);
%                     res(x,2) = result(j,k,2);
%                     res(x,3) = result(j,k,3);
%                 end
%             end
%             x = x + 1;
%         end
%     end
%     test = reshape(res,4096,4096,3);
%     figure;
%     imshow(test);
    %Recomposem la imatge
    %Posem els labels en una matriu de 64x64
    matRef = reshape(label,64,64);
%    IM2 = zeros(64*64,64*64,3,'uint8');
figure;
    for i = 1:64
        for j = 1:64
            if matRef(i,j) == "Background"
                for k = 1:64
                    for l = 1:64
                        imshow(IM(i*k,l*j));
                       
%                         IM=insertMarker(IM,[i*k j*l],'x','size',64);
                    end
                end
            else
                for k = 1:64
                    for l = 1:64
%                         IM(k,l,1)=0;
%                         IM(k,l,2)=0;
%                         IM(k,l,3)=0;
                        %IM(k+i,l+j,:,:)=0;
                       % IM(k+i,l+j,3)=0;
                       
                    end
                end
            end
        end
    end
    %Histograma de color
    figure;
    imshow(IM);
    red = I(:, :, 1);
    blue = I(:, :, 2);
    green = I(:, :, 3);
    %Obtenim Histogrames

    [yred, x] = imhist(red);
    [ygreen, x] = imhist(green);
    [yblue, x] = imhist(blue);
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

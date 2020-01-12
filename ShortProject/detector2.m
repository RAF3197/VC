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
    IM = imresize(I,[512,512]);
    cells = mat2cell(IM,4,4,3);
    imshow(cells);
    for i = 1:rows
        for j = 1:cols
            if ((i<userBox(1)<= i && j<=userBox(2)) || (i>=userBox(1) + userBox(3) && j>=userBox(2)+userBox(4)))
                %Backgroud
                
            else
                %Foreground
                
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
    crop = imcrop(I,userBox);
    figure;
    imshow(crop);
    [features,visual] = extractHOGFeatures(crop);
    hold on;
    plot(visual);
    RGB3D_Histogram;
end


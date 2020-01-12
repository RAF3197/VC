function [] = detector2(I)
imshow(I);
    h = imrect; %draw something 
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    %Histograma de color 
    red = I(:,:,1);
    blue = I(:,:,2);
    green = I(:,:,3);
    %Obtenim Histogrames
    [yred,x] = imhist(red);
    [ygreen,x] = imhist(green);
    [yblue,x] = imhist(blue);
    plot(x, yred, 'Red', x, ygreen, 'Green', x, yblue, 'Blue');
    Histo = hist3(I);
    plot(Histo);
    %Apliquem HOG
    crop = imcrop(I,userBox);
    figure;
    imshow(crop);
    [features,visual] = extractHOGFeatures(crop);
    hold on;
    plot(visual);
end


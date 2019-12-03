function [] = detector(I)
    imshow(I);
    h = imrect; %draw something 
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    
    redChannel = I(:,:,1); % Red channel
    greenChannel = I(:,:,2); % Green channel
    blueChannel = I(:,:,3); % Blue channel
    
    figure;
    imshow(redChannel);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    
    figure;
    imshow(greenChannel);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    
    figure;
    imshow(blueChannel);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    
    
    %M = ~h.createMask();
    %I(M) = 0;
    %imshow(I);
end
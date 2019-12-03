function [] = detector(I)
    imshow(I);
    h = imrect; %draw something 
    userBox = h.getPosition
    delete(h);
    rectangle('Position', userBox, 'Edgecolor', 'r');
    
    
    %M = ~h.createMask();
    %I(M) = 0;
    %imshow(I);
end
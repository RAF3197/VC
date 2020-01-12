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
    
    %Crop Imatge 
    
    redCrop = imcrop(redChannel,userBox);
    greenCrop = imcrop(greenChannel,userBox);
    blueCrop = imcrop(blueChannel,userBox);
    
    redBack = redChannel;
    greenBack = greenChannel;
    blueBack = blueChannel;
    
    for i=1:size(redChannel)
        if (i>=userBox(1) || i<=userBox(3)-userBox(1))
            for j=1:size(redChannel(i))
                if (j>=userBox(2) || j<=userBox(4)-userBox(2))
                    redBack(i ,j) = 0;
                end
            end
        end
    end
    
    for i=1:size(blueChannel)
        if (i>=userBox(1) || i<=userBox(3)-userBox(1))
            for j=1:size(blueChannel(i))
                if (j>=userBox(2) || j<=userBox(4)-userBox(2))
                    blueBack(i ,j) = 0;
                end
            end
        end
    end
    
    for i=1:size(greenChannel)
        if (i>=userBox(1) || i<=userBox(3)-userBox(1))
            for j=1:size(greenChannel(i))
                if (j>=userBox(2) || j<=userBox(4)-userBox(2))
                    greenBack(i ,j) = 0;
                end
            end
        end
    end
    
    %HOG
    
    %Histogrames Color
    
    %M = ~h.createMask();
    %I(M) = 0;
    %imshow(I);
end
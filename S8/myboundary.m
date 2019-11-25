function [] = myboundary(I)
    % simplified polygonal boundary of a BW image
    BW = rgb2gray(I) < 168;
    imshow(BW); pause(1);
    CC = bwconncomp(BW);
    idxlists = CC.PixelIdxList;
    
    stats = regionprops(CC,'all');
    for (i = 1:30)
        1 - stats(i).EulerNumber
    end
    
    %1 és la posició dels caracters que ha trobat
    pixels = idxlists{3};
    
    [F,C] = ind2sub(size(BW), pixels);
    % exterior boundary
    k = boundary([F,C],1); % loose factor  
    % reduce polygonal
    [RF,RC] = reducem(F(k),C(k),5); % tolerance = 5 degrees
    %plot boundary
    imshow(128*uint8(BW));hold
    plot(RC,RF,'LineWidth',8);
end
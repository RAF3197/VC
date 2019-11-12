function [res] = lab7sol(I)
    BW = rgb2gray(I);
    BW = BW > 3;
    
    EE = strel('disk', 10);
    BWOpen = imopen(BW,EE);    
    BOF = not(imfill(BWOpen, 'holes'));
    TD = bwdist(BOF, 'euclidean');
    TD = imopen(TD,EE);    

    %watershed
    TD = -TD;
    TD (BOF) = -Inf;
    TD = floor(TD);
    TD = medfilt2(TD, [10 10]);
    WS = watershed(TD);
    
    %agafem el contorn i el dilatem
    contorn = (WS == 0);
    EED = strel('disk',2);
    contorn = imdilate(contorn, EED);
    contorn = cat(3,contorn,contorn, 0*contorn);
    
    %contem quantes celules hi han
    C = bwconncomp(contorn);
    %S = regionprops(C, 'Area');
    %L = labelmatrix(C);
    %contorn = ismember(L, find([S.Area] >= 500));
    C.NumObjects
    
    res = I + im2uint8(contorn);
end


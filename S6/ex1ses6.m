function [N] = ex1ses6(I)
    WH = rgb2gray(I);
    WH = WH > 1;
    WH = imfill(WH, 'holes');
    
    %%OPENING
    %erosió
    S = strel('disk', 5);
    WHO = imerode(WH, S);

    %dilatació
    S = strel('disk', 6);
    WHO = imdilate(WHO, S);

    %diferència
    R = WH & not(WHO);
    
    lab = bwconncomp(R);
    N = lab.NumObjects
    
    imshow(R);
end


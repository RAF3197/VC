function [N] = ex1ses6(I)
    WH = rgb2gray(I);
    WH = WH > 1;
    WH = imfill(WH, 'holes');
    
    %%OPENING
    %erosi�
    S = strel('disk', 5);
    WHO = imerode(WH, S);

    %dilataci�
    S = strel('disk', 6);
    WHO = imdilate(WHO, S);

    %difer�ncia
    R = WH & not(WHO);
    
    lab = bwconncomp(R);
    N = lab.NumObjects
    
    imshow(R);
end


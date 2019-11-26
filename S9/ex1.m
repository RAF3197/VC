function [] = ex1()
 I = imread('mat1.jpg');
    I = rgb2gray(I);
    I = medfilt2(I,[5 5]);
    M = colfilt(I, [50 50], 'sliding', @mean);
    BW = I > M + 16;
    %imshow(BW);
    CC = bwconncomp(BW);
    Matricules = regionprops(CC,'BoundingBox');
    for i = 1:size(Matricules)
        Matricula = Matricules(i).BoundingBox;
        if Matricula(3) / Matricula(4) >= 3 && Matricula(3) / Matricula(4) <= 5
            Matricula(1)
            Matricula(2)
        end
    end
end
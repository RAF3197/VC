function [] = detector_matricula(I)
    I = rgb2gray(I);
    %I = medfilt2(I,[5 5]);
    M = colfilt(I, [50 50], 'sliding', @mean);
    BW = I > M + 16;
    imshow(BW);
    hold on;
    CC = bwconncomp(BW);
    mats = regionprops(CC,'BoundingBox');
    for i = 1:size(mats)
        mat = mats(i).BoundingBox;
        left = mat(1);
        top = mat(2);
        width = mat(3);
        height = mat(4);
        
        ar = width/height;
        if ar > 3 && ar < 5 && width > 50
            rectangle('Position',[left, top, width, height], 'Edgecolor', 'r');
            I2 = imcrop(I,[left, top, width, height]);
            
            numbers(I2);
        end
    end
end
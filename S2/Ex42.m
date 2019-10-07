function[R] = Ex42(Image1, Image2, tform)
    Image1R = imwarp(Image1,tform);
    R = imfuse(Image1R,Image2);
    R = rgb2gray(R);
end
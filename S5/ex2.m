function [] = ex2(m,n,k)
I = imread('Enters.jpg');
I = rgb2gray(I);
I = uint8(colfilt(I,[m n],'sliding',@bin_local,k));
imshow(I);
end


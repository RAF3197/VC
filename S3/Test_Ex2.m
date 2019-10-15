clear all; close all;
X = imread('img3.tif');
%Y = rgb2gray(X);
Y = imnoise(X,'salt & pepper',0.1);
%z = colfilt(Y,[3 3],'sliding',@Ex2);
z = Ex2(Y)
%imshow(z);

original = im2double(imread('img3.tif'));
original = original(1:5,1:8,1);

filter = 1/9 * [-1 -1 -1 ; -1 17 -1 ; -1 -1 -1];
s = size(original);
r = zeros(s);
original=padarray(original,[1,1]);
for i = 2:s(1)
for j = 2:s(2)
    temp = original(i-1:i+1,j-1:j+1) .* filter;
    r(i-1,j-1) = sum(temp(:));
end
end

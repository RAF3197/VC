X = imread('img3.tif');
%Y = rgb2gray(X);
Y = imnoise(X,'salt & pepper',0.1);
z = colfilt(Y,[5 5],'sliding',@Ex2);
imshow(z);
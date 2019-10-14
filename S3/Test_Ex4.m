X = imread('img2tif');
X = img2gray(X);
y = Ex4(X,122,43);
imshow(y);
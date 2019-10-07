I1 = imread('img1.jpeg');
I2 = imread('img2.jpeg');

transf = affine2d([1 0 0; .5 1 0; 0 0 1]);
Res = Ex42(I1,I1,transf);

imshow(Res);
clear all; close all;
I=imread('img2.jpeg');
I=rgb2gray(I);
noiselevel=0.2;
figure
subplot(131),imshow(I,[]);
title 'Original Image'
rand('seed', 0);
J=I;
FF=rand(size(J));
J(FF<=(noiselevel/2))=0;
J(FF>=(1-noiselevel/2) & FF<=1)=255;
p_noise=psnr(double(I),double(J))
subplot(1,3,2),imshow(J,[]);
title 'Noisy Image'
[M,F2]=Ex2(J);
p_AWMF = psnr(double(I),double(M))
subplot(133);imshow(M,[]);
title 'Result'
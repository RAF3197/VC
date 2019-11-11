function [] = ex3(k)
I = imread('normal-blood1.jpg');
tam = size(I);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
RGB = [R(:),G(:),B(:)];
RGB2 = kmeans(double(RGB),k);

RGB3 = reshape(RGB2,tam(1), tam(2));
mapping = [ 1, 1, 0 
            0, 1, 1 
            0, 1, 0 
            0, 0, 1 
            1, 0, 0 ];
%figure;
%subplot(1,2,2);
bwconncomp(RGB3)
imshow(RGB3, mapping);
end


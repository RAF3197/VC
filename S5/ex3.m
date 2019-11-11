function [] = ex3(k)
I = imread('normal-blood1.jpg');
tam = size(I);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
RGB = [R(:),G(:),B(:)];
RGB2 = kmeans(double(RGB),k);

HSV = rgb2hsv(I);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

HSV = [V(:), S(:), sin(H(:)), cos(H(:))];
HSV2 = kmeans(double(HSV),k);
HSV3 = reshape(HSV2,tam(1), tam(2));

RGB3 = reshape(RGB2,tam(1), tam(2));
mapping = [ 1, 1, 0 
            0, 1, 1 
            0, 1, 0 
            0, 0, 1 
            1, 0, 0 ];

%subplot(1,2,1);
imshow(HSV3, mapping);
%figure;
%subplot(1,2,2);
imshow(RGB3, mapping);
end


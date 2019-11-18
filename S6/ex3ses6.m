function [] = ex3ses6(I)
I = rgb2gray(I);
BW = I<180;
BW = imfill(BW, 'holes');
BW = imopen(BW, strel('disk', 3));

BW2 = false(size(BW));
BW2(1,:) = true;
BW2(:,1) = true;
BW2(end,:) = true;
BW2(:,end) = true;
BWR = imreconstruct(BW2,BW);
BWR = BW - BWR;

BWR = bwulterode(BWR);
R = bwdist(BWR, 'euclidean');
R = -R;

[X,Y] = max(R(:));
[A,B] = ind2sub(size(I),Y);

I = insertMarker(I,[A B],'+','color','red','size',25);
imshow(I);
end




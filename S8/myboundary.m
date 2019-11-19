% simplified polygonal boundary of a BW image
I = imread('pawn.png');
imshow(I); pause(1);
BW = rgb2gray(I) < 168;
CC = bwconncomp(BW);
idxlists = CC.PixelIdxList;
pixels = idxlists{1};
[F,C] = ind2sub(size(BW), pixels);
% exterior boundary
k = boundary([F,C],1); % loose factor  
% reduce polygonal
[RF,RC] = reducem(F(k),C(k),5); % tolerance = 5 degrees
%plot boundary
imshow(128*uint8(BW));hold
plot(RC,RF,'LineWidth',8);
function [] = detector3(I)
close all;
IM = imresize(I, [4096, 4096]);
imshow(IM);
h = imrect; %draw something
userBox = h.getPosition
delete(h);
rectangle('Position', userBox, 'Edgecolor', 'r');
cells = mat2tiles(IM, [64, 64]);
[row,cols] = size(IM);

end


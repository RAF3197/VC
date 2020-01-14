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
[cellRows, cellCols] = size(cells);
SX = userBox(1);
SY = userBox(2);
SXMax = userBox(1)+userBox(3);
SYMax = userBox(2)+userBox(4);
for i = 1:cellRows
    for j = 1:cellCols
        k = 1;
        l = 1;
        x = (i-1)*64+j;
        y = (k-1)*64+l;
        if (x>=userBox(1) && y>=userBox(2) && x<=SXMax && y<= SYMax)
            %Punt minim caixa fora selecio
            k = 1;
            l = 64;
            x = (i-1)*64+j;
            y = (k-1)*64+l;
            if (x>=userBox(1) && y>=userBox(2) && x<=SXMax && y<= SYMax)
                %X maxima caixa fora selecio
                k = 64;
                l = 1;
                x = (i-1)*64+j;
                y = (k-1)*64+l;
                if (x>=userBox(1) && y>=userBox(2) && x<=SXMax && y<= SYMax)
                    %Y max fora
                    k = 64;
                    l = 1;
                    x = (i-1)*64+j;
                    y = (k-1)*64+l;
                    if (x>=userBox(1) && y>=userBox(2) && x<=SXMax && y<= SYMax)
                        % X, Y max fora
                        %Foreground
                        labels(x) = "Foreground";
                        hog(x, :) = extractHOGFeatures(cells{i, j});
                        x = x + 1;
                    end
                end
            end
        end
    end
end
end


function [P] = bin_local(win,k)
rows = size(win,1);
cols = size(win,2);
pixels = ceil(rows/2);
P = zeros(1,cols);
for i = 1:cols
    column = win(:,i);
    Average = mean(column);
    pixel = column(pixels);
    if(pixel-k >= Average)
        P(i) = 255;
    else
        P(i) = 0;
    end
end
end


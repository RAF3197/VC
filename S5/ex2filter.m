function [O] = ex2filter(I, k)
    avg = mean(mean(I));
    [m,n] = size(I);
    centerX = ceil(m/2);
    centerY = ceil(n/2);
    pixel = I(centerX, centerY);
    if (pixel*k>avg)
        O = 1;
    else
        O = 0;
    end
end

function [] = ex1(I, alpha)
    bw = rgb2gray(I);
    hist = imhist(bw);
   
    total = sum(hist, 'all');
    actual = 0;
    thresHolding = 0;
    
    for i = 1:length(hist)
        actual = actual + hist(i);
        if (actual>=total*(1-alpha))
            thresHolding = i;
            break
        end
    end
    imshow(bw>thresHolding);
end


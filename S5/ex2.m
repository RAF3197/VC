function [O] = ex2(I, N, k)
    I = rgb2gray(I);
    O = nlfilter(I, [N 3], @ex2filter, k); 
end



function [out] = EX3(I)
G = imgradient(I,'Sobel');
out =double( I) -double( G);

end


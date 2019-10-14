function [I] = Ex2(I)
margin = 4;
[f,c] = size(I);

for i = margin/2+1: (f-margin/2+1)
    for j =  margin/2+1 : (c-margin/2+1)
        if (I(i,j)==255 || I(i,j)==0)
            m = I(i-margin/2:i+margin/2-1,j-margin/2:j+margin/2-1);
            I(i,j) = (mean(mean(m)));
        end
    end
end
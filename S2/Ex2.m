function [h] = Ex2(I) 
    samples = 8;
    [f,c]=size(I);
    h=zeros(1,samples);
    for i=1:f
        for j=1:c
            pixel = I(i,j);
            z = floor((double(pixel)/256.0) * samples) +1;
            h(z)=h(z)+1;
        end
    end
end
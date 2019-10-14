function [ImgOut] = Ex2(ImgIn)
[x y] = size(ImgIn);
ImgOut = ImgIn(ceil(x/2),:);
for j=1:y
    if(ImgOut(j)==0||ImgOut(j)==255)
        ImgOut(j) = median(ImgIn(:,j));
    end
end
end

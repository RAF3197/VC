function [Y] = Ex4(ImgIn,ang,d)

X = zeros(d);
X(1,1:floor(d/2)) = 1;
X=X/ceil(d/2);
X=imrotate(X,ang);
Y=imfilter(ImgIn,X);

end


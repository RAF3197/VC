function [] = Ex3()

[x y] = meshgrid(-15:1:15);
z = cos(sqrt(x.*x+y.*y)/(2*pi));
z(z<0) = 0;
colormap hot;
surf(x,y,z);
end


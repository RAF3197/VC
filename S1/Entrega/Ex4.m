function [] = Ex4()

[x y] = meshgrid(0:1:59);
[k j] = meshgrid(-15:1:14);
z = cos(sqrt(k.*k+j.*j)/(2*pi));
z(z<0) = 0;
z = [z z;z z];
colormap jet;
surf(x,y,z);

end


function [] = Ex2()

x = linspace(0,6,30);
y = -cos(x);
y(y<0) = 0;
plot(x,y);
end


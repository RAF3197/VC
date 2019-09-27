function [] = Ex6()
x = 0.8:0.01:2
n = rand(121)*0.1;
n = n(1,:);
y = (x * 0.3) + n;
y = y -mean(y);
x = x - mean(x);
z = [x;y];
t = -atan(0.3);
R = [cos(t) -sin(t);sin(t) cos(t)];
pr = R*z;
xr=pr(1,:);
yr = pr(2,:);
scatter(xr,yr);
set(gca,'YAxisLocation','origin');
set(gca,'XAxisLocation','origin');
end
function [] = Ex6()
x = 0.8:0.01:2
n = rand(121)*0.1;
n = n(1,:);

y = (x * 0.21) + n;
y = y -mean(y);
x = x - mean(x);
scatter(x,y);
end


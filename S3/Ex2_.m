function [d,f]=Ex2(x1)
[row,col]=size(x1);
x1=double(x1);
x2=x1;
f=zeros(size(x1));
wmax=39;
w0=1;
h=1;
for i=1:row
    for j=1:col
        w = w0;
        while w <= wmax
            if w==w0
                wsize=w;
                c=x1(max(i-wsize,1):min(i+wsize,row),max(j-wsize,1):min(j+wsize,col));
                W1=sort(c(:));
                currmin = min(W1(:));
                currmax = max(W1(:));
            else
                W1=W2;
                currmin=nextmin;
                currmax=nextmax;
            end
            wsize=w+h;
            c=x1(max(i-wsize,1):min(i+wsize,row),max(j-wsize,1):min(j+wsize,col));
            W2=sort(c(:));
            nextmin = min(W2(:));
            nextmax = max(W2(:));
            if ~(currmin==nextmin && currmax==nextmax)
                w=w+h;
            else
                W11 = W1.*(W1>currmin).*(W1<currmax);
                temp = W11(W11(:)~=0);
                if ~isempty(temp)
                    currmean = mean(temp);
                    break;
                else
                    w=w+h;
                end
            end
        end
        if ~((currmin<x1(i,j)) && (x1(i,j)<currmax))
            x2(i,j) = currmean;
            f(i,j)=1;  % f=1,stands for noise.
        end
    end
end
d=double((x2));
end

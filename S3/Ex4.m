function [out] = Ex4(I,length,theta)

%We calculate the PSF manualy, that code is doing the same that
%the fspecial function
PSF=zeros(length);
PSF(1,1:fix(length/2))= 1;
PSF=PSF/round(length/2);
%Now we need to apply the PSF to the image with imfilter
out=imfilter(I,PSF,'conv','circular');

end


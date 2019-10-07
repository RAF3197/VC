function[PS] = Ex3(I)
    %escala de grisos
    I = rgb2gray(I);
    [f,c] = size(I);
    
    %cambiem tamany amb interpolació
    I2 = imresize(I, 3/7, 'lanczos2');
    I2 = imresize(I2,[f c], 'lanczos2');
    
    %calculem el PS
    PS = std2(I - I2);
end
function[newImage] = Ex4(Image1, Image2, tform)
    %Transformamos las imagenes a escala de grises
    %(Stiching)
    Image1_gray = rgb2gray(Image1);
    Image2_gray = rgb2gray(Image2);

    [f1, c1] = size(Image1_gray);

    I2 = imwarp(Image2_gray, tform);

    [f2, c2] = size(Image2_gray);

    fr = f2;
    fc = c1 + c2;
    
    %Creamos una matriz de '0' de tamaño fr x fc 
    
    newImage = cast(zeros(fr, fc), 'uint8');

    newImage(1:f1, 1:c1) = Image1_gray;
    
    newImage(1:fr, c1 + 1:fc) = I2;
end
function [] = lab7()
    I1 = imread('dna-14.png');
    I2 = imread('dna-18.png');
    I3 = imread('dna-26.png');
    I4 = imread('dna-38.png');
    
    h1 = lab7sol(I1);
    h2 = lab7sol(I2);
    h3 = lab7sol(I3);
    h4 = lab7sol(I4);
      
    montage({h1, h2, h3, h4})
end


function [] = apunts()
    load fisheriris;
    X = meas;
    Y = species;
    F = fitcecoc(X,Y);
    Yp = predict(F,X);
    confusionmat(Y,Yp);
    %50 plantes clasificades com a setosa, 49 de versicolor
    %(una fallada fentse pasar per multicolor) i multicolor tot b�
    
    %hi ha alg�n model millor?
    NF = TreeBagger(100, X, Y) %esperem el predint i esperem que sigui la veritat
    %ha anat m�s o menys igual
    
    T = table(X,Y);
    %classification learner, passar la taula. Millorar-> use parallel ->
    %distancia metric euclidean, distance weight equal, number neihbors, 6
    %(anar cambiant aquest valor i mirar el �ptim)
    
    Y = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';'B';'C';'D';'E';'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';'R';'S';'T';'V';'W';'X';'Y';'Z'];
    %mirar ex1
    
    %lector de matricules-> fer un binaritzat local de 50x50. Matlab en t�
    %un, adaptTreshold. La pasem i la binaritzem
    
    I = rgb2gray(spanish_vehicle)
    I = medfilt2(I,[5 5]);
    M = colfilt(I, [50 50], 'sliding', @mean);
    BW = I > M + 16;
    imshow(BW);
    
    
end
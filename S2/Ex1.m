function [] = Ex1(I)
    G = rgb2gray(I);
    [f,c] = size(G);
    
    %arrays dels sumatoris de les files/columnes
    sumFiles = zeros(f,'uint64');
    sumColumns = zeros(c,'uint64');
    
    for i = 1:f
        for j = 1:c
            pixel = double(G(i,j));
            
            %afegim el pixel a la f/c corresponent
            sumColumns(j) = sumColumns(j) + pixel;
            sumFiles(i) = sumFiles(i) + pixel;
        end
    end
    
    %obtenim els maxims de la f/c
    [m, posMaxFil] = max(sumFiles);
    [m, posMaxCol] = max(sumColumns);

    %printem 
    outputImage = insertShape(I,'circle',[posMaxCol(1,1) posMaxFil(1,1) 5],'LineWidth',4);
    imshow(outputImage);
end
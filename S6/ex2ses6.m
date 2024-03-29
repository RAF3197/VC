function [] = ex2ses6(I)
    BW = rgb2gray(I);
    BW = BW < 180;
    BW = imfill(BW, 'holes');
    
    SE = strel('disk', 5);
    C = imopen(BW, SE);
    
    Conn = bwconncomp(C);
    Conn.NumObjects
    S = regionprops(Conn,'centroid');
    centroids = cat(1, S.Centroid);
    
    imshow(C);
    hold on;
    plot(centroids(:,1),centroids(:,2),'+');
end
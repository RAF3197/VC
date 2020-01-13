function [rgbBins] = RGBhistogram(im)
% pathName references the location of the file within a directory 
% reads image, bins pixel values for RGB histogram and display 

% works for 8 BIT images and Scales down 16 bit...

% Example Input : 
% pathName = 'pathToDir/myimage.jpg';

orig_im = im; % save copy of original for viewing if scaling must occur

% Grab size of image dimensions
[X,Y,N]=size(im); % grab matrix dimensions of image
totpix = Y*X; % get total number of pixels for each color
Nbins = 2^8;

% check if RGB
if N ~=3
    fprintf(2,'Image not RGB!');
end

% check if 8 bit or 16 bit
maxVal = max(max(max(im))); % use for normalizing 16 bit to 8 bit
if maxVal > 255 % if 16 bit scale down
    im = uint8(im./255); 
end

thisBin = [0:1:Nbins-1]; % create a vector containing bin parameters

rgbBins = zeros(3,Nbins);
tic;
for i = 1:Nbins    
    rgbBins(1:3,i) = [sum(sum((im(:,:,1)==thisBin(1,i))))...
                      sum(sum((im(:,:,2)==thisBin(1,i))))...
                      sum(sum((im(:,:,3)==thisBin(1,i))))];   
end
elapsedTime = toc;

%% PLOT and Display Image/Histogram for regular and normalized values
maxCount = max(max(rgbBins)); % get highest bin value for y-axis in plot

normBins = rgbBins./maxCount;

figure(1)
subplot(2,2,1:2);
semilogy(thisBin,rgbBins(1,:),'r-',thisBin,rgbBins(2,:),'g-',thisBin,rgbBins(3,:),'b-')
xlim([0 Nbins])
ylim([0 maxCount])
xlabel('Pixel Intensity')
ylabel('Number of Pixels')
title('RGB HISTOGRAM')
hold on
subplot(2,2,3:4); % change to semilogy for better view 
slh = plot(thisBin,normBins(1,:),'r-',thisBin,normBins(2,:),'g-',thisBin,normBins(3,:),'b-')
set(slh,'LineWidth',1.5);
xlim([0 Nbins])
ylim([0 1])
xlabel('Pixel Intensity')
ylabel('Percent of Total # of Pixels')
grid on


figure,imshow(orig_im)
impixelinfo


end
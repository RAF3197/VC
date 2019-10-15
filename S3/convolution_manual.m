% Demo to do a convolution filter of an image completely manually with 4 nested for loops.
% This is because sometimes professors want students to do it this way
% instead of using built-in functions like conv2() and imfilter().

% Set up / initialization
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 15;

%=================================================================================================
% Get the name of the demo image the user wants to use.
% Let's let the user select from a list of all the demo images that ship with the Image Processing Toolbox.
folder = fileparts(which('cameraman.tif')); % Determine where demo folder is (works with all versions).
% Demo images have extensions of TIF, PNG, and JPG.  Get a list of all of them.
imageFiles = [dir(fullfile(folder,'*.TIF')); dir(fullfile(folder,'*.PNG')); dir(fullfile(folder,'*.jpg'))];
for k = 1 : length(imageFiles)
	% 	fprintf('%d: %s\n', k, files(k).name);
	[~, baseFileName, extension] = fileparts(imageFiles(k).name);
	ca{k} = [baseFileName, extension];
end
% Sort the base file names alphabetically.
[ca, sortOrder] = sort(ca);
imageFiles = imageFiles(sortOrder);
button = menu('Use which gray scale demo image?', ca); % Display all image file names in a popup menu.
% Get the base filename.
baseFileName = imageFiles(button).name; % Assign the one on the button that they clicked on.
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);

%=================================================================================================
% Check if file exists.  It should but just to be robust check again,
% since sometimes people may hard-code in a file name and not use menu() like I did.
if ~exist(fullFileName, 'file')
	% The file doesn't exist -- didn't find it there in that folder.
	% Check the entire search path (other folders) for the file by stripping off the folder.
	fullFileNameOnSearchPath = baseFileName; % No path this time.
	if ~exist(fullFileNameOnSearchPath, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end

%=================================================================================================
% Read the image in and convert to gray scale if necessary.
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorBands should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage);
if numberOfColorChannels > 1
	% It's not really gray scale like we expected - it's color.
	% Use weighted sum of ALL channels to create a gray scale image.
	grayImage = rgb2gray(grayImage);
	% ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
	% which in a typical snapshot will be the least noisy channel.
	% grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the image.
subplot(1, 2, 1);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
drawnow;

%=================================================================================================
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')

%=================================================================================================
% Ask user for the window width.  It should be an odd number.
defaultValue = 15;
titleBar = 'Enter an odd integer value for the filter window width';
userPrompt = 'Enter Window Width';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
% Round to nearest integer in case they entered a floating point number.
integerValue = round(str2double(cell2mat(caUserInput)));
% Check for a valid integer.
if isnan(integerValue)
	% They didn't enter a number.
	% They clicked Cancel, or entered a character, symbols, or something else not allowed.
	integerValue = defaultValue;
	message = sprintf('I said it had to be an integer.\nTry replacing the user.\nI will use %d and continue.', integerValue);
	uiwait(warndlg(message));
end
windowSize = round(integerValue);
% Hopefully windowSize is an odd number, but it will work for even numbers too,
% there will just be a half pixel shift in the filtered image.

%=================================================================================================
% Set up a filter kernel, a 7 by 7 window that takes the average of everything in the window.
halfWindowSize = floor(windowSize / 2);
kernel = ones(windowSize) / windowSize ^ 2;
% If it's a convolution, flip the kernel
% (Won't make a difference for a symmetric or uniform kernel though.)
kernel = flipud(fliplr(kernel));

%=================================================================================================
% Scan the image pixel by pixel.  Go down rows first then columns because this will be the fastest direction.
startTime = tic; % Start timer.
filteredImage = zeros(size(grayImage)); % Initialize to same size as original.
% Do this instead if you want the edge effect to be the original image values instead of black.
% filteredImage = grayImage;
% Do this if you want the edge effect to be the original image values instead of black.

%=================================================================================================
% HERE IS THE MAIN COMPUTATION ENGINE OF THE WHOLE PROCESS:
% Now scan the window over the image pixel by pixel.
for col = halfWindowSize + 1 : columns - halfWindowSize
	for row = halfWindowSize + 1 : rows - halfWindowSize
		% Now for a window with the center pixel situated at (row, col,
		% scan the filter window, multiplying its values by the values of the original image underneath it.
		localSum = 0; % Initialize sum to zero for this (row, column) location.
		for c = 1 : windowSize
			% Get the column index of the original image underneath the corresponding pixel in the filter window
			ic = col + c - halfWindowSize - 1;
			for r = 1 : windowSize
				% Get the row index of the original image underneath the corresponding pixel in the filter window
				ir = row + r - halfWindowSize - 1;
				% Sum up the product into our running total for this window location.
				localSum = localSum + double(grayImage(ir, ic)) * kernel(r, c);
			end
		end
		% Now we have the filtered value.  Assign it to our output image.
		filteredImage(row, col) = localSum;
	end
end
elapsedTime = toc(startTime); % Stop timer.
fprintf('Done!  The %d-by-%d filter took %f seconds\n', windowSize, windowSize, elapsedTime);

%=================================================================================================
% Display the image.
subplot(1, 2, 2);
% If you want the filtered image to be the same class as the input image, e.g. uint8, then cast it.
% filteredImage = cast(filteredImage, 'like', grayImage);
imshow(filteredImage, []);
caption = sprintf('Image filtered with a uniform box filter of width %d', windowSize);
title(caption, 'FontSize', fontSize);
axis on;

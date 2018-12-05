fontSize = 20;

grayImage = imread(fullFileName);
grayImage = rgb2gray(grayImage);
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
[labeledImage, numberOfBlobs] = bwlabel(grayImage);
blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
% Get all the areas
allAreas = [blobMeasurements.Area] % No semicolon so it will print to the command window.
menuOptions{1} = '0'; % Add option to extract no blobs.
% Display areas on image
for k = 1 : numberOfBlobs           % Loop through all blobs.
	thisCentroid = [blobMeasurements(k).Centroid(1), blobMeasurements(k).Centroid(2)];
	message = sprintf('Area = %d', allAreas(k));
	text(thisCentroid(1), thisCentroid(2), message, 'Color', 'r');
	menuOptions{k+1} = sprintf('%d', k);
end

% Ask user how many blobs to extract.
numberToExtract = menu('How many do you want to extract', menuOptions) - 1;

% Ask user if they want the smallest or largest blobs.
promptMessage = sprintf('Do you want the %d largest, or %d smallest, blobs?',...
	numberToExtract, numberToExtract);
titleBarCaption = 'Largest or Smallest?';
sizeOption = questdlg(promptMessage, titleBarCaption, 'Largest', 'Smallest', 'Cancel', 'Largest');
if strcmpi(sizeOption, 'Cancel')
	return;
elseif strcmpi(sizeOption, 'Smallest')
	% If they want the smallest, make the number negative.
	numberToExtract = -numberToExtract;
end

%---------------------------------------------------------------------------
% Extract the largest area using our custom function ExtractNLargestBlobs().
% This is the meat of the demo!
biggestBlob = ExtractNLargestBlobs(grayImage, numberToExtract);
%---------------------------------------------------------------------------

% Display the image.
subplot(2, 2, 4);
imshow(biggestBlob, []);
% Make the number positive again.  We don't need it negative for smallest extraction anymore.
numberToExtract = abs(numberToExtract);
if numberToExtract == 1
	caption = sprintf('Extracted %s Blob', sizeOption);
elseif numberToExtract > 1
	caption = sprintf('Extracted %d %s Blobs', numberToExtract, sizeOption);
else % It's zero
	caption = sprintf('Extracted 0 Blobs.');
end
title(caption, 'FontSize', fontSize);
msgbox('Done with demo!');

% Function to return the specified number of largest or smallest blobs in a binary image.
% If numberToExtract > 0 it returns the numberToExtract largest blobs.
% If numberToExtract < 0 it returns the numberToExtract smallest blobs.
% Example: return a binary image with only the largest blob:
%   binaryImage = ExtractNLargestBlobs(binaryImage, 1)
% Example: return a binary image with the 3 smallest blobs:
%   binaryImage = ExtractNLargestBlobs(binaryImage, -3)

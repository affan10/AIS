img = imread('aerial.png');
img2 = rgb2gray(img);
binaryImage = img2;

%---------------------------------------------------------------------------
% Extract the largest area using our custom function ExtractNLargestBlobs().
% This is the meat of the demo!
biggestBlob = ExtractNLargestBlobs(binaryImage, numberToExtract);
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


I = imread('aerial.png');
I = rgb2gray(I);
figure, imshow(I);

E = entropyfilt(I);

Eim = mat2gray(E);
imshow(Eim);

BW1 = imbinarize(Eim, .8);

imshow(BW1);
I = imread('aerial.png');
%I = rgb2gray(I);
imshow(I);
[m, n]=size(I);
edg = zeros(m,n);
for i=2:m-1
    for j=2:n-1
        edg(i,j) =  I(i+1,j) + I(i-1,j) + I(i,j-1) + I(i,j+1) - 4*I(i,j) ;
    end
end
figure,imshow(edg);

se = strel('line', 10, 200);
edge = imdilate(edg, se);

figure,imshow(edge);

BW = roicolor(edge,50,255);
se2 = strel('line', 10, 180);
edge = imdilate(BW, se2);
figure,imshow(BW);
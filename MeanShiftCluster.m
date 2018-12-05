name = input('Enter Image name: ','s');

img = imread(name);
out_img = mean_shift(img,40,3,3);
%figure, imshow(output);

out_img = rgb2gray(out_img);
rotI = imrotate(out_img,0,'crop');

BW = edge(rotI,'canny');
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,6,'threshold',ceil(0.2*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',10);
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');


% out_img = im2bw(out_img);
% 
% connComp = bwlabel(out_img); %find the connected components
% imageStats = regionprops(connComp,'all'); 
% compNumber = size(imageStats);
% for i=1:compNumber - 1 % to compare sizes of connected components
%    box1 = imageStats(i).BoundingBox;
%    compareVar1 = box1(3)*box1(4);
%    box2 = imageStats(i+1).BoundingBox;
%    compareVar2 = box2(3)*box2(4);
%    if compareVar1 > compareVar2
%       largestPosition=i;
%    end
% end
% imshow(imageStats(largestPosition).Image) %this is the largest connected component

% u_rgbvals = unique(img);
% num_uvals = length(u_rgbvals);
% L = cell(num_uvals, 1);
% for K = 1 : num_uvals
%   thisval = u_rgbvals(K);
%   L{K} = {thisval, bwlabeln(img == thisval)};
% end
% 
% for K = 1 : num_uvals
%    thispair = L{K};
%    thisval = thispair{1};
%    labelmat = thispair{2};
%    fprintf('\nThe pixel value %g had the following label matrix:\n', thisval);
%    disp(labelmat);
%    subplot(1,num_uvals,K);
%    image(labelmat); axis image;
%    title(sprintf('pixel value %g', thisval));
% end
 
%out_img = rgb2gray(out_img);

% [m, n]=size(out_img);
% edg = zeros(m,n);
% for i=2:m-1
%     for j=2:n-1
%         edg(i,j) =  out_img(i+1,j) + out_img(i-1,j) + out_img(i,j-1) + out_img(i,j+1) - 4*out_img(i,j) ;
%     end
% end
% figure,imshow(edg);
% 
% se = strel('line', 10, 200);
% edge = imdilate(edg, se);
% 
% figure,imshow(edge);
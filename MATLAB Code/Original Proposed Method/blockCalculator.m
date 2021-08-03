RGB = im2double(imread('image5.jpg'));
RGB = imresize(RGB,[size(RGB,1)-4 size(RGB,2)-6]); % Test to see if it reduced the c by 1
HSV = rgb2hsv(RGB);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);
[r,c] = size(V,[1 2]);

rB = zeros([],1);
for i = 1:200
    rB(i,1)=r/i;
end

cB = zeros([],1);
for i = 1:200
    cB(i,1)=c/i;
end

blockValues = [rB cB];


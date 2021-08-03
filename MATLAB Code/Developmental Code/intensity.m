% This program is used to determine the average local intensity and
% standard deviation of of the entire image. As described in the primary
% source document of our research project. 

RGB = im2double(imread('image1.jpg'));
RGBgray = rgb2gray(RGB);
HSV = rgb2hsv(RGB);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

[r,c] = size(V,[1 2]);  % r represents rows and c represents columns 

Va = (1/numel(V)) * sum(V,'all');  % Average value of all elements in V
Vd = std2(V);  % Standard deviation of all elements in V

Ut = Va + Vd;  % Upper threshold parameter for intensity
Lt = Va - Vd;  % Lower threshold parameter for intensity

% Use blockproc() function to process the image in M x N blocks to
% regionally evaluate the image based upon three parameters derived from
% the upper and lower threshold.


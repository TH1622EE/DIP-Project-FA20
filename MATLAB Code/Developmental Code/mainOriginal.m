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

% Function handle to evaluate the image in blocks of 7 rows and 11 columns
% multiplied element wise by the ones matrix using the same dimensions such
% that the output matrix will be the same size as the input matrix. 
fun = @(block_struct) mean2(block_struct.data).*ones(7,11);

% blockV is the output matrix of the block analysis outputting the average of
% the block in every element of the block such maintaining the same
% dimensions as the input matrix
blockV = blockproc(V,[7 11],fun);

% If I is < Lt assign block the value to Ilow(0)
% If Lt < I < Ut assign block the value of Imed(1)
% If I > Ut assign block the value of Ihigh(2)

intensityMatrix = zeros(r,c);

for i = 1:7:r
    for j = 1:11:c
        if(blockV(i,j)<Lt)
            intensityMatrix(i:i+6,j:j+10)=0;
        elseif(Lt<blockV(i,j) && blockV(i,j)<Ut)
            intensityMatrix(i:i+6,j:j+10)=1;
        elseif(blockV(i,j)>Ut)
            intensityMatrix(i:i+6,j:j+10)=2;
        end
    end
end





% This program is used to determine the average local intensity and
% standard deviation of of the entire image. As described in the primary
% source document of our research project. 

RGB = im2double(imread('image1.jpg'));
RGBgray = rgb2gray(RGB);
HSV = rgb2hsv(RGB);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

[rV,cV] = size(V,[1 2]);   

Va = (1/numel(V)) * sum(V,'all');  % Average value of all elements in V
Vd = std2(V);  % Standard deviation of all elements in V

Ut = Va + Vd;  % Upper threshold parameter for intensity
Lt = Va - Vd;  % Lower threshold parameter for intensity

% Function handle to evaluate the image in blocks of 7 rows and 11 columns
% multiplied element wise by the ones matrix using the same dimensions such
% that the output matrix will be the same size as the input matrix. 
fun = @(block_struct) mean2(block_struct.data);

% blockV is the output matrix of the block analysis outputting the average of
% the block in every element of the block such maintaining the same
% dimensions as the input matrix
blockV = blockproc(V,[7 11],fun);
[rBV,cBV] = size(blockV,[1,2]);

% If I is < Lt assign block the value to Ilow(0)
% If Lt < I < Ut assign block the value of Imed(1)
% If I > Ut assign block the value of Ihigh(2)

intensityMatrix = zeros(rBV,cBV);

for i = 1:rBV
    for j = 1:cBV
        if(blockV(i,j)<Lt)
            intensityMatrix(i,j)=0;
        elseif(Lt<blockV(i,j) && blockV(i,j)<Ut)
            intensityMatrix(i,j)=1;
        elseif(blockV(i,j)>Ut)
            intensityMatrix(i,j)=2;
        end
    end
end

% Calculating the probability (p) of values in each of the 256 bins
p = imhist(V); % Histogram for RGB grayscale image
n = numel(V);  % The total number of elements
pNormal = p./n;  % Normalized histogram for RGB grayscale image
k = size(pNormal,1);  % Number of elements of of pNormal
N = (3689/7)*(5533/11);  % The total number of blocks

% Function handle for Entropy Block Classification
% funE = @(block_struct) entropy(block_struct.data).*ones(7,11);
funE = @(block_struct) entropy(block_struct.data);
% Matrix created using Entropy Function Handle
Elocal = blockproc(V,[7 11],funE);
Ea = sum(Elocal,'all')/N;
[rE,cE] = size(Elocal,[1 2]);

entropyMatrix = zeros(rE,cE);
for i = 1:rE
    for j = 1:cE
        if(Elocal(i,j)<Ea)
            entropyMatrix(i,j)=0;
        elseif(Elocal(i,j)>Ea)
            entropyMatrix(i,j)=1;
        end
    end
end



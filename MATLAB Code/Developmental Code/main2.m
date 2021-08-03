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
p = imhist(RGBgray); % Histogram for RGB grayscale image
n = numel(RGBgray);  % The total number of elements
pNormal = p./n;  % Normalized histogram for RGB grayscale image
k = size(pNormal,1);  % Number of elements of of pNormal
N = (3689/7)*(5533/11);  % The total number of blocks

% Function handle for Entropy Block Classification
% funE = @(block_struct) entropy(block_struct.data).*ones(7,11);
funE = @(block_struct) entropy(block_struct.data);
% Matrix created using Entropy Function Handle
Elocal = blockproc(RGBgray,[7 11],funE);
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

rgbGraySquared = RGBgray.^2;
% C1 = (1/numel(RGBgray))*(sum(rgbGraySquared,'all'));
% C2 = abs((1/numel(RGBgray))*(sum(RGBgray,'all'))).^2;

% Function handle to determine the mean of each block in rgbGraySquared
funC1 = @(block_struct) mean2(block_struct.data);
% Creation of matrix using funC1 function handle
Clocal1 = blockproc(rgbGraySquared,[7 11],funC1);
% Function handle to determine the absolute value of the mean of each block
% of RGBgray squared
funC2 = @(block_struct) abs(mean2(block_struct.data)).^2;
% Creation of matrix using funC2 function handle
Clocal2 = blockproc(RGBgray,[7 11],funC2);
% Creating of the final matrix using formula(9) from primary research
% document
Clocal = Clocal1-Clocal2;
% The average contrast value of the Clocal image
Ca = sum(Clocal,'all')/N;
% The diminsions of the Clocal matrix
[rC,cC] = size(Clocal,[1 2]);

% Creation of the contrastMatrix initialized at zeros and classified as 0
% if contrast was less than Ca and 1 if greater than Ca
contrastMatrix = zeros(rC,cC);
for i = 1:rC
    for j = 1:cC
        if(Clocal(i,j)<Ca)
            contrastMatrix(i,j)=0;
        elseif(Clocal(i,j)>Ca)
            contrastMatrix(i,j)=1;
        end
    end
end

% The number of Intensity values specific to their category
valuesIlow = sum(intensityMatrix(:,:)==0,'all');
valuesImed = sum(intensityMatrix(:,:)==1,'all');
valuesIhigh = sum(intensityMatrix(:,:)==2,'all');

% The percentage of Intensity values specific to their category
percentIlow = (valuesIlow/numel(intensityMatrix))*100;
percentIMed = (valuesImed/numel(intensityMatrix))*100;
percentIHigh = (valuesIhigh/numel(intensityMatrix))*100;

% The number of Entropy values specific to their category
valuesElow = sum(entropyMatrix(:,:)==0,'all');
valuesEhigh = sum(entropyMatrix(:,:)==1,'all');

% The percentage of Entropy Values Specific to their category
percentElow = (valuesElow/numel(entropyMatrix))*100;
percentEhigh = (valuesEhigh/numel(entropyMatrix))*100;

% The number of Contrast values specific to their category
valuesClow = sum(contrastMatrix(:,:)==0,'all');
valuesChigh = sum(contrastMatrix(:,:)==1,'all');

% The percentage of contrast values specific to their catergory
percentClow = (valuesClow/numel(contrastMatrix))*100;
percentChigh = (valuesChigh/numel(contrastMatrix))*100;

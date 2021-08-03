% Course:      EE 566 - Digital Image Processing
 % Professor:   Dr. Mohammed Shaban
 % Semester:    Fall 2020
 % Author(s):   Tim Holden & Mordecai Israel
 
 % This file was created for the purpose of regional classification of non-uniformly
 % illuminated images by evaluating the Intensity, Entropy, and Contrast
 % specific to the image evaluated in 7 x 11 blocks with the intent of
 % identifying regions which will individually be evaluated iteratively on
 % a case by case basis. The method used for classification of the images
 % with respect to the Intensity, Entropy, and Contrast were originally
 % created as listed in the primary source document ("Local Neighborhood Image 
 % Properties for Exposure Region Determination Method in Non-uniformly Illuminated Images") 
 % as a basis of this research. The intent of this program and the basis of this research 
 % is to utilize the aforementioned exposure determination method and evaluate the image specific
 % to the these regions to enhance the output image regionally (locally) rather than
 % applying spatial transform functions globally such that the output image displays a more
 % unformly illuminated and enhanced image overall. 

% Step 1 of proposed method

% The following block of code was created for the determination of
% intensity classification of an image leading to enhanced exposure regions
% classification as depicted in the primary research document.

tic
RGB = im2double(imread('image1.jpg')); % Read image to memory and convert to double
RGBgray = rgb2gray(RGB); % Convert RGB to grayscale image
HSV = rgb2hsv(RGB); % Convert RGB to HSV color space
H = HSV(:,:,1); % Hue channel of HSV color space
S = HSV(:,:,2); % Saturation channel of HSV color space
V = HSV(:,:,3); % Value (Intensity) channel of HSV color space
[r,c] = size(V,[1 2]); % Size of rows and columns of V channel matrix
Va = (1/numel(V)) * sum(V,'all');  % mean of all elements in V
Vd = std2(V);  % Standard deviation of all elements in V
Ut = Va + Vd;  % Upper threshold parameter for intensity
Lt = Va - Vd;  % Lower threshold parameter for intensity

% Function handle to evaluates the image in blocks of 7 rows and 11 columns
% which compresses the output matrix such that each cell represents the 77
% element (7,11) block. The expanded version of each matrix evaluates the
% original matrix in the same way but outputs a matrix the same size as the
% original image with each 77 element (7,11) block displaying the value as
% determined by the function handle specific to that image. 

% The below code block is for compressed block processed V matrix
%compFunV = @(block_struct) mean2(block_struct.data); % Function handle for mean of compressed blockV
%compBlockV = blockproc(V,[7 11],compFunV); % Block processed compressed V channel matrix
%[rBVcomp,cBVcomp] = size(compBlockV,[1,2]); % Size of compressed block processed V channel matrix

% The below code block is for full size block processed V matrix
funV = @(block_struct) mean2(block_struct.data).*ones(7,11); %Function handle expanded blockV
blockV = blockproc(V,[7 11],funV); % Expanded block processed V channel matrix

% compIntensityMatrix = zeros(rBVcomp,cBVcomp); % Compressed intensity matrix
intensityMatrix = zeros(r,c); % Intensity classification matrix


% If I is < Lt assign block the value to Ilow(0)
% If Lt < I < Ut assign block the value of Imed(1)
% If I > Ut assign block the value of Ihigh(2)

for i = 1:r
    for j = 1:c
        if(blockV(i,j)<Lt)
            intensityMatrix(i,j)=0;
        elseif(Lt<blockV(i,j) && blockV(i,j)<Ut)
            intensityMatrix(i,j)=1;
        elseif(blockV(i,j)>Ut)
            intensityMatrix(i,j)=2;
        end
    end
end

% Step 2 of proposed method

% The following block of code was created for the determination of entropy
% classification of an image leading to enhanced exposure regions
% classification as depicted in the primary research document.

p = imhist(RGBgray); % Histogram for RGB grayscale image
n = numel(RGBgray);  % The total number of elements within RGBgray matrix
pNormal = p./n;  % Normalized histogram of p
k = size(pNormal,1);  % Number of elements of of pNormal
N = (3689/7)*(5533/11);  % The total number of blocks created by blockproc() function

% The below code block is for the compressed block processed matrix
%compFunE = @(block_struct) entropy(block_struct.data); % Function handle for Entropy block classification
%compElocal = blockproc(RGBgray,[7 11],compFunE); % Compressed matrix created using entropy function handle
%compEa = sum(compElocal,'all')/N; % Mean Entropy of the entire image
%[rEcomp,cEcomp] = size(compElocal,[1 2]); % Size of block processed RGBgray matrix w.r.t Entropy calculations

% The below code block is for the full size block processed matrix
funE = @(block_struct) entropy(block_struct.data).*ones(7,11); % Function handle for expanded Entropy block classification
Elocal = blockproc(RGBgray,[7 11],funE); % Expanded matrix created using entropy function handle
Ea = sum(Elocal,'all')/n; % Mean Entropy of the entire image

entropyMatrix = zeros(r,c); % Initialized creation of zero matrix to store compressed block processed entropy matrix

for i = 1:r
    for j = 1:c
        if(Elocal(i,j)<Ea)
            entropyMatrix(i,j)=0;
        elseif(Elocal(i,j)>Ea)
            entropyMatrix(i,j)=1;
        end
    end
end

% Step 3 of proposed Method

% The following block of code was created for determination of contrast
% classification leading to enhanced exposure region classification
% depicted in the primary research document

rgbGraySquared = RGBgray.^2; % The element wise squaring of each value of RGBgray
% C1 = (1/numel(RGBgray))*(sum(rgbGraySquared,'all'));
% C2 = abs((1/numel(RGBgray))*(sum(RGBgray,'all'))).^2;

% The code block below is for the compressed block processed matrix
%compfunC1 = @(block_struct) mean2(block_struct.data); % Function handle to determine the mean of each block in rgbGraySquared
%compClocal1 = blockproc(rgbGraySquared,[7 11],compfunC1); % Creation of matrix using funC1 function handle
%compfunC2 = @(block_struct) abs(mean2(block_struct.data)).^2; % Function handle to determine absolute value of the mean value of each block of RGBgray squared
%compClocal2 = blockproc(RGBgray,[7 11],compfunC2); % Creation of matrix using funC2 function handle
%compClocal = compClocal1-compClocal2; % Creation of combined block processed matrices using formula(9) from primary research document
%compCa = sum(compClocal,'all')/N; % The mean contrast value of compressed Clocal
%[rCcomp,cCcomp] = size(compClocal,[1 2]); % The size of compressed block processed Clocal matrix w.r.t Contrast calculations

% The code block below is for the full size block processed matrix
funC1 = @(block_struct) mean2(block_struct.data).*ones(7,11); % Function handle to determine the mean of each block in rgbGraySquared
Clocal1 = blockproc(rgbGraySquared,[7 11],funC1); % Creation of matrix using funC1 function handle
funC2 = @(block_struct) abs(mean2(block_struct.data).*ones(7,11)).^2; % Function handle to determine absolute value of the mean value of each block of RGBgray squared
Clocal2 = blockproc(RGBgray,[7 11],funC2); % Creation of matrix using funC2 function handle
Clocal = Clocal1-Clocal2; % Creation of combined block processed matrices using formula(9) from primary research document
Ca = sum(Clocal,'all')/n; % The mean contrast value of Clocal

contrastMatrix = zeros(r,c); % Initialized zero matrix for storage of compressed block processed contrast matrix

for i = 1:r
    for j = 1:c
        if(Clocal(i,j)<Ca)
            contrastMatrix(i,j)=0;
        elseif(Clocal(i,j)>Ca)
            contrastMatrix(i,j)=1;
        end
    end
end

% Step 4 of proposed method

% The following block of code is created to determine exposure region based 
% upon the contrast and entropy levels. If both Contrast and Entropy are not
% classified as high (1) then the Intensity classification is used to
% determine exposure region on a case-by-case basis as per equation (12) 
% from the primary source document as listed in comments immediately below.

% Under Exposed Region = 0
% Well Exposed Region = 1
% Over Exposed Region = 2

exposureMatrix = zeros(r,c); % Initialized matrix to store exposure region classification

for i = 1:r
    for j = 1:c
        if(entropyMatrix(i,j)==1 && contrastMatrix(i,j)==1)
            exposureMatrix(i,j)=1;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==0)
            exposureMatrix(i,j)=0;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==1)
            exposureMatrix(i,j)=1;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==2)
            exposureMatrix(i,j)=2;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==1 && intensityMatrix(i,j)==0)
            exposureMatrix(i,j)=0;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==1 && intensityMatrix(i,j)==1)
            exposureMatrix(i,j)=1;
        elseif(entropyMatrix(i,j)==0 && contrastMatrix(i,j)==1 && intensityMatrix(i,j)==2)
            exposureMatrix(i,j)=2;
        elseif(entropyMatrix(i,j)==1 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==0)
            exposureMatrix(i,j)=0;
        elseif(entropyMatrix(i,j)==1 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==1)
            exposureMatrix(i,j)=1;
        elseif(entropyMatrix(i,j)==1 && contrastMatrix(i,j)==0 && intensityMatrix(i,j)==2)
            exposureMatrix(i,j)=2;
        end
    end
end
toc


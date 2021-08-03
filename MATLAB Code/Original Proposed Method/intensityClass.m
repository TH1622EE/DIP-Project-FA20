% Step 1 of proposed method

% The following block of code was created for the determination of
% intensity classification of an image leading to enhanced exposure regions
% classification as depicted in the primary research document.

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
compFunV = @(block_struct) mean2(block_struct.data); % Function handle for mean of compressed blockV
compBlockV = blockproc(V,[7 11],compFunV); % Block processed compressed V channel matrix
[rBVcomp,cBVcomp] = size(compBlockV,[1,2]); % Size of compressed block processed V channel matrix

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

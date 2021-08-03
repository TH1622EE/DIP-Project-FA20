 % Course:      EE 566 - Digital Image Processing
 % Professor:   Dr. Mohammed Shaban
 % Semester:    Fall 2020
 % Author(s):   Tim Holden & Mordecai Israel
 
 % This file was created for the purpose of regional classification of non-uniformly
 % illuminated images by by evaluating the Intensity, Entropy, and Contrast
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
 % unformly illuminated enhanced image overall. 

RGB = im2double(imread('image1.jpg'));
RGBgray = rgb2gray(RGB);
HSV = rgb2hsv(RGB);
H = HSV(:,:,1);
S = HSV(:,:,2);
V = HSV(:,:,3);

[rV,cV] = size(V,[1 2]); % Size of rows and columns of V channel matrix

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
blockV = blockproc(V,[7 11],fun); % Block processed V channel matrix
[rBV,cBV] = size(blockV,[1,2]); % Size of block processed V channel matrix

% Expanded versions of V channel
expandedfun = @(block_struct) mean2(block_struct.data).*ones(7,11);
expandedblockV = blockproc(V,[7 11],expandedfun);

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

p = imhist(RGBgray); % Histogram for RGB grayscale image
n = numel(RGBgray);  % The total number of elements within RGBgray matrix
pNormal = p./n;  % Normalized histogram of p
k = size(pNormal,1);  % Number of elements of of pNormal
N = (3689/7)*(5533/11);  % The total number of blocks created by blockproc() function

% funE = @(block_struct) entropy(block_struct.data).*ones(7,11);
funE = @(block_struct) entropy(block_struct.data); % Function handle for Entropy block classification
Elocal = blockproc(RGBgray,[7 11],funE); % Matrix created using entropy function handle
Ea = sum(Elocal,'all')/N; % Mean Entropy of the entire image
[rE,cE] = size(Elocal,[1 2]); % Size of block processed RGBgray matrix w.r.t Entropy calculations

expandedfunE = @(block_struct) entropy(block_struct.data).*ones(7,11); % Function handle for Entropy block classification
expandedElocal = blockproc(RGBgray,[7 11],expandedfunE); % Matrix created using entropy function handle

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

funC1 = @(block_struct) mean2(block_struct.data); % Function handle to determine the mean of each block in rgbGraySquared
Clocal1 = blockproc(rgbGraySquared,[7 11],funC1); % Creation of matrix using funC1 function handle
funC2 = @(block_struct) abs(mean2(block_struct.data)).^2; % Function handle to determine absolute value of the mean value of each block of RGBgray squared
Clocal2 = blockproc(RGBgray,[7 11],funC2); % Creation of matrix using funC2 function handle
Clocal = Clocal1-Clocal2; % Creation of combined block processed matrices using formula(9) from primary research document
Ca = sum(Clocal,'all')/N; % The mean contrast value of Clocal
% The diminsions of the Clocal matrix
[rC,cC] = size(Clocal,[1 2]); % The size of block processed Clocal matrix w.r.t Contrast calculations

expandedfunC1 = @(block_struct) mean2(block_struct.data).*ones(7,11); % Function handle to determine the mean of each block in rgbGraySquared
expandedClocal1 = blockproc(rgbGraySquared,[7 11],expandedfunC1); % Creation of matrix using funC1 function handle
expandedfunC2 = @(block_struct) abs(mean2(block_struct.data).*ones(7,11)).^2; % Function handle to determine absolute value of the mean value of each block of RGBgray squared
expandedClocal2 = blockproc(RGBgray,[7 11],expandedfunC2); % Creation of matrix using funC2 function handle
expandedClocal = expandedClocal1-expandedClocal2; % Creation of combined block processed matrices using formula(9) from primary research document

contrastMatrix = zeros(rC,cC); % Initialized matrix for output of below if-statement conditions
for i = 1:rC
    for j = 1:cC
        if(Clocal(i,j)<Ca)
            contrastMatrix(i,j)=0;
        elseif(Clocal(i,j)>Ca)
            contrastMatrix(i,j)=1;
        end
    end
end

% This block of code is created to determine exposure region based upon the
% contrast and entropy levels. If both Contrast and Entropy are not
% classified as high (1) then the Intensity classification is used to
% determine exposure region classification as per equation (12) from the
% primary source document.

% Under Exposed Region = 0
% Well Exposed Region = 1
% Over Exposed Region = 2
exposureMatrix = zeros(527,503); % Initialized matrix to store exposure region classification
[r,c] = size(exposureMatrix,[1 2]);

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

% The number of Intensity values specific to their category
valuesIlow = sum(intensityMatrix(:,:)==0,'all');
valuesImed = sum(intensityMatrix(:,:)==1,'all');
valuesIhigh = sum(intensityMatrix(:,:)==2,'all');
% The number of Entropy values specific to their category
valuesElow = sum(entropyMatrix(:,:)==0,'all');
valuesEhigh = sum(entropyMatrix(:,:)==1,'all');
% The number of Contrast values specific to their category
valuesClow = sum(contrastMatrix(:,:)==0,'all');
valuesChigh = sum(contrastMatrix(:,:)==1,'all');
% The number of under, well, and over exposed regions
numUnderExp = sum(exposureMatrix(:,:)==0,'all');
numWellExp = sum(exposureMatrix(:,:)==1,'all');
numOverExp = sum(exposureMatrix(:,:)==2,'all');

% The percentage of Intensity values specific to their category
percentIlow = (valuesIlow/numel(intensityMatrix))*100;
perIlow = sprintf('%.2f',percentIlow); 
disp(['The image is ',perIlow,' percent low intensity.'])
percentImed = (valuesImed/numel(intensityMatrix))*100;
perImed = sprintf('%.2f',percentImed); 
disp(['The image is ',perImed,' percent med intensity.'])
percentIhigh = (valuesIhigh/numel(intensityMatrix))*100;
perIhigh = sprintf('%.2f',percentIhigh); 
disp(['The image is ',perIhigh,' percent high intensity.'])
% The percentage of Entropy Values Specific to their category
percentElow = (valuesElow/numel(entropyMatrix))*100;
perElow = sprintf('%.2f',percentElow);
disp(['The image is ',perElow,' percent low entropy.'])
percentEhigh = (valuesEhigh/numel(entropyMatrix))*100;
perEhigh = sprintf('%.2f',percentEhigh);
disp(['The image is ',perEhigh,' percent high entropy.']);
% The percentage of contrast values specific to their catergory
percentClow = (valuesClow/numel(contrastMatrix))*100;
perClow = sprintf('%.2f',percentClow);
disp(['The image is ',perClow,' percent low contrast.']);
percentChigh = (valuesChigh/numel(contrastMatrix))*100;
perChigh = sprintf('%.2f',percentChigh);
disp(['The image is ',perChigh,' percent high contrast.'])
% The percent of under,, well, and over exposed regions
percentUnder = (numUnderExp/numel(exposureMatrix))*100;
perUnder = sprintf('%.2f',percentUnder); % String
disp(['The image is ',perUnder,' percent under exposed.'])
percentWell = (numWellExp/numel(exposureMatrix))*100;
perWell = sprintf('%.2f',percentWell); % String
disp(['The image is ',perWell,' percent well exposed.'])
percentOver = (numOverExp/numel(exposureMatrix))*100; 
perOver = sprintf('%.2f',percentOver); % String
disp(['The image is ',perOver,' percent over exposed.'])



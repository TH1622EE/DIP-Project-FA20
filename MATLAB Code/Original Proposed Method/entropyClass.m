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
compFunE = @(block_struct) entropy(block_struct.data); % Function handle for Entropy block classification
compElocal = blockproc(RGBgray,[7 11],compFunE); % Compressed matrix created using entropy function handle
compEa = sum(compElocal,'all')/N; % Mean Entropy of the entire image
[rEcomp,cEcomp] = size(compElocal,[1 2]); % Size of block processed RGBgray matrix w.r.t Entropy calculations

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
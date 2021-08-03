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

% The number of under, well, and over exposed regions
numUnderExp = sum(exposureMatrix(:,:)==0,'all');
numWellExp = sum(exposureMatrix(:,:)==1,'all');
numOverExp = sum(exposureMatrix(:,:)==2,'all');

% The percent of under, well, and over exposed regions
percentUnder = (numUnderExp/numel(exposureMatrix))*100;
perUnder = num2str(round(percentUnder,2)); % String
disp(['The image is ',perUnder,' percent under exposed.'])
percentWell = (numWellExp/numel(exposureMatrix))*100;
perWell = num2str(round(percentWell,2)); % String
disp(['The image is ',perWell,' percent under exposed.'])
percentOver = (numOverExp/numel(exposureMatrix))*100; 
perOver = num2str(round(percentOver,2)); % String
disp(['The image is ',perOver,' percent over exposed.'])

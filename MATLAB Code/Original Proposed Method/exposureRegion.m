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

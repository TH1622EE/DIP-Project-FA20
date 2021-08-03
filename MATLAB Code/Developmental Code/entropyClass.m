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




    




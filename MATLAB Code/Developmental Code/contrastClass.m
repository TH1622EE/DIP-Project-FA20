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


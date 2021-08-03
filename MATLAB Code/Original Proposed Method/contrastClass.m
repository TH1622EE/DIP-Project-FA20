% Step 3 of proposed Method

% The following block of code was created for determination of contrast
% classification leading to enhanced exposure region classification
% depicted in the primary research document

rgbGraySquared = RGBgray.^2; % The element wise squaring of each value of RGBgray
% C1 = (1/numel(RGBgray))*(sum(rgbGraySquared,'all'));
% C2 = abs((1/numel(RGBgray))*(sum(RGBgray,'all'))).^2;

% The code block below is for the compressed block processed matrix
compfunC1 = @(block_struct) mean2(block_struct.data); % Function handle to determine the mean of each block in rgbGraySquared
compClocal1 = blockproc(rgbGraySquared,[7 11],compfunC1); % Creation of matrix using funC1 function handle
compfunC2 = @(block_struct) abs(mean2(block_struct.data)).^2; % Function handle to determine absolute value of the mean value of each block of RGBgray squared
compClocal2 = blockproc(RGBgray,[7 11],compfunC2); % Creation of matrix using funC2 function handle
compClocal = compClocal1-compClocal2; % Creation of combined block processed matrices using formula(9) from primary research document
compCa = sum(compClocal,'all')/N; % The mean contrast value of compressed Clocal
[rCcomp,cCcomp] = size(compClocal,[1 2]); % The size of compressed block processed Clocal matrix w.r.t Contrast calculations

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
% Block Process output image from proposed method

% This program was created to output the values of Veq into Vnew based upon
% their exposure region criteria as listed in the loop. If the values of
% the block in the exposureMatrix(i,j) are equal to zero, the block is processed
% using the funBright handle, and if the exposureMatrix(i,j) are equal to
% two, the block is processed using the funDark handle, and if the values
% of the block in the exposure Matrix(i,j) are equal to one the values are
% simply input into Vnew without change.  

funDark = @(block_struct) darkenImage(block_struct.data).*ones(7,11); 
Vdark = blockproc(V,[7 11],funDark);

%funBright = @(block_struct) brightenImage(block_struct.data).*ones(7,11); 
%Vbrighten = blockproc(V,[7 11],funBright);

Vnew = zeros(r,c);

for i = 1:r
    for j = 1:c
        if(exposureMatrix(i,j)==0)
            Vnew(i,j) = V(i,j);
        elseif(exposureMatrix(i,j)==1)
            Vnew(i,j) = V(i,j);
        elseif(exposureMatrix(i,j)==2)
            Vnew(i,j) = Vdark(i,j);
        end
    end
end


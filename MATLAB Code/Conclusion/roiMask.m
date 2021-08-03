% Region of Interest Filter 'roifilt2' 
% BW is a mask created by if statement embedded in for loop
% h is a filter

tic
BW = zeros(r,c);
for i = 1:r
    for j= 1:c
        if(exposureMatrix(i,j)==0)
            BW(i,j)=0;
        elseif(exposureMatrix(i,j)==1)
            BW(i,j)=0;
        elseif(exposureMatrix(i,j)==2)
            BW(i,j)=1;
        end
    end
end

h = brighten(-0.7);
enhancedV = roifilt2(h,Veq,BW);
toc

imshow([V enhancedV])


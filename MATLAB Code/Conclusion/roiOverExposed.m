% This block of code was created utilizing the roifilt2 function using
% handle to evaluate the V channel matrix components that correlate to the 
% index values of the exposureMatrix equal to over-exposed such that the 
% function handle utilized will apply only to those values 

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

funDark = @darkenImage; % Function handle for image darkening
enhancedV_over = roifilt2(V,BW,funDark);
HSVenhancedV_over = cat(3,H,S,enhancedV_over);
RGBenhancedV_over = hsv2rgb(HSVenhancedV_over);
stdenhancedV_over = std2(enhancedV_over);  % Standard deviation of the enhancedV channel

enhancedVeq_over = roifilt2(Veq,BW,funDark);
HSVenhancedVeq_over = cat(3,H,S,enhancedVeq_over);
RGBenhancedVeq_over = hsv2rgb(HSVenhancedVeq_over);
stdenhancedVeq_over = std2(enhancedVeq_over);  % Standard deviation of the enhancedV channel
toc

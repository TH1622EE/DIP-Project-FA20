% This block of code was created utilizing the roifilt2 function using
% handle to evaluate the V channel matrix components that correlate to the 
% index values of the exposureMatrix equal to well-exposed values such that
% the function handle utilized will apply only to those values 

tic
BW = zeros(r,c);
for i = 1:r
    for j= 1:c
        if(exposureMatrix(i,j)==0)
            BW(i,j)=1;
        elseif(exposureMatrix(i,j)==1)
            BW(i,j)=0;
        elseif(exposureMatrix(i,j)==2)
            BW(i,j)=0;
        end
    end
end

funBright = @brightenImage; % Function handle for brightenImage user defined function
enhancedV_under = roifilt2(V,BW,funBright); % ROI filter applied to V channel
HSVenhancedV_under = cat(3,H,S,enhancedV_under);
RGBenhancedV_under = hsv2rgb(HSVenhancedV_under);
stdenhancedV_under = std2(enhancedV_under);  % Standard deviation of the enhancedV channel

enhancedVeq_under = roifilt2(Veq,BW,funBright); % ROI filter applied to Veq channel
HSVenhancedVeq_under = cat(3,H,S,enhancedVeq_under);
RGBenhancedVeq_under = hsv2rgb(HSVenhancedVeq_under);
stdenhancedVeq_under = std2(enhancedVeq_under);  % Standard deviation of the enhancedV channel
toc

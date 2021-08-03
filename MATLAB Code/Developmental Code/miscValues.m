% General Evaluation Formulas Relative to main.m File

% The number of Intensity values specific to their category
valuesIlow = sum(intensityMatrix(:,:)==0,'all');
valuesImed = sum(intensityMatrix(:,:)==1,'all');
valuesIhigh = sum(intensityMatrix(:,:)==2,'all');
% The number of Entropy values specific to their category
valuesElow = sum(entropyMatrix(:,:)==0,'all');
valuesEhigh = sum(entropyMatrix(:,:)==1,'all');
% The number of Contrast values specific to their category
valuesClow = sum(contrastMatrix(:,:)==0,'all');
valuesChigh = sum(contrastMatrix(:,:)==1,'all');
% The number of under, well, and over exposed regions
numUnderEx = sum(exposureMatrix(:,:)==0,'all');
numWellExp = sum(exposureMatrix(:,:)==1,'all');
numOverExp = sum(exposureMatrix(:,:)==2,'all');


% The percentage of Intensity values specific to their category
percentIlow = (valuesIlow/numel(intensityMatrix))*100;
perIlow = sprintf('%.2f',percentIlow); 
disp(['The image is ',perIlow,' percent low intensity.'])
percentImed = (valuesImed/numel(intensityMatrix))*100;
perIMed = sprintf('%.2f',percentImed); 
disp(['The image is ',perImed,' percent med intensity.'])
percentIhigh = (valuesIhigh/numel(intensityMatrix))*100;
perIhigh = sprintf('%.2f',percentIhigh); 
disp(['The image is ',perIhigh,' percent high intensity.'])
% The percentage of Entropy Values Specific to their category
percentElow = (valuesElow/numel(entropyMatrix))*100;
perElow = sprintf('%.2f',percentElow);
disp(['The image is ',perElow,' percent low entropy.'])
percentEhigh = (valuesEhigh/numel(entropyMatrix))*100;
perEhigh = sprintf('%.2f',percentEhigh);
disp(['The image is ',perEhigh,' percent high entropy.']);
% The percentage of contrast values specific to their catergory
percentClow = (valuesClow/numel(contrastMatrix))*100;
perClow = sprintf('%.2f',percentClow);
disp(['The image is ',perClow,' percent low contrast.']);
percentChigh = (valuesChigh/numel(contrastMatrix))*100;
perChigh = sprintf('%.2f',percentChigh);
disp(['The image is ',perChigh,' percent high contrast.'])
% The percent of under,, well, and over exposed regions
percentUnder = (numUnderExp/numel(exposureMatrix))*100;
perUnder = sprintf('%.2f',percentUnder); % String
disp(['The image is ',perUnder,' percent under exposed.'])
percentWell = (numWellExp/numel(exposureMatrix))*100;
perWell = sprintf('%.2f',percentWell); % String
disp(['The image is ',perWell,' percent well exposed.'])
percentOver = (numOverExp/numel(exposureMatrix))*100; 
perOver = sprintf('%.2f',percentOver); % String
disp(['The image is ',perOver,' percent over exposed.'])



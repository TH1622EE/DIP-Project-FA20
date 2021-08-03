% The following block of code was created to display image characteristics
% relevant to the regional exposure classification and overall image
% enhancements

tic
medVeq = medfilt2(Veq,[3 3]);
HSVeq = cat(3,H,S,Veq);  % HSVeq formed from Histogram equalized V channel
RGBeq = hsv2rgb(HSVeq);  % RGBeq formed from Histogram equalized V channel
 
medV = medfilt2(V,[3 3]);
HSVmedV = cat(3,H,S,medV);
RGBmedV = hsv2rgb(HSVmedV);

HSVmedVeq = cat(3,H,S,medVeq); % Concatenating the medVnew channel with the original H and S channels
RGBmedVeq = hsv2rgb(HSVmedVeq); % Converting the HSVnew image to an RGB image

avgFilter = fspecial('average',[3 3]);
avgVeq = imfilter(Veq,avgFilter,'replicate');
HSVavgVeq = cat(3,H,S,avgVeq);
RGBavgVeq = hsv2rgb(HSVavgVeq);

avgEnhancedVeq_over = imfilter(enhancedVeq_over,avgFilter,'replicate');
HSVavgEnhancedVeq_over = cat(3,H,S,avgEnhancedVeq_over);
RGBavgEnhancedVeq_over = hsv2rgb(HSVavgEnhancedVeq_over);

%stdV = std2(V);  % Standard deviation of the V channel
%stdVeq = std2(Veq);  % Standard deviation of the Veq channel
%stdRGB = std2(RGB);
%stdRGBeq = std2(RGBeq);
%stdRGBenhancedV_under = std2(RGBenhancedV_under);
%stdRGBenhancedVeq_under = std2(RGBenhancedVeq_under);
%stdRGBenhancedV_over = std2(RGBenhancedV_over);
%stdRGBenhancedVeq_over = std2(RGBenhancedVeq_over);
%stdRGBenhancedV_overall = std2(RGBenhancedV_overall);
%stdRGBenhancedVeq_overall = std2(RGBenhancedVeq_overall);

figure(1),imshow([RGB RGBenhancedV_under]),title('Original RGB vs RGBeq')
figure(2),imshow([RGB RGBenhancedVeq_under]),title('Original RGB vs RGBenhancedVeq_under')
figure(3),imshow([RGB RGBenhancedV_over]),title('Original RGB vs RGBenhancedV_over')
figure(4),imshow([RGB RGBenhancedVeq_over]),title('Original RGB vs RGBenhancedVeq_over')
%figure(5),imshow([RGB RGBenhancedV_overall]),title('Original RGB vs RGB Enhanced V Overall')
%figure(6),imshow([RGB RGBenhancedVeq_overall]),title('Original RGB vs RGB Enhanced Veq Overall')
figure(7),imshow([RGB RGBmedV]),title('Original RGB vs RGBmedV')
toc

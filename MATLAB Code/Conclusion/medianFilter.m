% Application of the median filter to an image

tic
medVeq = medfilt2(Veq,[3 3]); % Applying median filter to sharpened laplacian kernel derived from Veq channel
HSVeqMed = cat(3,H,S,medVeq); % Concatenating the medVnew channel with the original H and S channels
RGBEqMed = hsv2rgb(HSVeqMed); % Converting the HSVnew image to an RGB image

medV2 = medfilt2(V,[3 3]); % Applying median filter to sharpened laplacian kernel derived from V channel
HSV2 = cat(3,H,S,medV2); % Concatenating the medV2 channel with the original H and S channels
RGB2 = hsv2rgb(HSV2); % Converting the HSVnew image to an RGB image
toc

figure,imshow([V Veq medVeq medV2]),title('Original V, Vnew, Median Filtered Vnew')
figure,imshow([RGB RGBEqMed]),title('Original RGB Image vs RGBnew Image')
figure,imshow([RGB RGB2]),title('Original RGB Image vs RGB2 Image having Median Filter Applied')


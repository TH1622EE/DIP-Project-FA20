% Code to attempt to darken regions within a specific value

newV = zeros(r,c);

for i = 1:r
    for j = 1:c
        if(V(i,j)>=0.95 && exposureMatrix(i,j)==2)
            newV(i,j) = darkenImage(V(i,j));
        elseif(V(i,j)<0.95)
            newV(i,j) = V(i,j);
        end
    end
end
avgFilt = fspecial('average',[7 7]);
newVavg = imfilter(newV,avgFilt);
newVmed = medfilt2(newV,[7 7]);
darkenV = brighten(V,-0.6);
darkenV1 = brighten(newVavg,-0.6);
%darkenV3 = brighten(newVmed,-0.4);

BW = zeros(r,c);
BW(1:300,1:500)=1;

h = brighten(-0.5);
darkenV2 = roifilt2(h,V,BW);
%darkenV4 = roifilt2(h,darkenV3,BW);

HSVdarkenV = cat(3,H,S,darkenV);
HSVdarkenV1 = cat(3,H,S,darkenV1);
HSVdarkenV2 = cat(3,H,S,darkenV2);
%HSVdarkenV3 = cat(3,H,S,darkenV3);
%HSVdarkenV4 = cat(3,H,S,darkenV4);

RGBdarkenV = hsv2rgb(HSVdarkenV);
RGBdarkenV1 = hsv2rgb(HSVdarkenV1);
RGBdarkenV2 = hsv2rgb(HSVdarkenV2);
%RGBdarkenV3 = hsv2rgb(HSVdarkenV3);
%RGBdarkenV4 = hsv2rgb(HSVdarkenV4);

%figure(1),imshow(V),title('Original V Channel Image')
%figure(3),imshow(darkenV1),title('V with Average & Darkening Filter')
%figure(4),imshow(darkenV2),title('V with Average & Darkening ROI Filter')
%figure(4),imshow(darkenV3),title('V with Median & Darkening Filter')
%figure(5),imshow(darkenV4),title('V with Median & ROI Filter')
%figure(2),imshow(darkenV),title('Original V with only Darkening Filter')
%figure(7),imshow(RGBdarkenV1),title('RGB Reconstruction Average & Darkening Filter')
%figure(8),imshow(RGBdarkenV2),title('RGB Reconstruction Average & ROI Filter')
%figure(9),imshow(RGBdarkenV3),title('RGB Reconstruction Median & Darkening Filter')
%figure(10),imshow(RGBdarkenV4),title('RGB Reconstruction Median & ROI Filter')
figure(6),imshow(RGBdarkenV),title('RGB Reconstruction using Simple Darkened V Filter')
figure(5),imshow(RGB),title('Original RGB Image')



%newHSV = cat(3,H,S,darkenedV);
%newHSV2 = cat(3,H,S,darkenedV);
%newRGB = hsv2rgb(newHSV);
%newRGB2 = hsv2rgb(newHSV2);
%figure(1),imshow([V newV newVavg])
%figure(2),imshow([RGB newRGB])
%figure(3),imshow([darkenV darkenV2])

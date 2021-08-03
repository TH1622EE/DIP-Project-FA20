

mask = zeros(r,c);
Veq = histeq(V);

for i = 1:1200
    for j = 1:800
        mask(i,j)=1;
    end
end

%BW1 = logical(maskWhole);
%h = brighten(-0.5);
medianV = median(V(1:1416,1:1416),'all');
averageV = mean(V(1:1416,1:1416),'all');

funDark = @bright;
funDarken = @darkenImage;
newV = roifilt2(V,mask,funDarken);

newVmed = medfilt2(newV,[5 5]);
newHSV = cat(3,H,S,newVmed);
newRGB = hsv2rgb(newHSV);

figure(1),imshow([V newV newVmed])
%figure(2),imhist(V)
%figure(3),imhist(Veq,128)
%figure(4),imhist(newV)
figure(5),imshow([RGB newRGB])

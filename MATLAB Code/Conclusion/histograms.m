% Subplot Configuration of Image Histograms

figure(1),imhist(im2uint8(V)),title('Hist of V with St.Dev = 0.3074'),ylim('auto')
figure(2),imhist(im2uint8(Veq)),title('Hist of Veq with St.Dev = 0.2932'),ylim('auto')
figure(3),imhist(im2uint8(Vnew)),title('Hist of Exposure Reg Dep Vnew with St.Dev = 0.3074'),ylim('auto')
figure(4),imhist(im2uint8(VnewEq)),title('Hist of Exposure Reg Dep VnewEq with St.Dev = 0.2932'),ylim('auto')
%figure(5),imhist(Ray1),title('Histogram of Rayleigh Distribution Adaptive Hist Eq w/o Clippling of V');
%figure(6),imhist(Ray1new),('Histogram of Rayleigh Distribution Adaptive Hist Eq w/o Clippling of Vnew');
%figure(7),imhist(Ray2),title('Histogram of Rayleigh Distribution Adaptive Hist Eq with Clippling of V')
%figure(8),imhist(Ray2new),title('Histogram of Rayleigh Distribution Adaptive Hist Eq with Clippling of Vnew')


% Application of Laplacian Filter to Image

tic % Initiates program timer
lap = fspecial('laplacian');
lapFiltVnew = imfilter(Vnew,lap,'replicate');
lapVnew = Vnew - lapFiltVnew;
HSVlapVnew = cat(3,H,S,lapVnew);
RGBlapVnew = hsv2rgb(HSVlapVnew);

lapFiltV2 = imfilter(V,lap,'replicate');
lapV2 = V - lapFiltV2;
HSVlapV2 = cat(3,H,S,lapV2);
RGBlapV2 = hsv2rgb(HSVlapV2);
toc % Ends program timer


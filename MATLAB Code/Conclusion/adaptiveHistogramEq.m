% Hitogram Equalization

tic
ray1 = adapthisteq(V,'distribution','rayleigh');
ray1new = adapthisteq(Vnew,'distribution','rayleigh');
ray2 = adapthisteq(V,'ClipLimit',0.08,'distribution','rayleigh');
ray2new = adapthisteq(Vnew,'ClipLimit',0.08,'distribution','rayleigh');
exp1 = adapthisteq(V,'distribution','exponential');
exp1new = adapthisteq(Vnew,'distribution','exponential');
uni1 = adapthisteq(V,'distribution','uniform');
uni1new = adapthisteq(Vnew,'distribution','uniform');

stdRay1 = std2(ray1);
stdRay2 = std2(ray1new);
stdRay3 = std2(ray2);
stdRay4 = std2(ray2new);
stdexp1 = std2(exp1);
stdexp1new = std2(exp1new);
stduni1 = std2(uni1);
stduni1new = std2(uni1new);
toc




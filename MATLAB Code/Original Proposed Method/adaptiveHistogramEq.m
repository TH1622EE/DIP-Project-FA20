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
toc




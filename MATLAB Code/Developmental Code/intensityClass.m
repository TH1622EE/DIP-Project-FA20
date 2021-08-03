% If I is < Lt assign block the value to Ilow(0)
% If Lt < I < Ut assign block the value of Imed(1)
% If I > Ut assign block the value of Ihigh(2)

intensityMatrix = zeros(r,c);

for i = 1:r
    for j = 1:c
        if(blockV(i,j)<Lt)
            intensityMatrix(i:i+6,j:j+10)=0;
        elseif(Lt<blockV(i,j) && blockV(i,j)<Ut)
            intensityMatrix(i:i+6,j:j+10)=1;
        elseif(blockV(i,j)>Ut)
            intensityMatrix(i:i+6,j:j+10)=2;
        end
    end
end


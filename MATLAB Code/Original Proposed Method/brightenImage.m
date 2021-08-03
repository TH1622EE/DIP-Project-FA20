function [enhancedV] = brightenImage(V)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
enhancedV = imadjust(V,[0.05 0.3],[0.08 0.3],0.8);
end

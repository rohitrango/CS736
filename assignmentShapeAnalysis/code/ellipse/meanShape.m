function [meanPointSet] = meanShape(rotalign_pointSets)
%MEANSHAPE Summary of this function goes here
%   Detailed explanation goes here
    in_sz = size(rotalign_pointSets);
    meanPointSet = zeros(in_sz(1), in_sz(2));
    meanPointSet = meanPointSet + sum(rotalign_pointSets, 3);
    meanPointSet = meanPointSet/in_sz(3);
    meanPointSet = meanPointSet/norm(meanPointSet(:));
end


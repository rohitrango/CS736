function [tsalign_pointSets] = align_transcale(pointSets)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    in_sz = size(pointSets);
    tsalign_pointSets = zeros(in_sz);
    for i = 1:in_sz(3)
        pSet = pointSets(:,:,i);
        mean_p = mean(pSet, 2);
        %because matlab got smarter after 2016
        pSet = pSet - repmat(mean_p, [1,in_sz(2)]);
        tsalign_pointSets(:,:,i) = pSet/norm(pSet(:));
    end
end


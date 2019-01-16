function [rotalign_pointSets] = align_rot(tsalign_pointSets)
%ALIGN_ROT Summary of this function goes here
%   including the check det(R) to be >0 (i.e 1) or <0
    in_sz = size(tsalign_pointSets);
    rotalign_pointSets = zeros(in_sz);
    
    ref_pSet = tsalign_pointSets(:,:,1);
    rotalign_pointSets(:,:,1) = ref_pSet;
    for i=2:in_sz(3)
        pSet = tsalign_pointSets(:,:,i);
        A = pSet*ref_pSet';
        [U, ~ , V] = svd(A);
        R = V*U';
        if det(R) < 0
            I = eye(size(V,2));
            I(:,size(V,2)) = -1*I(:,size(V,2));
            R = V*I*U';
        end
        rotalign_pointSets(:,:,i) = R*pSet;
    end
end


function [align_pointSets] = align_rot(norml_pointSets)
%   first pointset is reference, align everyother wrt to first

    in_sz = size(norml_pointSets);
    align_pointSets = zeros(in_sz);
    ref_pSet = norml_pointSets(:,:,1);
    
    align_pointSets(:,:,1) = ref_pSet;
    for i=2:in_sz(3)
        pSet = norml_pointSets(:,:,i);
        A = pSet*ref_pSet';
        [U, ~ , V] = svd(A);
        R = V*U';
        if det(R) < 0
            I = eye(size(V,2));
            I(:,size(V,2)) = -1*I(:,size(V,2));
            R = V*I*U';
        end
        align_pointSets(:,:,i) = R*pSet;
    end
end


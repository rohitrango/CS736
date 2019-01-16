function [val] = RMSE(im1, im2)
    m1 = min(im1(:));
    M1 = max(im1(:));
    im1 = (im1-m1)/(M1-m1);
    
    m2 = min(im2(:));
    M2 = max(im2(:));
    im2 = (im2-m2)/(M2-m2);
    
    s1 = (im1-im2).^2;
    s2 = im2.^2;
    val = sqrt(sum(s1(:))/sum(s2(:)));
end
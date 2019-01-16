function [val] = RMSE(im, im2)
    % It introduces an extra pixel on all dimensions
    [m, n] = size(im);
    im1 = im(2:m-1, 2:n-1);
    s1 = (im1-im2).^2;
    s2 = im2.^2;
    val = sqrt(sum(s1(:))/sum(s2(:)));
end
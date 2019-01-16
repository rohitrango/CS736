function [val] = RRMSE(im, nIm) 
    n = abs(nIm);
    difference = (im-n);
    val = sumsqr(difference)/sumsqr(im);
    val = sqrt(val);
end
function [] = plot_images(im1, im2, s1, s2)
    figure;
    imagesc(im1);
    title(s1);
    daspect([1,1,1]);
    axis tight;
    
    figure;
    imagesc(im2);
    title(s2);
    daspect([1,1,1]);
    axis tight;
end
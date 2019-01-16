function [matrix] = myRadonTrans(image, del_s, del_t, del_theta)
    t = 90:-del_t:-90;
    theta = 0:del_theta:175;
    matrix = zeros(size(t, 2), size(theta, 2));

    for x=1:size(t, 2),
        for y=1:size(theta, 2),
            matrix(x, y) = myIntegration(image, t(x), theta(y), del_s);
        end
    end
end
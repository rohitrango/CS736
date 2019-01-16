function [val] = myIntegration(image, t, theta, del_s)
    % Note that theta is given in degrees, so convert it to radians first
    theta = theta*pi/180;
    [m, n] = size(image);
    cx = m/2;
    cy = n/2;
    % x = tcos(t') - s.sin(t')
    % y = tsin(t') + s.cos(t')
    if sin(theta) ~= 0.
        s_max = (t*cos(theta) - (1-cx))/sin(theta);
        s_min = (t*cos(theta) - (m-cx))/sin(theta);
    else
        % cosine transform can be negative, so watch out
        s_min = ((1-cy))/cos(theta);
        s_max = ((n-cy))/cos(theta);
        s = sort([s_min, s_max]);
        s_min = s(1);
        s_max = s(2);
    end
    s = s_min:del_s:s_max;
    % Get x and y in the range
    x = cx + t*cos(theta) - s*sin(theta);
    y = cy + t*sin(theta) + s*cos(theta);
    index = ((1<=x)&(x<=m))&((1<=y)&(y<=n));
    x = x(index);
    y = y(index);
    V = interp2(image, x, y);
    val = sum(V)*del_s;
end

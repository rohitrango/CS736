function [] = pSets_plotter(pointSets, ttl, tidx)
%   plot all pointsets
    in_sz = size(pointSets);
    for i = 1:in_sz(3)
        pSet = pointSets(:,:,i);
        %trimesh(tidx, pSet(1,:), pSet(2,:), pSet(3,:), round(255*rand(1,3)));
        trimesh(tidx, pSet(1,:), pSet(2,:), pSet(3,:), 'edgecolor', rand(1,3));
        hold on;
    end
    title(ttl);
    saveas(gcf, strcat('../../results/3dbone/', ttl, '.jpg'));
end
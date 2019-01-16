function [] = pSets_plotter(pointSets, ttl)
%   plot all pointsets
    in_sz = size(pointSets);
    for i = 1:in_sz(3)
        pSet = pointSets(:,:,i);
        scatter(pSet(1,:), pSet(2,:), [], rand(1,3), 'filled');
        hold on;
    end
    title(ttl);
    saveas(gcf, strcat('../../results/ellipse/', ttl, '.jpg'));
end


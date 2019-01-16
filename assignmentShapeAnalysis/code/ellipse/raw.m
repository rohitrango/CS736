%% Shape analysis for 2D pointsets
% The results of this script will be saved in ../../results/ecllipse/
% The mode of variation is only displayed along the first principal mode of
% variation

%% loading the data
A = load('../../data/ellipses2D.mat');
numOfPointSets = A.numOfPointSets;
numOfPointsPerSet = A.numOfPoints;
pointSets = A.pointSets;

norm_pointSets = align_transcale(pointSets);
rotalign_pointSets = align_rot(norm_pointSets);

%% Original pointsets (scatter plot with each pointset given a randomly picked color)
figure;
ttl = 'original pointsets';
pSets_plotter(pointSets, ttl);

%% Pointsets after re-centering to the origin and scaling to unit norm
figure;
ttl = 'translation and scale standardised';
pSets_plotter(norm_pointSets, ttl);

%% Pointsets after rotational allignment
figure;
ttl = 'rotationally aligned';
pSets_plotter(rotalign_pointSets, ttl);

%% Calculated mean shape 
mnShape = meanShape(rotalign_pointSets);
figure;
for i = 1:numOfPointSets
    pSet = rotalign_pointSets(:,:,i);
    scatter(pSet(1,:), pSet(2,:), [], [0,0,255]/255, 'filled');
    hold on;
end
scatter(mnShape(1,:), mnShape(2,:), [], [255,0,0]/255, '*');
ttl = 'mean in contrast with all the pointsets';
title(ttl);
saveas(gcf, strcat('../../results/ellipse/', ttl, '.jpg'));

%% Calculated principle mode of variations
A = rotalign_pointSets - repmat(mnShape, [1, 1, 300]);
B = zeros(numOfPointsPerSet*2, numOfPointSets);
for i=1:numOfPointSets
    t = A(:,:,i);
    B(:,i) = t(:);
end
covmat_A = cov(B');
[eig_vec, eig_vals] = eig(covmat_A);
principal_vec = eig_vec(:,64);
principal_vec = reshape(principal_vec, [2,32]);
mode_variation1 = mnShape+2*sqrt(eig_vals(64,64))*principal_vec;
mode_variation2 = mnShape-2*sqrt(eig_vals(64,64))*principal_vec;

figure;
for i = 1:numOfPointSets
    pSet = rotalign_pointSets(:,:,i);
    scatter(pSet(1,:), pSet(2,:), [], [0,0,255]/255, 'filled');
    hold on;
end
scatter(mnShape(1,:), mnShape(2,:), [], [255,0,0]/255, '*');
scatter(mode_variation1(1,:), mode_variation1(2,:), [], [255, 204, 0]/255, 'filled');
scatter(mode_variation2(1,:), mode_variation2(2,:), [], [0,255,0]/255, 'filled');
ttl = 'mean, pricipal mode of variation in contrast with all';
title(ttl);
saveas(gcf, strcat('../../results/ellipse/', ttl, '.jpg'));

figure;
e_vals = eig(covmat_A);
plot(e_vals);
xlabel('index for eigen value (sorted in increasing order of eigen values)');
ylabel('eigen values');
ttl = 'plot of eigen values (lowest to highest)';
title(ttl);
saveas(gcf, strcat('../../results/ellipse/', ttl, '.jpg'));
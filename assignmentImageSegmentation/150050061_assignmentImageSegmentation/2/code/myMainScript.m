
%% Init
close all; clc; clear;
load('../data/assignmentSegmentBrainGmmEmMrf.mat');

K = 3;
X = getStartingLabel(imageData, imageMask);
mu = zeros(1, K);
sigma = zeros(1, K);
beta = 0.33;
   
% init means and stddev
for label = 1:K,
    positions = X == label;
    mu(1, label) = mean(imageData(positions));
    sigma(1, label) = std(imageData(positions));
end;

%% Observations and justifications
%  Choice of beta: After a bit of tweaking, beta = 0.33 gives a smooth
%  enough segmented image.
%
%  Initial value of labels: The labels are given by dividing the image into
%  3 equal parts based on their intensities. The botton-third intensities
%  are given label = 1, the middle-third are given label=2, and the last
%  one-third are given label = 3.
%
%  Initial means and stddev: Given an initial estimate of the class labels,
%  the means and stddev are simply given by the mean and stddev of the
%  pixels of the class label respectively.
%

%% GMM EM MRF With beta = 0.33
% Gaussian Mixture Model, with Expectation Maximisation with potential beta
% equal to 0.33

[img, segmap, mu_hat] = getEMLabels(imageData, imageMask, K, X, mu, sigma, beta, 1);
showImage(imageData, 'Original Corrupted Image');
showImage(segmap(:, :, 1), 'Label 1 Class-Membership for beta = 0.33');
showImage(segmap(:, :, 2), 'Label 2 Class-Membership for beta = 0.33');
showImage(segmap(:, :, 3), 'Label 3 Class-Membership for beta = 0.33');
showImage(img, 'GMM-MRF-EM Optimised Image Segmentation for beta = 0.33');

%% Optimal values of class means
fprintf('Optimal values of class means for chosen beta\n');
disp(mu_hat);
fprintf('\n');

%% GMM EM MRF With beta = 0
% Gaussian Mixture Model, with Expectation Maximisation with no MRF

[img, segmap, mu_hat] = getEMLabels(imageData, imageMask, K, X, mu, sigma, 0, 1);
showImage(segmap(:, :, 1), 'Label 1 Class-Membership for beta = 0');
showImage(segmap(:, :, 2), 'Label 2 Class-Membership for beta = 0');
showImage(segmap(:, :, 3), 'Label 3 Class-Membership for beta = 0');
showImage(img, 'GMM-MRF-EM Optimised Image Segmentation for beta = 0');
close all;
clear; clc;

%% Main code starts here
load ../data/CT_Chest.mat
chest_img = imageAC;
load ../data/myPhantom.mat
phantom_img = imageAC;

%% load some variables here
theta = 0:150;
theta_range = 0:180; 

%% First the chest X-ray image
recon_rmse = zeros(size(theta_range));
for i=theta_range,
    theta1 = i + theta;
    r_tran = radon(chest_img, theta1);
    recon = iradon(r_tran, theta1);
    err = RMSE(recon, chest_img);
    recon_rmse(i+1) = err;
end
figure;
plot(recon_rmse);
[minVal, index] = min(recon_rmse);
thetai = index-1 + theta;
recon = iradon(radon(chest_img, thetai), thetai);

fprintf('Minimum RMSE for chest image is %f at theta = %d\n', minVal , index-1);

figure;
imagesc(recon);
colormap('gray');
daspect([1,1,1]);
axis tight;

%% For the Phantom image

recon_rmse_p = zeros(size(theta_range));
for i=theta_range,
    theta1 = i + theta;
    r_tran_p = radon(phantom_img, theta1);
    recon_p = iradon(r_tran_p, theta1);
    err = RMSE(recon_p, phantom_img);
    recon_rmse_p(i+1) = err;
end
figure;
plot(recon_rmse_p);
[minVal, index] = min(recon_rmse_p);
thetai = index-1 + theta;
recon_p = iradon(radon(phantom_img, thetai), thetai);

fprintf('Minimum RMSE for phantom image is %f at theta = %d\n', minVal , index-1);

figure;
imagesc(recon_p);
colormap('gray');
daspect([1,1,1]);
axis tight;
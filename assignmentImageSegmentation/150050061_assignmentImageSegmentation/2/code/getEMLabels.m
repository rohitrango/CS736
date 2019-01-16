function [X, gamma, mu_hat] = getEMLabels( Y, mask, K, X, mu, sigma, beta, flag )
   % Run the EM algorithm with ICM on the images to find means 'mu' and
   % stddev 'sigma' 
   % flag gives whether to show the variable or not
   [r, c] = size(Y);
   
   % Gamma_nk is the membership for each pixel
   gamma = zeros(r, c, K);
   iters = 30;
   memberships = zeros(1, K);
   
   for kk = 1:iters
       % Get X, mu, sigma by running the ICM algorithm
       [X, mu, sigma] = runICM( Y, mask, K, X, mu, sigma, beta, flag);
       
       % Run the E-step, which is basically updating the values of gamma_nk
       [memberships, gamma] = runEstep(mask, Y, X, beta, memberships, mu, sigma, K, gamma);
       
       % Run the M-step, which is basically update the values of mu and
       % sigma for all classes.
       [mu, sigma] = runMstep(K, gamma, Y, mu, sigma);
   end; 
   
   mu_hat = mu;

end


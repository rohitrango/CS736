function [ mu, sigma ] = runMstep( K, gamma, Y, mu, sigma )
% Run the M-step
   for label = 1:K
       D = sum(sum(gamma(:, :, label)));
       S = gamma(:, :, label) .* Y(:, :);
       S = sum(S(:));
       mu(1, label) = S / D;

       S = (Y(:, :) - mu(1,label)).^2;
       S = gamma(:, :, label) .* S;
       S = sum(S(:));
       sigma(1, label) = sqrt(S / D);
   end;
end


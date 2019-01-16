function [ memberships, gamma ] = runEstep(mask, Y, X, beta, memberships, mu, sigma, K, gamma)
   % Get size
   % run E-step given the previous gamma, Y, X, beta, and the memberships
   [r, c] = size(Y);

   % For all non-boundary pixels
   % update memberships
   for i = 2:r-1
       for j = 2:c-1
           
           % Skip for mask = 0
           if (mask(i, j) == 0)
               continue;
           end;

           memberships = zeros(1, K);
           for x = 1:K
               prior = getPrior(X, x, i, j, mask, beta);
               posterior = exp(- ( 1 - beta ) * (Y(i, j) - mu(1, x))^2 / (2 * sigma(1, x) * sigma(1, x)));
               memberships(1, x) = prior * posterior;
           end;

            memberships = memberships ./ sum(memberships(:));
            if (sum(isnan(memberships)) > 0)
                gamma(i,j,:) = gamma(i,j,:);
            else
                gamma(i,j,:) = memberships;
            end
       end;
   end;
end


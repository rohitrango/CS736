function [X, mu, sigma] = runICM( Y, mask, K, X, mu, sigma, beta, flag )
   [r, c] = size(Y);
   X_c = X;
   original_cummulative_value = 0;
   cummulative_value = 0;
   for count = 1:10
       for i = 2:r-1
           for j = 2:c-1
               if (mask(i, j) == 0)
                   continue;
               end;
                   
               x = X(i, j);
               original_prior = getPrior(X, x, i, j, mask, beta);
               original_posterior = exp(- ( 1 - beta ) * (Y(i, j) - mu(1, x))^2 / (2 * sigma(1, x) * sigma(1, x)));
               original_cummulative_value = original_cummulative_value + original_prior * original_posterior;
               
               values = zeros(1, K);
               for x = 1:K
                   prior = getPrior(X, x, i, j, mask, beta);
                   posterior = exp(- ( 1 - beta ) * (Y(i, j) - mu(1, x))^2 / (2 * sigma(1, x) * sigma(1, x)));
                   values(1, x) = posterior * prior;
               end;
               [value, index] = max(values);
               cummulative_value = cummulative_value  - log(value);
               X_c(i, j) = index;
           end;
       end;
       X = X_c .* mask;
   end;
   
   if flag == 1,
    display(sprintf('P(x | y, beta, theta) : (Before) %d => (After) %d', original_cummulative_value, cummulative_value));
   end;
   
   
end


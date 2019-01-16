function [ U ] = getMemberships(image, mask, classMeans, bias, q)
   % Given all parameters, find U
   % image = m*n
   % mask = p*q
   % classMeans = k*1
   % bias = m*n
   % q = scalar
   K = size(classMeans, 1);
   [m, n] = size(image);
   U = zeros(m, n, K);
   
   % Calculate for each k
   biasSquared = conv2(bias.^2, mask, 'same');
   biasAverage = conv2(bias, mask, 'same');
   for i=1:K,
       Dk = image.^2 + (classMeans(i)^2)*(biasSquared) - 2*classMeans(i)*(image.*biasAverage);
       Dk = Dk + (Dk==0)*mean(Dk(:));
       U(:,:,i) = ((Dk).^(1/(1-q)))/100;
   end
   
   % normalize U
   sumU = sum(U, 3);
   for i=1:K,
       U(:,:,i) = (U(:,:,i))./(sumU);
   end
   
    if any(isnan(U))
        fprintf('U means\n'); 
    end
   
end


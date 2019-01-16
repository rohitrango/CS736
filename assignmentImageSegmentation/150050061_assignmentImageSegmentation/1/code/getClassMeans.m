function [classMeans] = getClassMeans(K, U, image, mask, bias, q)
    % Given K, memberships, image, mask, bias.
    % Find classMeans
    % K = scalar
    % U = m*n*k
    % image = m*n
    % mask = p*q
    % bias = m*n 
    % q = scalar
    smoothBias = conv2(bias, mask, 'same');
    smoothBiasSq = conv2(bias.*bias, mask, 'same');
    classMeans = zeros(K, 1);
    
    % Find the class mean for each k
    for i=1:K,
        c1 = (U(:,:,i).^q).*image.*smoothBias;
        c2 = (U(:,:,i).^q).*smoothBiasSq;
        classMeans(i) = mean(c1(:))/mean(c2(:));
    end
    
    if any(isnan(classMeans))
       fprintf('Class means\n'); 
    end
    
end
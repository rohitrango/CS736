function [ bias ] = getBiasField(image, mask, U, classMeans, q)
    % Get optimal bias field given image, mask, Ujk, classMeans, q
    % image = m*n
    % mask = p*q
    % Ujk = m*n*k
    % classMeans = k*1
    % q = scalar
    K = size(classMeans, 1);
    avgClassMeans = U.^q;
    sqClassMeans = U.^q;
    for i=1:K,
        avgClassMeans(:, :, i) = avgClassMeans(:, :, i)*classMeans(i);
        sqClassMeans(:, :, i) = sqClassMeans(:, :, i)*classMeans(i)*classMeans(i);
    end
    avgClassMeans = sum(avgClassMeans, 3);
    sqClassMeans = sum(sqClassMeans, 3);
    
    % Solve for bias now
    avgYC = image.*avgClassMeans;
    avgYC = conv2(avgYC, mask, 'same');
    sqClassMeans = conv2(sqClassMeans, mask, 'same');
    
    bias = avgYC./sqClassMeans;
    
    if any(isnan(bias))
       fprintf('Bias means\n'); 
    end
    
end


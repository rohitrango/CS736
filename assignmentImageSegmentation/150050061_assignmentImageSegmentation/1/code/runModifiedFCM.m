function [U, classMeans, bias, loss] = runModifiedFCM( image, K, q, mask, U, classMeans, bias, iters )
    
    % write the loss function inside this
    function [loss] = findLossFunction(image, K, q, mask, U, classMeans, bias)
       % Find values of jth pixel first
       sqBiasTerm = conv2(bias.^2, mask, 'same');
       avBiasTerm = conv2(bias, mask, 'same');
       loss = 0;
       for j=1:K,
            im = (U(:,:,j).^q).*(image.^2 + classMeans(j)*sqBiasTerm - 2*classMeans(j)*image.*avBiasTerm);
            loss = loss + sum(im(:));
       end
    end
    
    loss = zeros(iters, 1);

    for i = 1:iters,
        U = abs(getMemberships(image, mask, classMeans, bias, q));
        classMeans = abs(getClassMeans(K, U, image, mask, bias, q));
        bias = abs(getBiasField(image, mask, U, classMeans, q));
        logloss = log(findLossFunction(image, K, q, mask, U, classMeans, bias));
        loss(i) = 1./logloss;
        fprintf('Normalised log loss : %f\n', loss(i));
    end
end


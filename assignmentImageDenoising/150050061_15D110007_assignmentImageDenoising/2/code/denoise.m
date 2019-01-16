function [image, losses] = denoise(noisyImage, alpha, imVar, method, gamma)

nImage = abs(noisyImage);
image  = nImage;
step_size = 0.005;
prev_loss = Inf;
losses = [];

for i=1:50,
    % Calculate gradient and store the temporary value
    gradient = calc_gradient(image, nImage, imVar, alpha, method, gamma);
    ii = image - step_size*gradient;
    
    % calculate the loss and see if its lesser than prev. value
    loss = calc_potential(ii, alpha, method, gamma);
    loss = loss + alpha*(ii.^2 + nImage.^2)/(2*imVar) - log(besseli(0, alpha.*nImage.*ii/imVar));
    loss = sum(loss(:));
    if loss < prev_loss,
        prev_loss = loss;
        step_size = step_size*1.1;
        image = ii;
        losses = [losses; loss];
    else
        step_size = step_size*0.5;
    end
    %fprintf('The loss is %f\n', loss);
end

end


function [image, losses] = denoise(noisyImage, alpha, imVar, method, gamma)

nImage = noisyImage;
image  = nImage;
step_size = 0.0005;
prev_loss = Inf;
losses = [];

for i=1:100,
    % Calculate gradient and store the temporary value
    gradient = calc_gradient(image, nImage, imVar, alpha, method, gamma);
    ii = image - step_size*gradient;
    
    % calculate the loss and see if its lesser than prev. value
    loss = calc_potential(ii, alpha, method, gamma);
    loss = loss + alpha*abs(ii-nImage).^2;
    loss = sum(loss(:));
    if loss < prev_loss,
        prev_loss = loss;
        step_size = step_size*1.1;
        losses = [losses; loss];
        image = ii;
    else
        step_size = step_size*0.5;
    end
    %fprintf('The loss is %f\n', loss);
end

end


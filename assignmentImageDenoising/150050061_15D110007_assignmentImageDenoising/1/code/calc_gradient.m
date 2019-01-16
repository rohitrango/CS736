function [ gradient ] = calc_gradient( image, nImage, imVar, alpha, method, gamma)

    % Gradient for Huber loss function
    function [grad] = huber_grad(x, y, gamma)
        grad = (x-y);
        index = (abs(grad) <= gamma);
        grad(~index) = gamma*sign(grad(~index));
    end

    function [grad] = d_adaptive_grad(x, y, gamma)
        del = (x-y);
        grad = gamma*sign(del) - gamma./(1 + (abs(del)/gamma)).*sign(del);
    end

    gradient = 0;
    % Calculate the gradient accordingly
    if method == 'q',
        for i=[-1,1]
            gradient = gradient + 2*(1-alpha)*(image - circshift(image, i, 1));
            gradient = gradient + 2*(1-alpha)*(image - circshift(image, i, 2));
        end
    elseif method == 'h',
        for i=[-1,1]
            gradient = gradient + (1-alpha)*huber_grad(image, circshift(image, i, 1), gamma);
            gradient = gradient + (1-alpha)*huber_grad(image, circshift(image, i, 2), gamma);
        end
    elseif method == 'd',
        for i=[-1,1]
            gradient = gradient + (1-alpha)*d_adaptive_grad(image, circshift(image, i, 1), gamma);
            gradient = gradient + (1-alpha)*d_adaptive_grad(image, circshift(image, i, 2), gamma);
        end
    end
    gradient = gradient + alpha*(image - nImage);
end


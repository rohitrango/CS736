function [ loss ] = calc_potential( image, alpha, method, gamma)
  
    function [huber] = huber_loss(x, y, gamma)
        index = abs(x - y) <= gamma;
        huber = abs(x-y);
        huber(index) = 0.5*huber(index).^2;
        huber(~index) = gamma*(huber(~index) - 0.5*gamma);
    end

    function [dadap] = d_adaptive_loss(x, y, gamma)
       del = abs(x-y);
       dadap = gamma*del - gamma*gamma*log(1 + del/gamma);
    end

    loss = 0;
    % quadratic loss
    if method == 'q',
        for i=[-1,1],
            loss = loss + abs(image - circshift(image, i, 1)).^2;
            loss = loss + abs(image - circshift(image, i, 2)).^2;
        end

    % Huber loss
    elseif method == 'h',
        for i=[-1,1],
            loss = loss + huber_loss(image, circshift(image, i, 1), gamma);
            loss = loss + huber_loss(image, circshift(image, i, 2), gamma);
        end
        
    % Discontinity adaptive loss
    elseif method == 'd',
        for i=[-1,1],
            loss = loss + d_adaptive_loss(image, circshift(image, i, 1), gamma);
            loss = loss + d_adaptive_loss(image, circshift(image, i, 2), gamma);
        end
    end
    loss = (1-alpha)*loss;
end


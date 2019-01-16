function [rmse_ramlak] = plot_rmse(S0, L_max, theta, s),
    % RMSE plots
    rmse_ramlak = zeros(L_max, 1);
    r = radon(S0, theta);
    for l =1:L_max,
        h_filt = myFilter(r, 'ramlak', l);
        rk = 0.5*iradon(h_filt, theta, 'linear', 'none');
        rk = rk(2:257, 2:257);
        rmse_ramlak(l) = RMSE(rk, S0);
    end
    figure;
    plot(rmse_ramlak);
    title(s);
end
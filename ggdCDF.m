function [ prob ] = ggdCDF( x, alpha, beta )
%     expression below has problems. 
%     prob = 0.5 + sign(x) .* gammainc((abs(x)/alpha).^beta , 1/beta , 'lower') / 2 / gamma(1/beta);

    % use the numerical method to compute CDF
    pdf = @(x) beta/2/alpha/gamma(1/beta) * exp( -((abs(x)/alpha).^beta) );
    t = linspace(-400, 400, 10000);% range: 10 deviations      
    P = pdf(t);
    C = cumtrapz(t, P);
    idx = findNearest(t, x);
    prob = C(idx);
end

function idx = findNearest(t, x)
    idx = zeros(size(x));
    for i = 1:length(x)
        [~, idx(i)] = min(abs(x(i) - t));
    end
end

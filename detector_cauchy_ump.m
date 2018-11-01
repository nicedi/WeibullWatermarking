function L = detector_cauchy_ump(delta, gamma, y, wm, wmstrength)
    
    L = sum(log((gamma^2 + (y - delta).^2) ./ (gamma^2 + (y./(1 + wmstrength*wm) - delta).^2)));


end


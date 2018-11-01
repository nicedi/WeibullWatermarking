function L = detector_cauchy_ump_ADD(delta, gamma, y, wm, m)
    
    L = sum(log((gamma^2 + (y - delta).^2) ./ (gamma^2 + (y - m.*wm - delta).^2)));


end


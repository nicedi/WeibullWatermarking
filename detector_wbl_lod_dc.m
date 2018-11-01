function L = detector_wbl_lod_dc(a, ro, Y, W)
    term1 = (1 - ro) * sum(W ./ (Y + eps));
    term2 = ro * a^(-ro) * sum(Y.^(ro - 1) .* W);
    L = term1 + term2;  
end


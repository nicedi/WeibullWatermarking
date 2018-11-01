function L = detector_wbl_lod_dc2(a, ro, Y, W)
    % term1 = (1 - ro) * sum(W ./ (Y + eps));
    % L = ro * a^(-ro) * sum(Y.^(ro - 1) .* W);
    % L = term1 + term2;  
    Y_mask = abs(Y) > 1e-6;
    LO = (ro * a^(-ro) * Y.^ro + (1-ro)) ./ Y;
    L = sum(LO(Y_mask) .* W(Y_mask));
end


function L = detector_wbl_lod_jnd(a, ro, Y, W, C)
    Y_mask = abs(Y) > 1e-6;
%     LO = (1 - ro) ./ (Y+eps) + ro * a^(-ro) * Y.^(ro - 1);
%     jnd = C .* (abs(Y ./ C)).^0.33;
%     jnd_d = C ./ (abs(C)).^0.33 * 0.33 .* (abs(Y)).^(-0.67) .* sign(Y);
    A = (ro * a^(-ro) * Y.^ro + (1-ro)) ./ Y;
%     LO = A .* jnd;
    
    L = sum(A(Y_mask) .* C(Y_mask) .* W(Y_mask));
end


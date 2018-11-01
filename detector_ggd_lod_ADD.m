function L = detector_ggd_lod_ADD(alpha, beta, Y, W)
    b = 1/alpha;
    c = beta;
%     L = sum(c * b^c * (abs(Y) .^ c) ./ Y .* W);
%     L = sum(c * b^c * (abs(Y+eps) .^ (c-1)) .* sign(Y) .* W);
    L = sum( (abs(Y+eps) .^ (c-1)) .* sign(Y) .* W );
end


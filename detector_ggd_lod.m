function L = detector_ggd_lod(alpha, beta, Y, W)
    b = 1/alpha;
    c = beta;
    L = sum(c * b^c * (abs(Y) .^ c) .* W);
end


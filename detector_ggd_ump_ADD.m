function L = detector_ggd_ump_ADD(alpha, beta, Y, W, m)
    b = 1/alpha;
    c = beta;
    L = sum(b^c * (abs(Y) .^ c - abs(Y - m.*W) .^ c));
end


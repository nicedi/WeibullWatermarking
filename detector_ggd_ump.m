function L = detector_ggd_ump(alpha, beta, Y, W, lambda)
    b = 1/alpha;
    c = beta;
%     L = b^c * sum(abs(Y).^c - abs(Y-W).^c);
    L = sum((abs(b * Y) .^ c) .* (1 - (1 + lambda * W) .^ (-c)));
end


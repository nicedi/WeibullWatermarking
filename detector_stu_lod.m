function L = detector_stu_lod(lambda, nu, Y, W)
    A = Y.^2;
    L = sum(lambda * (nu + 1) * A .* W ./ (nu + lambda * A));

end


function L = detector_stu_ump(lambda, nu, Y, W, wmstren)
    A = lambda / nu;
    L = sum( log((1 + A * (Y ./ (1 + wmstren * W)) .^ 2) ./ (1 + A * (Y .^ 2))) ) * (-(nu + 1) / 2);

end


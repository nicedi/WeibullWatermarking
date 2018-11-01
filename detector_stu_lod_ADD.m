function L = detector_stu_lod_ADD(lambda, nu, Y, W)
% Locally Optimum Nonlinearity detection
    L = sum((nu + 1) * Y .* W ./ (Y.^2 + nu/lambda));

end


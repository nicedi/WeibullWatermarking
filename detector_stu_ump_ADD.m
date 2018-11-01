function L = detector_stu_ump_ADD(lambda, nu, Y, W, m)
    A = lambda / nu;
    L = sum( log( (1 + A * (Y .^ 2)) ./ (1 + A * (Y - m.*W) .^ 2) ) ) * ((nu + 1) / 2);

end


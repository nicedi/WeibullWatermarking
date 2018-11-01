function [ P ] = ggdAPD( coef, n )
    [alpha, beta] = mle_ggd(coef);
    P = 2 * ggdCDF(-n, alpha, beta);% have to multiply 2

end
function [ P ] = weibullAPD( coef, n )
    [alpha, ro] = mle_wbl(coef);
    P = exp(-(n / alpha) .^ ro);

end
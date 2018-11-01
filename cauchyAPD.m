function [ P ] = cauchyAPD( coef, n )
    [gamma, delta] = mle_cauchy(coef);
    P = 1 - 2 * atan((n - delta) / gamma) / pi;
end
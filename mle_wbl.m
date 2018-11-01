function [ a, ro ] = mle_wbl( coef )
    coef(coef==0) = coef(coef==0) + eps;
    params  = mle(abs(coef), 'distribution', 'wbl');
    ro = params(2);
    a = params(1);

end


function [ P ] = stuAPD( coef, n )  
    [lambda , nu] = stuParamEst(coef);
    P = 2 * stuCDF(-n, lambda, nu);% have to multiply 2
end
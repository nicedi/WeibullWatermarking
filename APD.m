function [ P ] = APD( coef, n )
%% calculate APD from coefficients
    len = length(coef);
    coef = abs(coef);
    P = zeros(size(n));
    for i = 1:length(n)
        P(i) = sum(coef > n(i)) / len;
    end

end
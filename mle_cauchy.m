function [ gamma, delta ] = mle_cauchy( coef )
    params = mle(coef, 'pdf', @cauchyPDF, 'start', [0.001, 0.01]);
    gamma = params(1);
    delta = params(2);
end


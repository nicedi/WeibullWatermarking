function p = stuPDF(x, lambda, nu)
    p = gamma((nu+1)/2) / gamma(nu/2) * (lambda/nu/pi)^0.5 * (1 + lambda/nu*(x.^2)).^(-(nu+1)/2);
end
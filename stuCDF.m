function [ prob ] = stuCDF( x, lambda, nu )
%% this CDF formular comes from wikipedia
    prob = 0.5 + x * gamma((nu+1)/2) / gamma(nu/2) * (lambda/nu/pi)^0.5 .* ...
        hypergeom([0.5, (nu+1)/2], 1.5, -(lambda*x.^2)/nu);


end


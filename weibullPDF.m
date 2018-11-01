function p = weibullPDF(x, alpha, ro)
    p = ro / alpha * ((x / alpha).^(ro - 1)) .* exp(-((x/alpha).^ro));
end
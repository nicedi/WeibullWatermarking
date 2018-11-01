function p = cauchyPDF(x, gamma, delta)
    p = gamma ./ pi ./ (gamma^2 + (x - delta).^2);
end
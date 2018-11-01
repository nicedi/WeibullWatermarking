function p = ggdPDF(x, alpha, beta)
    p = beta/2/alpha/gamma(1/beta) * exp( -((abs(x)/alpha).^beta) );
end
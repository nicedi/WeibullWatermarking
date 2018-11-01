function drawAPD(coef)
    n = linspace(0, 200, 100);
    p1 = APD(coef, n);% actual APD
    p2 = ggdAPD(coef, n);
    p3 = cauchyAPD(coef, n);
    p4 = stuAPD(coef, n);
    p5 = weibullAPD(coef, n);
    semilogy(n,[p1; p5; p2; p3; p4]);
    legend('Actual', 'Weibull', 'GGD', 'Cauchy','t');
end
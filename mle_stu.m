function params = mle_stu( coef )

    opts=optimset('Display','iter','FunValCheck','on','MaxIter',300,...
        'MaxFunEvals',600,'TolFun',1e-5,'TolX',1e-5);
    
%     [lambda, nu] = mle(coef, 'pdf', @stuPDF, 'start', [100, 1], 'lowerbound', [1e-4,1e-4], 'options', opts);
    params = mle(coef, 'pdf', @stuPDF, 'start', [500, 1], 'lowerbound', [1, 0.1], 'options', opts);


end


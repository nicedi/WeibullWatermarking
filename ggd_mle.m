function [a, b] = ggd_mle(data)

    opts=optimset('Display','off','FunValCheck','off','MaxIter',200,...
        'MaxFunEvals',400,'TolFun',1e-5,'TolX',1e-5);
    init_param=[0.5, 0.1];
    ggd_ll = @(param)-sum(log(sqrt(gamma(3/param(1))/gamma(1/param(1)))/param(2)*param(1)/2/gamma(1/param(1)))-abs((sqrt(gamma(3/param(1))/gamma(1/param(1)))/param(2))*data).^param(1));
    
    % [param, fval, exitflag, output]=fminsearch(@ggd_llh,init_param,opts);
    param = fminsearch(ggd_ll,init_param,opts);
    theta = param(1);
    sigma = param(2);
    
    b = theta;
    a = sigma / (gamma(3/b)/gamma(1/b))^0.5;

end
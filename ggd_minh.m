function [a, b, msg] = ggd_minh(coef)
%% from the paper of Minh N. Do.
    msg = '';
    m1 = mean(abs(coef));
    m2 = mean(coef.^2);
    b0 = m1/sqrt(m2);
    absc = abs(coef);
    term2 = log(absc+eps);
    iter = 0;
    while 1
        term1 = absc.^b0;    
        g = 1 + psi(1/b0)/b0 - sum(term1 .* term2)/sum(term1) + log(mean(term1)*b0)/b0;
        dg = -psi(1/b0)/(b0^2) - psi(1,1/b0)/(b0^3) + b0^(-2) - sum(term1.*(term2.^2))/sum(term1) + ...
            (sum(term1.*term2)^2)/(sum(term1)^2) + sum(term1.*term2)/sum(term1)/b0 - log(mean(term1)*b0)/(b0^2);
        
        b = b0 - g/dg;
        if (b-b0) <= 1e-4
            break
        end
        b0 = b;
        
        iter = iter + 1;
        if iter > 400 % exit while not converge
            msg = 'max iteration exceeded.';
            break;            
        end
    end
    a = (mean(absc.^b)*b).^(1/b);
    
end


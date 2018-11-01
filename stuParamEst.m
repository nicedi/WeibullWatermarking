function [ lambda_new, nu_new, msg ] = stuParamEst( y )
% reference: Chuanhai Liu, Donald B. Rubin
% ML ESTIMATION OF THE t DISTRIBUTION USING EM AND ITS EXTENSIONS, ECM AND ECME
    msg = '';
    N = length(y);
    lambda = 1;% initial value
    nu = 1;
    tol = 1e-4;% tolerance   
    iter = 0;
    while 1      
        % E-step
        tau = (nu + 1) ./ (nu + lambda * y.^2);
        % CM1-step
        lambda_new = N / (tau' * (y.^2));
        % E-step
        tau_new = (nu + 1) ./ (nu + lambda_new * y.^2);
        % CM2-step
        nu_new = solveNu(tau_new, nu);
        
        if (lambda_new - lambda) <= tol && (nu_new - nu) <= tol % converge
            break;
        else
            lambda = lambda_new;
            nu = nu_new;
        end
        
        iter = iter + 1;
%         disp([num2str(iter), ', ', num2str(lambda_new), ', ', num2str(nu_new)]);

        if iter > 400
            msg = 'max iteration exceeded.';
            return;
        end
        
    end
end


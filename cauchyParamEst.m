function [delta, gamma, msg] = cauchyParamEst(y)
% reference: S. Schuster, PARAMETER ESTIMATION FOR THE CAUCHY DISTRIBUTION
    msg = '';
    delta0 = median(y);
    gamma0 = median(abs(y - median(y)));
    N = length(y);
    tol = 1e-4;% tolerance
    iter = 0;
    maxiter = 400;
    while 1
        W = 1 ./ ((y - delta0) .^ 2 + gamma0 ^ 2);
        delta1 = (y' * W) / sum(W);
        gamma1 = sqrt(N / 2 / sum(W));             
        if (delta1 - delta0) <= tol && (gamma1 - gamma0) <= tol % converge
            break;
        else
            delta0 = delta1;
            gamma0 = gamma1;
        end
        
        iter = iter + 1;
%         disp(iter);
        if iter > maxiter
%             [xdata, ydata] = normHist(y, 50);
%             LB = [1e-5, 1e-5];% lower bound
%             UB = [];
%             opts = optimset('Display','off');
%             cauchypdf = @(p,xdata) p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2);
%             pguess = [0.1, 5];
%             [p, ~] = lsqcurvefit(cauchypdf, pguess, xdata, ydata, LB, UB, opts);
%             delta1 = p(1);
%             gamma1 = p(2);
            msg = 'max iteration exceeded.';
            break;
        end
    end
    
    delta = delta1;
    gamma = gamma1;           
end


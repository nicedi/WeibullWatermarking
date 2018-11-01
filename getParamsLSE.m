function params = getParamsLSE(dctblks, lktbl)

    imgnum = size(dctblks, 3);
    sitenum = length(lktbl);
    
    % 1st row: GGD; 
    % 2nd row: Cauchy; 
    % 3rd row: STU; 
    % 4th row: Weibull
    params = zeros(sitenum, imgnum, 4, 2);
    LB = [1e-5, 1e-5];% lower bound
    UB = [];
    opts = optimset('Display','off');
    for i = 1:sitenum
        co = lktbl(i, :);
        patch = zeros(8, 8);
        patch(co(1), co(2)) = 1;
        marker = repmat(patch, [32 32]);
        
        for j = 1:imgnum
            blk = dctblks(:,:,j);
            coef = blk(logical(marker));
            [xdata, ydata] = normHist(coef, 50);
            idx = (ydata==0);
            xdata(idx) = [];
            ydata(idx) = [];

            % GGD params
            ggdpdf = @(p, xdata) p(2)/2/p(1)/gamma(1/p(2)) * exp( -((abs(xdata)/p(1)).^p(2)) );
            pguess = [1, 0.5];
            [p, ~] = lsqcurvefit(ggdpdf, pguess, xdata, ydata, LB, UB, opts);
            params(i,j,1,1) = p(1);% alpha
            params(i,j,1,2) = p(2);% beta
            
            % cauchy params
            cauchypdf = @(p,xdata) p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2);
            pguess = [0.1, 5];
            [p, ~] = lsqcurvefit(cauchypdf, pguess, xdata, ydata, LB, UB, opts);
            params(i,j,2,1) = p(1);% delta
            params(i,j,2,2) = p(2);% gamma
            
            % student-t params
            stupdf = @(p, xdata) gamma((p(2)+1)/2) / gamma(p(2)/2) * (p(1)/p(2)/pi)^0.5 * (1 + p(1)/p(2)*(xdata.^2)).^(-(p(2)+1)/2);
            pguess = [1.5, 0.2];
            [p, ~] = lsqcurvefit(stupdf, pguess, xdata, ydata, LB, UB, opts);
            params(i,j,3,1) = p(1);% lambda
            params(i,j,3,2) = p(2);% nu
            
            % Weibull params
            xdata = abs(xdata);
            wblpdf = @(p, xdata) p(2) / p(1) * ((xdata / p(1)).^(p(2) - 1)) .* exp(-((xdata / p(1)).^p(2)));
            pguess = [10, 0.5];
            [p, ~] = lsqcurvefit(wblpdf, pguess, xdata, ydata, LB, UB, opts);
            params(i,j,4,1) = p(1);% a
            params(i,j,4,2) = p(2);% ro
        end
    end
            
end


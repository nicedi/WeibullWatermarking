function params = getParams_full(dctblks, lktbl)

    imgnum = size(dctblks, 3);
    sitenum = 2;
    
    % 1st row: GGD; 
    % 2nd row: Cauchy; 
    % 3rd row: STU; 
    % 4th row: Weibull
    params = zeros(sitenum, imgnum, 2);
    for i = 1:sitenum
        co = lktbl(i, :);
        patch = zeros(8, 8);
        patch(co(1), co(2)) = 1;
        marker = repmat(patch, [32 32]);
        
        for j = 1:imgnum
            blk = dctblks(:,:,j);
            coef = blk(logical(marker));
%             disp([i,j]);
            
%             % GGD params
% %             [~, ~, msg] = ggd_song(coef, 0.1);
%             [alpha, beta, msg] = ggd_minh(coef);
%             if ~ isempty(msg)
%                 disp(['GGD: ', msg]);
%             end
%             if real(alpha) <= 0 || imag(alpha) ~= 0 || beta < 0
%                 % debug
%                 disp('GGD EM method faild');
%                 disp([alpha, beta]);
%                 
%                 [alpha, beta] = ggd_mle(coef);
%             end
%             params(i,j,1,1) = alpha;
%             params(i,j,1,2) = beta;
%             
%             % cauchy params
%             [delta, gamma, msg] = cauchyParamEst(coef);
%             % debug
%             if ~ isempty(msg)
%                 disp(['Cauchy: ', msg]);
%             end
%             
%             params(i,j,2,1) = delta;
%             params(i,j,2,2) = gamma;
%             
%             % student-t params
%             [lambda, nu, msg] = stuParamEst(coef);
%             %debug
%             if ~ isempty(msg)
%                 disp(['Student: ', msg]);
%             end
% 
%             params(i,j,3,1) = lambda;
%             params(i,j,3,2) = nu;
            
            % Weibull params
            [a, ro] = mle_wbl(coef);
            params(i,j,1) = a;
            params(i,j,2) = ro;
        end
    end
            
end


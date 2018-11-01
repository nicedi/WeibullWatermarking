function params = getParamsDC(dctblks, co)

    imgnum = size(dctblks, 3);
    
    params = zeros(imgnum, 2);

    patch = zeros(8, 8);
    patch(co(1), co(2)) = 1;
    marker = repmat(patch, [32 32]);
        
    for j = 1:imgnum
        blk = dctblks(:,:,j);
        coef = blk(logical(marker));
%             disp([i,j]);

        % Weibull params
        [a, ro] = mle_wbl(coef);
        params(j, 1) = a;
        params(j, 2) = ro;
    end
            
end


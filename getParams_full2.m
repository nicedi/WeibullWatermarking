function params = getParams_full2(dctblks, lktbl)

    imgnum = size(dctblks, 3);
    

    params = zeros(imgnum, 2);

    co_dc = lktbl(1, :);
    co_ac = lktbl(2, :);
    patch = zeros(8, 8);
    patch(co_dc(1), co_dc(2)) = 1;
    patch(co_ac(1), co_ac(2)) = 1;
    marker = repmat(patch, [32 32]);

    for j = 1:imgnum
        blk = dctblks(:,:,j);
        coef = blk(logical(marker));


        % Weibull params
        [a, ro] = mle_wbl(coef);
        params(j,1) = a;
        params(j,2) = ro;
    end

            
end


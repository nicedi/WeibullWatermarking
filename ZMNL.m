function data_new = ZMNL(data_old)

    colnum = size(data_old, 2);
    data_new = zeros(size(data_old));
    
    for i = 1:colnum
        sigma_bar = median(abs(data_old(:,i) - median(data_old(:,i))));
        sigma = sigma_bar / sqrt(0.7);
        nu = 3 * sigma;
        a = -nu * exp((data_old(:,i) + nu).^2 / -2 / sigma^2) .* (data_old(:,i) < -nu);
        b = data_old(:,i) .* (abs(data_old(:,i)) < nu);
        c = nu * exp((data_old(:,i) - nu).^2 / -2 / sigma^2) .* (data_old(:,i) > nu);
        data_new(:,i) = a+b+c;
    end
end

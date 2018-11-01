function result = combineResult(result1, result2)
    result = zeros(size(result1));
    res1 = load result1;
    res2 = load result2;
    result(1:500, :, :, :) = res1(1:500, :, :, :);
    result(501:1000, :, :, :) = res2(501:1000, :, :, :);
end
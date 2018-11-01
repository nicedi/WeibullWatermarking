function [ delta ] = detector_wbl_barni( z, w, ro, alpha, lambda )
    
    A = 1./(1 + lambda.*w);
%     delta = transpose(sum(ro*log(A))) + transpose(1-A.^ro) * ((z/alpha).^ro);
    delta = transpose(1 - A .^ ro) * ((z / alpha) .^ ro);

end


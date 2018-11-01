function L = detector_wbl_ump( a, ro, Y, W, lambda )
    % M: mask
    L = sum( ((Y / a) .^ ro) .* (1 - (1 + lambda.*W) .^ (-ro)) );


end


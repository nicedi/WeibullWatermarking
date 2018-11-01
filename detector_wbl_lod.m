function L = detector_wbl_lod(a, ro, Y, W)

    L = sum(ro / a^ro * Y.^ro .* W);
end


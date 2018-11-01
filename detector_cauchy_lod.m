function L = detector_cauchy_lod(delta, gamma, y, wm)

    A = y - delta;
    L = 2 * sum(y .* wm .* A ./ (gamma^2 + A.^2));

end


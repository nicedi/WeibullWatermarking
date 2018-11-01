function L = detector_cauchy_lod_ADD(delta, gamma, Y, W)
% Locally Optimum Nonlinearity
% reference: Alexia B., Locally Optimum Nonlinearities for DCT Watermark
% Detection
% same as locally optimum detection
    L = sum(2 * (Y-delta) .* W ./ ((Y-delta).^2 + gamma^2));

end


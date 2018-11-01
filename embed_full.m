imgWM = zeros(size(imgs));

maskDC = compMaskDC(imgs);
DCTblksEmbed = DCTblks .* (1 + maskDC .* WMblks_dc);

% wmstrength = 0.2;
% DCTblksEmbed = DCTblksEmbed .* (1 + wmstrength * WMblks_ac);

% Ref. paper: Optimum Detection for Spread Spectrum Watermarking that Employs Self masking
[JNDmask, Cmask] = DCTmask2(DCTblksEmbed);
embed_candidate = double(abs(DCTblksEmbed) > JNDmask);
DCTblksEmbed = DCTblksEmbed + JNDmask .* embed_candidate .* WMblks_ac;


for i = 1:imgnum
    % get watermarked image
    imgWM(:,:,i) = blockproc(DCTblksEmbed(:,:,i), [8 8], dct2img, 'UseParallel', true);
end

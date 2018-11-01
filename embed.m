imgWM = zeros(size(imgs));

% wmstrength = 0.2;
% DCTblksEmbed = DCTblks .* (1 + wmstrength * WMblks);

% DCTblksEmbed = DCTblks + mask .* WMblks;
% DCTblksEmbed = DCTblks .* (1 + maskWbl .* WMblks);

% Ref. paper: Optimum Detection for Spread Spectrum Watermarking that Employs Self masking
embed_candidate = double(abs(DCTblks) > JNDmask);
DCTblksEmbed = DCTblks + JNDmask .* embed_candidate .* WMblks;


for i = 1:imgnum
    % get watermarked image
    imgWM(:,:,i) = blockproc(DCTblksEmbed(:,:,i), [8 8], dct2img, 'UseParallel', true);
end

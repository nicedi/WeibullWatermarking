imgWM = zeros(size(imgs));
 
WMblks = makeWM(wm, co, imgnum); 

maskDC = compMaskDC(imgs);
% maskDC = compMaskDC2(imgs); % according to average luminance
DCTblksEmbed = DCTblks .* (1 + maskDC .* WMblks);

% wmstrength = 0.01;
% DCTblksEmbed = DCTblks .* (1 + wmstrength * WMblks);

for i = 1:imgnum
    % get watermarked image
    imgWM(:,:,i) = blockproc(DCTblksEmbed(:,:,i), [8 8], dct2img, 'UseParallel', true);
end

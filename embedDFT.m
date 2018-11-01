imgWM = zeros(size(imgs));
wmstrength = 0.2;

for i = 1:imgnum
    img = squeeze(imgs(:,:,i));
    % play DFT and shift
    dft_coef = fftshift(step(fftobj, img));
    % get target coefficients
    target_coef = dft_coef(mask);
    % embed
    target_coef_mag = abs(target_coef) .* (1 + wmstrength * wm);
    dft_coef(mask) = target_coef_mag .* exp(1j * angle(target_coef));
    
    temp_inner = conj(rot90(dft_coef(2:end, 2:end), 2));
    temp = zeros(size(img));
    temp(2:end, 2:end) = temp_inner;
    dft_coef(mask_symmetry) = temp(mask_symmetry);
    
%     symmetry_part = rot90(conj(reshape(dft_coef(mask), [dimblk, dimblk])),2);
%     dft_coef(mask_symmetry) = symmetry_part(:);
    
    % play IDFT
    imgWM(:,:,i) = step(ifftobj, fftshift(dft_coef));
end

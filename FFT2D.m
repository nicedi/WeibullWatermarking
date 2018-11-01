fftobj = vision.FFT;
load imgs
I = im2single(squeeze(imgs(:,:,8)));
J = step(fftobj, I);
% Shift zero-frequency components to the center of spectrum.
J_shifted = fftshift(J);
%J == fftshift(fftshift(J));
figure; imshow(I,[]); title('Input image, I');
%figure; imshow(log(max(abs(J), 1e-6)),[]), colormap(jet(64));
figure; imshow(log(max(abs(J_shifted), 1e-6)),[]), colormap(jet(64));
title('Magnitude of the FFT of I');


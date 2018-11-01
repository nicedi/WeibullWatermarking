function [ PSNR ] = psnr( img1, img2 )

[row, col] = size(img1);
img3 = (double(img1) - double(img2)) .^ 2;
mse = sum(sum(img3)) / row / col;
PSNR = 10 * log10( (255^2) / mse);

end


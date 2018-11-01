function A = calMask(imgATT, ATTDCTblks, WMblk)
    imgATT = double(im2uint8(imgATT));
    DCTblks = zeros(size(imgATT));
    D = dctmtx(8);
    img2dct = @(block_struct) D * block_struct.data * D';
    for j=1:20
        DCTblks(:,:,j) = blockproc(imgATT(:,:,j), [8 8], img2dct, 'UseParallel', true);
    end
    M = DCTmask(DCTblks) / 255;% scale to [0, 1]
    M(M > 1) = 1;
    xaw = M .* WMblk;% y = x(1 + aw) <=> y = x + xaw
    x = ATTDCTblks - xaw;
    A = M ./ (x+eps);
end


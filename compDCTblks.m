function DCTblks = compDCTblks(imgs, imgnum)
    DCTblks = zeros(size(imgs));
    D = dctmtx(8);
    img2dct = @(block_struct) D * block_struct.data * D';
    for j = 1:imgnum
        DCTblks(:,:,j) = blockproc(imgs(:,:,j), [8 8], img2dct, 'UseParallel', true);
    end
end


function [JNDmask, Cmask] = DCTmask2(DCTblks)
    imgnum = size(DCTblks, 3);
    JNDmask = zeros(size(DCTblks));
    
    for i = 1:imgnum
        JNDmask(:, :, i) = blockproc(DCTblks(:, :, i), [8 8], @func, 'UseParallel', true);
    end

    Cmask = zeros(size(DCTblks));
    
    for i = 1:imgnum
        Cmask(:, :, i) = blockproc(DCTblks(:, :, i), [8 8], @func2, 'UseParallel', true);
    end

end

function out = func(block)

    quantization_tbl = [
        16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];

    out = zeros(8,8);
    
    for i = 1:8
        for j = 1:8
    
            ck = quantization_tbl(i,j) / 2 * (block.data(1,1) / 1024)^0.694;
    
            out(i,j) = ck * (abs(block.data(i,j) / ck))^0.33;
        end
    end
end

function out = func2(block)

    quantization_tbl = [
        16 11 10 16 24 40 51 61;
        12 12 14 19 26 58 60 55;
        14 13 16 24 40 57 69 56;
        14 17 22 29 51 87 80 62;
        18 22 37 56 68 109 103 77;
        24 35 55 64 81 104 113 92;
        49 64 78 87 103 121 120 101;
        72 92 95 98 112 100 103 99];

    out = zeros(8,8);
    
    for i = 1:8
        for j = 1:8
    
            ck = quantization_tbl(i,j) / 2 * (block.data(1,1) / 1024)^0.694;
    
            out(i,j) = ck;
        end
    end
end


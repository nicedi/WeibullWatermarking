function map = compMaskDC(imgs)
    % blk = @(block_struct) entropy(block_struct.data);
    imgnum = size(imgs, 3);
    map = zeros(size(imgs));
    
    for i = 1:imgnum
        map(:, :, i) = blockproc(uint8(imgs(:, :, i)), [8 8], @func, 'UseParallel', true);
    end


end

function out = func(block)
    out = zeros(8,8);
    criterion = std2(block.data);
    if criterion >= 30
        out(1,1) = 0.02;
    else
        out(1,1) = 0.01;
    end
end
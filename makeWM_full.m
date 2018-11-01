function [ wmMat ] = makeWM_full( wm, lktbl, imgnum)
    dim = sqrt(length(wm));
    wm = reshape(wm, [dim dim]);

    fun = @(block) expand(block.data, lktbl);
    wmexpand = blockproc(wm, [1 1], fun, 'UseParallel', true);
    wmMat = repmat(wmexpand, [1 1 imgnum]);
end    

function m = expand(data, lktbl)
    m = zeros(8,8);
    for i = 1:size(lktbl,1)
    
        m(lktbl(i,1), lktbl(i,2)) = data;
    end
end
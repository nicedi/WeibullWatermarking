function [ wmMat ] = makeWM( wm, co, imgnum)
    dim = sqrt(length(wm));
    wm = reshape(wm, [dim dim]);
    fun = @(block) expand(block.data, co);
    wmexpand = blockproc(wm, [1 1], fun, 'UseParallel', true);
    wmMat = repmat(wmexpand, [1 1 imgnum]);
end    

function m = expand(data, co)
    m = zeros(8,8);
    m(co(1), co(2)) = data;
end
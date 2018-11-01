function [ blocks ] = divideImage( img )
%% divide image into 8 x 8 blocks
    [h, w] = size(img);
    bsize = 8;% block size
    vlen = h / bsize;
    hlen = w / bsize;
    blocks = zeros(bsize, bsize, vlen * hlen);
    for i = 1:vlen*hlen
        if mod(i, vlen) == 0
            hidx = vlen;
            vidx = fix(i/vlen) - 1;
        else
            hidx = mod(i,vlen);
            vidx = fix(i/vlen);
        end
        blocks(:,:,i) = img((hidx-1)*bsize+1 : (hidx-1)*bsize+8, vidx*bsize+1 : vidx*bsize+8);
    end

end


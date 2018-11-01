function img = recoverImg(IMGblks)
%% verify that whether the division is correct
    img = zeros(256,256);
    vlen = 32;% 512 x 512 image, block-size 8 x 8
    for i=1:1024
        if mod(i, vlen) == 0
            hidx = vlen*8-7;
            vidx = (fix(i/vlen)-1)*8+1;
        else
            hidx = (mod(i,vlen)-1)*8+1;
            vidx = fix(i/vlen) * 8 + 1;
        end
        img(hidx:hidx+7, vidx:vidx+7) = IMGblks(:,:,i);
    end
end
function [mask, mask_symmetry] = compMaskDFT(width, height, masksize)
%     offset = 0;
%     mask = zeros(width, height);
%     mask_symmetry = zeros(width, height);
%     
%     center = [floor((width-1)/2)+2, floor((height-1)/2)+2];
%     mask(center(1)-masksize(2)/2-offset:center(1)-1-offset, center(2)+1+offset:center(2)+masksize(1)+offset) = 1;
%     mask(center(1)+1+offset:center(1)+masksize(2)/2+offset, center(2)+1+offset:center(2)+masksize(1)+offset) = 1;
%     
%     mask_symmetry(center(1)-masksize(2)/2-offset:center(1)-1-offset, center(2)-masksize(1)-offset:center(2)-1-offset) = 1;
%     mask_symmetry(center(1)+1+offset:center(1)+masksize(2)/2+offset, center(2)-masksize(1)-offset:center(2)-1-offset) = 1;
%     
%     mask = logical(mask);
%     mask_symmetry = logical(mask_symmetry);


%     len = masksize(1) * masksize(2);
    len = masksize;
    mask = zeros(width, height);
    mask_symmetry = zeros(width, height);
    offset = 100;
    center = [floor((width-1)/2)+2, floor((height-1)/2)+2];
    
    r_up0 = center(1)-offset;
    c_up0 = center(2)+1;
    r_down0 = center(1)+offset;
    c_down0 = center(2)+1;
    step = 0;
    r_up = r_up0;
    c_up = c_up0;
    r_down = r_down0;
    c_down = c_down0;
    
    for i = 1:len/2
        if r_up == center(1)
            step = step + 1;
            r_up = r_up0 - step;
            c_up = c_up0;
            r_down = r_down0 + step;
            c_down = c_down0;
        end
        mask(r_up,c_up) = 1;
        mask(r_down, c_down) = 1;
        r_up = r_up + 1;
        c_up = c_up + 1;
        r_down = r_down - 1;
        c_down = c_down + 1;

    end
    % build symmetry part
    temp = mask(2:end, 2:end);
    mask_symmetry(2:end, 2:end) = fliplr(temp);
    
    mask = logical(mask);
    mask_symmetry = logical(mask_symmetry);

end
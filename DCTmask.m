function mask = DCTmask( DCTblks )
% version 1
%     T = DCTblks / 5;
%     T(T > abs(dctblks)) = dctblks(T > abs(dctblks));

% version 2
    mask = zeros(size(DCTblks));
    for i = 1:size(DCTblks, 3)
        mask(:,:,i) = blockproc(DCTblks(:,:,i), [8 8], @calMask, 'UseParallel', true);
    end
    % adjust mask
    mask = mask / 5;
    while 1
        idx = mask > abs(DCTblks);
        if sum(idx(:)) > 0
            mask(idx) = abs(DCTblks(idx) / 5);
        else
            break;
        end
    end
end

% function f = F(m, w)
%     f = m / 16 / w;
% end

function T = calMask(block)
    Tmin = 1.1548;
    w = 0.7;
    r = 0.7;
    K = 1.728;
    fmin = 3.68;
    alphaT = 0.649;
    % view from a distance of 64 pixel/degree.
    % horizontal width of a pixel in degrees of visual angle
%     wx = 1/32;
%     wy = 1/32;     
    data = block.data;
    T = zeros(size(data));
    sfreq = [0 2 4 6 8 10 12 14];
    
    for i = 0:7
        for j = 0:7
            if i==0 && j==0
                T(1,1) = 0;% DC component excluded
                continue;
            end
            logT = log(Tmin*(sfreq(i+1)^2 + sfreq(j+1)^2)^2 / ...
                        ((sfreq(i+1)^2 + sfreq(j+1)^2)^2 - 4*(1-r)*sfreq(i+1)^2*sfreq(j+1)^2)) + ...
                        K*(log(sqrt(sfreq(i+1)^2 + sfreq(j+1)^2)) - log(fmin))^2;
            T(i+1,j+1) = exp(logT) * (data(1,1)/1024)^alphaT;
            T(i+1,j+1) = max(T(i+1,j+1), abs(data(i+1,j+1))^w * T(i+1,j+1)^(1-w));
%             T(i+1,j+1) = T(i+1,j+1);
        end
    end
end


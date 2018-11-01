function [ basis ] = dctBasis()
    basis = zeros(8, 8, 8, 8);% p x q x m x n
    a = ones(8, 8) / 4;
    a(1,1) = a(1,1) / 2;
    a(1, 2:8) = a(1, 2:8) / sqrt(2);
    a(2:8, 1) = a(2:8, 1) / sqrt(2);
    for p = 0:7
        for q = 0:7
            for m = 0:7
                for n = 0:7
                    basis(p+1,q+1,m+1,n+1) = ...
                        a(p+1,q+1) * cos(pi*(2*m+1)*p/16) * cos(pi*(2*n+1)*q/16);
                end
            end
        end
    end
end


function [binCtrs, binElms] = normHist(coes, binN)
    vec = coes(:);
    n = length(vec);

    posbound = max(vec);
    negbound = min(vec);

    binCtrs = linspace(negbound, posbound, binN+1);
    binWidth = binCtrs(2) - binCtrs(1);
    binCtrs = binCtrs + binWidth/2;
    binCtrs(end) = [];
    
    binElms = hist(vec,binCtrs);  
    binElms = binElms / (n * binWidth);% normalize. such that sum(binElms)*binWidth == 1
end
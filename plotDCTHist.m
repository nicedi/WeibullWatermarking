function plotDCTHist( dctcoef )
%% plot all 64 histograms
    blks = divideImage(dctcoef);
    figure;
    for i = 1:8
        for j = 1:8
            idx = (i-1)*8+j;
            subplot(8,8,idx);
            coef = squeeze(blks(i,j,:));
            hist(coef, 200);
        end
    end
    


end


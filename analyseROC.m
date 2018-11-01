function [AUC, avgAUC] = analyseROC(result)
% result = zeros(wmnum, sitenum, imgnum, modelnum, 2); 
    [wmnum, sitenum, imgnum, modelnum, ~] = size(result);
    AUC = zeros(sitenum, imgnum, modelnum);
    labels = [ones(wmnum, 1) ; zeros(wmnum, 1)];
    for i = 1:sitenum
        for j = 1:imgnum
            for k = 1:modelnum  
%                 disp([i,j,k]);
                scores = [squeeze(result(:,i,j,k,1)) ; squeeze(result(:,i,j,k,2))];
                [~,~,~,area] = perfcurve(labels, scores, 1);
                AUC(i,j,k) = area;
            end
        end
    end
    avgAUC = squeeze(mean(AUC, 2));
%     filename = ['result_', embedScheme, attackCategory, '.xls'];
%     xlswrite(filename, squeeze(avgAUC));
end


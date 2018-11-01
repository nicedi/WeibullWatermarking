function [AUC, avgAUC] = analyseROC_DC(result)
% result = zeros(wmnum, imgnum, modelnum, 2); 
    [wmnum, imgnum, modelnum, ~] = size(result);
    AUC = zeros(imgnum, modelnum);
    labels = [ones(wmnum, 1) ; zeros(wmnum, 1)];

    for j = 1:imgnum
        for k = 1:modelnum  
%             disp([j,k]);
            scores = [squeeze(result(:,j,k,1)) ; squeeze(result(:,j,k,2))];
            [~,~,~,area] = perfcurve(labels, scores, 1);
            AUC(j,k) = area;
        end
    end

    avgAUC = mean(AUC, 1);
%     filename = ['result_', embedScheme, attackCategory, '.xls'];
%     xlswrite(filename, squeeze(avgAUC));
end


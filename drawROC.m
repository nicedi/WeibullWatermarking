function drawROC(posval, negval)
%% draw ROC curve from positive detection results and negtive ones 
    poscount = length(posval);
    negcount = length(negval);
    temp = sort(posval, 'descend');
    threshold = linspace(min(negval), temp(2), 100);
    len = length(threshold);
    result = zeros(len, 2);
    
    for i = 1:len
        % Sensitivity = P(test positive | actual positive)
       result(i,1) = sum(posval > threshold(i)) / poscount;
       % Specificity = P(test negtive | actual negtive)
       result(i,2) = sum(negval < threshold(i)) / negcount;
    end
    % plot sensitivity against 1-specificity to create the ROC curve for a
    % test
    scatter(1 - result(:,2), result(:,1));

end
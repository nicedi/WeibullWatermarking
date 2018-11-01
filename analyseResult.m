function analyseResult(result, img, model)
% result = zeros(trials, sitenum, imgnum, modelnum, 2); % 1000 9 20 16 2    

    sitenum = size(result, 2);
    for i = 1:sitenum

        pos = squeeze(result(:, i, img, model, 1));
        neg = squeeze(result(:, i, img, model, 2));
        subplot(3, 3, i);
        [e1, c1] = hist(pos, 100);
        bar(c1, e1, 'r',  'EdgeColor', 'r');

        hold;

        [e0, c0] = hist(neg, 100);
        bar(c0, e0, 'b',  'EdgeColor', 'b');


    end
end


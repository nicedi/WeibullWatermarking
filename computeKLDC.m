function [klDat, mseDat] = computeKLDC(DCTblks, idx)
    co = [1, 1];
    wmlength = 1024;
    imgnum = size(DCTblks, 3);
    
    WMblks = makeWM(ones(wmlength,1), co, imgnum);
    dccoef = reshape(DCTblks(WMblks ~= 0), [wmlength imgnum]);
    klDat = zeros(imgnum, 10);
    mseDat = zeros(imgnum, 10);
    for i = 1:imgnum
        coef = dccoef(:, i);
        randcoef = build_fold(coef(idx));
        for f = 1:10
            [samplePos , sampleVal] = normHist(randcoef(f).test, 100);
            sampleVal = sampleVal / sum(sampleVal) + eps;
    
            [a, ro] = mle_wbl(randcoef(f).train);
            modelVal = weibullPDF(samplePos, a, ro);
            modelVal = modelVal / sum(modelVal); 
            klDat(i, f) = klcal(samplePos, sampleVal, modelVal);
            mseDat(i, f) = msecal(sampleVal, modelVal);
        end
    end   
    klDat = mean(mean(klDat));
    mseDat = mean(mean(mseDat));
end


function out = klcal(samplePos, sampleVal, modelVal)
    out = kldiv(samplePos, sampleVal, modelVal);
end

function out = msecal(sampleVal, modelVal)
    out = mean((sampleVal - modelVal).^2);
end

function out = build_fold(coef)
    field1 = 'train';
    field2 = 'test';
    value1 = cell(1, 10);
    value2 = cell(1, 10);

    partition = fix(1024 * 0.1);
    for i = 1:10
        if i == 10
            value1{i} = coef(1 : 9*partition);
            value2{i} = coef(9*partition+1 : end);
        elseif i == 1
            value1{i} = coef(partition+1 : end);
            value2{i} = coef(1 : partition);
        else
            value1{i} = [coef(1 : (i-1)*partition) ; coef(i*partition+1 : end)];
            value2{i} = coef((i-1)*partition+1 : i*partition);
        end
    end
    out = struct(field1, value1, field2, value2);
end
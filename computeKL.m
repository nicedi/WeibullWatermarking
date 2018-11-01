function [klDat, mseDat] = computeKL(DCTimgs, idx)
    klDat = zeros(4, 8, 8, 20, 10); 
    mseDat = zeros(4, 8, 8, 20, 10); 
    
    DCTblks = zeros(8,8,1024,20);    
    for i = 1:20
        dctimg = DCTimgs(:,:,i);
        DCTblks(:,:,:,i) = divideImage(dctimg);
    end   
    
    % 10-fold cross-validation
    % line 1:ggd, line 2:cauchy, line 3:stu, line 4:weibull
        
    for j = 1:8
        for k = 1:8
            disp(['Row: ', num2str(j), ' Col: ', num2str(k)]);
            if j==1 && k==1 % DC component
                continue
            end
            for t = 1:20
                coef = squeeze(DCTblks(j,k,:,t));
                randcoef = build_fold(coef(idx));
                for f = 1:10
                    [samplePos , sampleVal] = normHist(randcoef(f).test, 100);
                    sampleVal = sampleVal / sum(sampleVal) + eps;
                    for i = 1:4
                        switch i
                            case 1 % GGD
                                [alpha, beta, msg] = ggd_minh(randcoef(f).train);% estimate parameters                            
                                if ~ isempty(msg)
                                    disp(['GGD Minh: ', msg]);
                                end
                                if real(alpha) <= 0 || imag(alpha) ~= 0 || beta < 0
                                    [alpha, beta, msg] = ggd_song(randcoef(f).train, 0.1);
                                    if ~ isempty(msg)
                                        disp(['GGD Song: ', msg]);
                                    end
                                end
                                modelVal = ggdPDF(samplePos, alpha, beta);
                            case 2 % Gauchy
                                [delta, gamma, msg] = cauchyParamEst(randcoef(f).train);
                                if ~ isempty(msg)
                                    disp(['Cauchy: ', msg]);
                                end
                                modelVal = cauchyPDF(samplePos, gamma, delta);
                            case 3 % Student-t
                                [lambda, nu, msg] = stuParamEst(randcoef(f).train);
                                if ~ isempty(msg)
                                    disp(['Student: ', msg]);
                                end
                                modelVal = stuPDF(samplePos, lambda, nu);

                            case 4 % Weibull
                                [a, ro] = mle_wbl(randcoef(f).train);
                                [samplePos , sampleVal] = normHist(abs(randcoef(f).test), 100);
                                sampleVal = sampleVal / sum(sampleVal) + eps;
                                samplePos(1) = samplePos(1) + eps;
                                modelVal = weibullPDF(samplePos, a, ro);
                        end
                        modelVal = modelVal / sum(modelVal); % normalize
                        klDat(i,j,k,t,f) = klcal(samplePos, sampleVal, modelVal);
                        mseDat(i,j,k,t,f) = msecal(sampleVal, modelVal);
    %                     disp(['    image',num2str(t),' KL div.:',num2str(klDat(i,j,k,t)),...
    %                         ' MSE dist.:',num2str(mseDat(i,j,k,t))]);
                    end
                end

            end
        end
    end

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

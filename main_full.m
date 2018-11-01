%% init
dim = 256;
imgnum = 20;
wmlength = 1024;
dimblk = 32; % block dimension
wmnum = 1000;

load imgs.mat
% imgs = zeros(dim, dim, imgnum);
% for i = 1:imgnum
%     imgFile = ['image',num2str(i),'.bmp'];
% %     imgs(:,:,i) = imresize(imread(['images/',imgFile]), [dim dim]);
%     imgs(:,:,i) = im2double(imresize(imread(['images/',imgFile]), [256 256]));
% end

load DCTblks.mat
% DCTblks = compDCTblks(imgs, imgnum);

load pnseqs.mat
% shift = round(rand() * wmnum);
% pnseqs = genPN(wmlength, shift);


% lookup table
lktbl = [
    1,1;
    3,3;];
sitenum = size(lktbl, 1);

% patch = zeros(8, 8);
% for i = 1:sitenum
%     co = lktbl(i,:);
%     patch(co(1), co(2)) = 1;
% end
% embedpos = repmat(patch, [dimblk dimblk imgnum]);


%% 1. draw APD
% co = [2, 3];
% WMblks = makeWM(ones(wmlength,1), co, imgnum);
% testcoef = reshape(DCTblks(WMblks ~= 0), [wmlength imgnum]);
% drawAPD(testcoef(:,8));

%% 2. compute KL divergence
% 10-fold cross-validation
% idx = randperm(wmlength);
% [klDat, mseDat] = computeKL(DCTblks, idx);

%% 3. show model generalizition
% resKL = transpose(compMdl(klDat));
% resKL = [resKL(:,3), resKL(:,2), resKL(:,1), resKL(:,4)];
% semilogy(resKL);
% axis square;
% legend('Students t', 'Cauchy', 'GGD', 'Weibull');
% 
% resMSE = transpose(compMdl(mseDat));
% resMSE = [resMSE(:,3), resMSE(:,2), resMSE(:,1), resMSE(:,4)];
% semilogy(resMSE);
% legend('Students t', 'Cauchy', 'GGD', 'Weibull');
% axis square;


%% main process
% 20 images, 1000 watermarks, 9 embed positions, 4 groups of data, 50 thresholds. 
% At every execution we calculate the corresponding test statistics 
% with and without the watermark.

embedScheme = 'MUL';
attackCategory = 'jpeg';
filename = ['result_', embedScheme, attackCategory, '_full.mat'];

result = zeros(wmnum, 2, imgnum, 2, 2);

D = dctmtx(8);
img2dct = @(block_struct) D * block_struct.data * D';
dct2img = @(block_struct) D' * block_struct.data * D;

% compute JND mask
% [JNDmask, Cmask] = DCTmask2(DCTblks);

imgATT0 = attack(imgs, attackCategory);
ATTDCTblks0 = compDCTblks(imgATT0, imgnum);
[JNDmask0, Cmask0] = DCTmask2(ATTDCTblks0);
embed_candidate0 = double(abs(ATTDCTblks0) > JNDmask0);

% params: sitenum X imgnum X modelnum X 2
% if strcmp(attackCategory, 'jpeg') 
%     params0 = getParamsLSE(ATTDCTblks0, lktbl);
% else
%     params0 = getParams(ATTDCTblks0, lktbl);
% end

params0 = getParams_full(ATTDCTblks0, lktbl);

for j = 1:wmnum    
    wm = pnseqs(:, j);  
    
    disp([' watermark: ', num2str(j)]);         
    
    WMblks_dc = makeWM(wm, lktbl(1,:), imgnum);  
    WMblks_ac = makeWM(wm, lktbl(2,:), imgnum); 

    embed_full;
    imgATT1 = attack(imgWM, attackCategory);

    if strcmp(embedScheme, 'ADD')
        detectADD;
    else
        detectMUL_full;
    end 
end
save(filename, 'result');
                    
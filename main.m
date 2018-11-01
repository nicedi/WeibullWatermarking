%% init
dim = 256;
imgnum = 20;     % image number
wmlength = 1024; % watermark length
dimblk = 32;  % block dimension
wmnum = 1000; % watermark number

% load or read image
% load imgs.mat
imgs = zeros(dim, dim, imgnum);
for i = 1:imgnum
    imgFile = ['image',num2str(i),'.bmp'];
    imgs(:,:,i) = imresize(imread(['images/',imgFile]), [dim dim]);
%     imgs(:,:,i) = im2double(imresize(imread(['images/',imgFile]), [256 256]));
end

% load or compute DCT coefficients
% load DCTblks.mat
DCTblks = compDCTblks(imgs, imgnum);

% load or generate watermarks (Pseudo Random Number)
% load pnseqs.mat
shift = round(rand() * wmnum);
pnseqs = genPN(wmlength, shift);


% lookup table
% coordinates of 9 mid-frequency coefficients in the zigzag table.
lktbl = [
    1,4;
    2,3;
    3,2;
    4,1;
    5,1;
    4,2;
    3,3;
    2,4;
    1,5;];
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
attackCategory = 'none';
filename = ['result_', embedScheme, attackCategory, '.mat'];

result = zeros(wmnum, sitenum, imgnum, 9, 2);

D = dctmtx(8);
img2dct = @(block_struct) D * block_struct.data * D';
dct2img = @(block_struct) D' * block_struct.data * D;

% compute mask
% mask = DCTmask(DCTblks);
% maskWbl = compWblMask(DCTblks, mask);

% compute some variables while the watermark does not exist
imgATT0 = attack(imgs, attackCategory);
ATTDCTblks0 = compDCTblks(imgATT0, imgnum);
% maskATT0 = DCTmask(ATTDCTblks0);
% maskWBL0 = compWblMask(ATTDCTblks0, maskATT0);

% params: sitenum X imgnum X modelnum X 2
% if strcmp(attackCategory, 'jpeg') 
%     params0 = getParamsLSE(ATTDCTblks0, lktbl);
% else
%     params0 = getParams(ATTDCTblks0, lktbl);
% end

params0 = getParams(ATTDCTblks0, lktbl);

for j = 1:wmnum    
    wm = pnseqs(:, j);  
    
    for k = 7:9        
        disp([' watermark: ', num2str(j), ' coefficient ', num2str(k)]);         
        co = lktbl(k,:); 
%         co = [1,2];
        WMblks = makeWM(wm, co, imgnum);              
%         tic;       
        embed;
        imgATT1 = attack(imgWM, attackCategory);
        
        if strcmp(embedScheme, 'ADD')
            detectADD;
        else
            detectMUL;
        end              
%         toc;
%         return;
    end
end
save(filename, 'result');
                    
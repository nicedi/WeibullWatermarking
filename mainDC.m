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
%     imgs(:,:,i) = imresize(imread(['images/',imgFile]), [dim dim]);
%     imgs(:,:,i) = im2double(imresize(imread(['images/',imgFile]), [256 256]));
% end

load DCTblks.mat
% DCTblks = compDCTblks(imgs, imgnum);

load pnseqs.mat
% shift = round(rand() * wmnum);
% pnseqs = genPN(wmlength, shift);

% idx = randperm(4096);
% 1:2730, 2731:end (2/3 for parameter estimation, 1/3 for model testing)

%% main process
% 20 images, 1000 watermarks, 9 embed positions, 4 groups of data, 50 thresholds. 
% At every execution we calculate the corresponding test statistics 
% with and without the watermark.

D = dctmtx(8);
img2dct = @(block_struct) D * block_struct.data * D';
dct2img = @(block_struct) D' * block_struct.data * D;

embedScheme = 'DC';
attackCategory = 'jpeg';

imgATT0 = attack(imgs, attackCategory);
ATTDCTblks0 = compDCTblks(imgATT0, imgnum);

co = [1,1]; 
params0 = getParamsDC(ATTDCTblks0, co);

result = zeros(wmnum, imgnum, 3, 2);

for j = 1:wmnum   
    wm = pnseqs(:, j);      
    disp([' watermark: ', num2str(j)]);                      
%   tic;       
    embedDC;
    imgATT1 = attack(imgWM, attackCategory);

    detectDC;             
%   toc;
%   return;

end

filename = ['result_', embedScheme, attackCategory, '4.mat'];
save(filename, 'result');
                    
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

% idx = randperm(4096);
% 1:2730, 2731:end (2/3 for parameter estimation, 1/3 for model testing)

%% main process
% 20 images, 1000 watermarks, 9 embed positions, 4 groups of data, 50 thresholds. 
% At every execution we calculate the corresponding test statistics 
% with and without the watermark.

D = dctmtx(8);
img2dct = @(block_struct) D * block_struct.data * D';
dct2img = @(block_struct) D' * block_struct.data * D;

embedScheme = 'DFT';
fftobj = vision.FFT;
ifftobj = vision.IFFT;

attackCategory = 'jpeg';

imgATT0 = attack(imgs, attackCategory);
coef0 = zeros(size(imgATT0));
for i = 1:imgnum
    coef0(:,:,i) = abs(fftshift(step(fftobj, squeeze(imgATT0(:,:,i)))));
end

% params = getParams(ATTDCTblks0, lktbl);
% params: sitenum X imgnum X modelnum X 2

result = zeros(wmnum, imgnum, 2, 2);

masksize = wmlength;
[mask, mask_symmetry] = compMaskDFT(dim,dim,masksize);

for j = 1:wmnum   
    wm = pnseqs(1:wmlength, j);      
    disp([' watermark: ', num2str(j)]);                      
%   tic;       
    embedDFT;
    imgATT1 = attack(imgWM, attackCategory);

    detectDFT;             
%   toc;
%   return;

end

filename = ['result_', embedScheme, attackCategory, '2.mat'];
save(filename, 'result');
                    
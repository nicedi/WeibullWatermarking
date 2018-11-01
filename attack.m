function imgATT = attack(imgs, attack_category)
dim = 256;
imgnum = size(imgs, 3);
imgATT = zeros(size(imgs));

if strcmp(attack_category, 'none')
    imgATT = imgs;
end

%% median filter default: 3x3
if strcmp(attack_category, 'medfilt')
    for i = 1:imgnum
        imgATT(:,:,i) = medfilt2(imgs(:,:,i), [3 3]);
    end
end

%% histogram equalization
if strcmp(attack_category, 'histequ')
    for i = 1:imgnum
        imgATT(:,:,i) = histeq(im2uint8(imgs(:,:,i)));
    end
end


%% blurring
if strcmp(attack_category, 'blur')
%     gsigma=1; 
    kernel = fspecial('gaussian');% default: sigma = 0.5
    for i = 1:imgnum
        imgATT(:,:,i) = imfilter(imgs(:,:,i), kernel);
    end
end



%% gaussian noise
if strcmp(attack_category, 'noise')
    noise_std=0.01;
    for i = 1:imgnum
        imgATT(:,:,i) = imnoise(imgs(:,:,i), 'gaussian', 0, noise_std);
    end
end

    %% salt & pepper noise
    % noise_density=0.05;
    % imgATT=imnoise(imgWM,'salt & pepper',noise_density);

%% scaling
if strcmp(attack_category, 'scale')
    scalfac = 0.5;
    imgATT = zeros(size(imgs));
    for i = 1:imgnum
        img = imgs(:,:,i);
        imgscale = imresize(img,scalfac);
        imgATT(:,:,i) = imresize(imgscale,[dim dim]);
    end
end


%% jpeg compression - Windows version
if strcmp(attack_category, 'jpeg')
    quality = 50;
    for i = 1:imgnum
    %     imwrite(imgs(:,:,i), 'temp\temp.bmp');
    %     cjpegcmd = ['cjpeg -quality ', num2str(quality), ' -grayscale temp\temp.bmp temp\outc.jpg'];
    %     [status1, output1] = system(cjpegcmd);
    %     imgs(:,:,i) = imread('temp\outc.jpg');   
        imwrite(uint8(abs(imgs(:,:,i))), 'temp/temp.jpg', 'jpg', 'Quality', quality);
        imgATT(:,:,i) = imread('temp/temp.jpg');
    end
end

end

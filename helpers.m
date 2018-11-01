%% draw DC APD
coef = coef0(:,19);
hist(coef,200)
n = linspace(300, 1600, 100);
apd0 = APD(coef, n);
apd1 = weibullAPD(coef, n);
plot(n,[apd0;apd1]);

%% compute T matrix
% view from a distance of 64 pixel/degree.
wx = 1/32;% horizontal width of a pixel in degrees of visual angle
wy = 1/32;
N = 8;
F = @(x, w) x / 2 / N / w;
T = zeros(8,1);
for i = 0:7
    T(i+1) = F(i, wx);
end
T

%% DC coefficients detection
co = [1, 1];
WMblks = makeWM(ones(wmlength,1), co, imgnum);
dccoef = reshape(DCTblks(WMblks ~= 0), [wmlength imgnum]);
data = dccoef(:,19); % baboon
[binc, bine] = normHist(data, 100);
[a, ro] = mle_wbl(data);
x = linspace(min(data),max(data),100);
y = weibullPDF(x, a, ro);
bar(binc, bine);
hold on;
plot(x, y, 'k');


%% parameter estimation
opts = optimset('Display','off','FunValCheck','off','MaxIter',400,...
        'MaxFunEvals',800,'TolFun',1e-4,'TolX',1e-4);
ggdParam = mle(coef, 'pdf', @ggdPDF, 'start', [1, 1], 'optimfun', 'fmincon', ...
    'lowerbound', [1e-4,1e-4], 'options', opts);


%% ggd log-likelihood
[alpha, beta] = mle_ggd(testdata);
ggd_ll = @(data, alpha, beta) sum(log(beta)-log(2*alpha*gamma(1/beta))-(abs(data)/alpha).^beta);

[X, Y] = meshgrid(logspace(-4,1,50), logspace(-2,1,50));

[r, c] = size(X);
Z = zeros(r, c);

for i=1:r
    for j=1:c
        Z(i,j) = ggd_ll(testdata, X(i,j), Y(i,j));
        if Z(i,j)<=0
            Z(i,j)=eps;
        end
    end
end
surf(X,Y,Z);
[C, h]=contour(X,Y,Z,20);


%% cauchy log-likelihood
[ gamma, delta ] = mle_cauchy(testdata);
cauchy_ll = @(data, gamma, delta) sum(log(gamma)-log(gamma^2+(x-delta).^2));

[X, Y] = meshgrid(logspace(-4,1,50), logspace(-1,2,50));

[r, c] = size(X);
Z = zeros(r, c);

for i=1:r
    for j=1:c
        Z(i,j) = cauchy_ll(testdata, X(i,j), Y(i,j));
        if Z(i,j)<=0
            Z(i,j)=eps;
        end
    end
end
surf(X,Y,Z);
[C, h]=contour(X,Y,Z,20);


%% student-t log-likelihood
[lambda, nu] = stuParamEst(testdata);
stu_ll = @(data, lambda, nu) sum(log(gamma((nu+1)/2)) - log(gamma(nu/2)) + 0.5*log(lambda/nu/pi) - ...
    (nu+1)*log(1+lambda*(data.^2)/nu)/2);

[X, Y] = meshgrid(logspace(-1,5,50), logspace(-1,2,50));

[r, c] = size(X);
Z = zeros(r, c);

for i=1:r
    for j=1:c
        Z(i,j) = stu_ll(testdata, X(i,j), Y(i,j));
        if Z(i,j)<=0
            Z(i,j)=eps;
        end
    end
end
surf(X,Y,Z);

[C, h]=contour(X,Y,Z,20);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*4)

%% weibull log-likelihood
dat = abs(testdata);
[alpha, ro] = mle_wbl(dat);
wei_ll = @(data, ro, alpha) sum(log(ro) - log(alpha) + (ro-1)*log(data/alpha) - (data/alpha).^ro);

[X, Y] = meshgrid(logspace(-2,2,50), logspace(-2,2,50));

[r, c] = size(X);
Z = zeros(r, c);

for i=1:r
    for j=1:c
        Z(i,j) = wei_ll(dat, X(i,j), Y(i,j));
        if Z(i,j)<=0
            Z(i,j)=eps;
        end
    end
end
% Warning: Axis limits outside float precision, use ZBuffer or Painters instead. Not rendering.
% solve above warning Try setting the figure renderer property to zbuffer or painters
% set(gcf,'renderer','painters');
% or 
set(gcf,'renderer','zbuffer');
surf(X,Y,Z);
figure;
[C, h]=contour(X,Y,Z,20);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)


%% debug detection
% ggd
temp1 = zeros(trials,1);
for iter = 1:trials
    temp1(iter) = detector_ggd_ump(alpha1, beta1, coef1(:,p), pnseqs(:,iter), wmstrength);
end
plot(temp1,'r');
hold;
temp0 = zeros(trials,1);
for iter = 1:trials
    temp0(iter) = detector_ggd_ump(alpha0, beta0, coef0(:,p), pnseqs(:,iter), wmstrength);
end
plot(temp0,'b');

% cauchy
temp1 = zeros(1000,1);
for iter = 1:1000
    temp1(iter) = detector_cauchy(gamma1, delta1, coef1(:,p), pnseqs(:,iter));
end
plot(temp1,'r');
hold;
temp0 = zeros(1000,1);
for iter = 1:1000
    temp0(iter) = detector_cauchy(gamma0, delta0, coef0(:,p), pnseqs(:,iter));
end
plot(temp0,'b');

% stu
temp1 = zeros(1000,1);
for iter = 1:1000
    temp1(iter) = detector_stu(lambda1, nu1, coef1(:,p), pnseqs(:,iter));
end
plot(temp1,'r');
hold;
temp0 = zeros(1000,1);
for iter = 1:1000
    temp0(iter) = detector_stu(lambda0, nu0, coef0(:,p), pnseqs(:,iter));
end
plot(temp0,'b');

% wbl
figure;
temp0 = zeros(1000,1);
for q = 1:1000
%     temp0(q) = detector_wbl_ump(a0, ro0, abs(coef0(:,p)), pnseqs(:,q), 0.2);
    temp0(q) = detector_wbl_lod(a0, ro0, abs(coef0(:,p)), pnseqs(:,q));
%     temp0(q) = detector_wbl_nonlinear(a0, ro0, abs(coef0(:,p))+eps, pnseqs(:,q));
end
plot(temp0,'b');
hold;
temp1 = zeros(1000,1);
for q = 1:1000
%     temp1(q) = detector_wbl_ump(a1, ro1, abs(coef1(:,p)), pnseqs(:,q), 0.2);
    temp1(q) = detector_wbl_lod(a1, ro1, abs(coef1(:,p)), pnseqs(:,q));
%     temp1(q) = detector_wbl_nonlinear(a1, ro1, abs(coef1(:,p))+eps, pnseqs(:,q));
end
plot(temp1,'r');


%% plot detection result
for i = 6:7
    site = 9; image = 8; model = i;
    pos = squeeze(result(1:20, site, image, model, 1));
    neg = squeeze(result(1:20, site, image, model, 2));
    figure;
    plot(pos, 'r'); hold; plot(neg, 'b');
end

%% preparing the chart
mul_scale = zeros(9,8);
% cut and paste data in the variable panel.
colormap gray;
legend('Weibull UMP','Weibull LOD','GGD UMP','GGD LOD','Cauchy UMP','Cauchy LOD','t UMP','t LOD');

%% DC experiment. PSNR SSIM
psnr_result = zeros(imgnum, 1);
for i = 1:imgnum
    psnr_result(i) = psnr(imgs(:,:,i), imgWM(:,:,i));
end
mean(psnr_result)

%% block classification
blk = @(block_struct) std2(block_struct.data);
map = zeros(32,32,imgnum);
for i = 1:imgnum
    map(:,:,i) = blockproc(uint8(imgs(:,:,i)), [8 8], blk, 'UseParallel', true);
end

imshow(imgWM(:,:,8), []);

w0 = result(1:100, 18, 3, 2);
w1 = result(1:100, 18, 3, 1);
[x,y,t,auc] = perfcurve([ones(100,1); zeros(100,1)], [w1; w0], 1);
auc

load imgs
for i=1:20
    a = uint8(abs(imresize(imgs(:,:,i), [64 64])));
    file = ['thumb\img',num2str(i),'.png'];
    imwrite(a,file,'png');
end
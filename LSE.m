coef = coef0(:,8);
[xdata, ydata] = normHist(coef, 50);
idx = ydata==0;
xdata(idx) = [];
ydata(idx) = [];
% cauchy model
% Pure MATLAB solution (No toolboxes)
fun = @(p) sum((ydata - p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2)).^2);
pguess = [1,0];
[p,fminres] = fminsearch(fun,pguess);
% plot
figure;
bar(xdata, ydata, 'b');hold on;
x = linspace(-100, 100, 100);
y = cauchyPDF(x, p(1), p(2));
plot(x,y,'r');


% MATLAB with optimisation toolbox
fun = @(p,xdata) p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2);
pguess = [1,0];
[p,fminres] = lsqcurvefit(fun,pguess,xdata,ydata);

% plot
figure;
bar(xdata, ydata, 'b');hold on;
x = linspace(-100, 100, 100);
y = cauchyPDF(x, p(1), p(2));
plot(x,y,'r');

% MATLAB with statistics toolbox
fun = @(p,xdata) p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2);
pguess = [1,0];
mdl = NonLinearModel.fit(xdata,ydata,fun,pguess);
% The returned object is a NonLinearModel object
% If you don¡¯t need such heavyweight infrastructure, you can make use of the statistic toolbox¡¯s nlinfit function
[p,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(xdata,ydata,fun,pguess);

% supplimentation
fun = @(p) ydata - p(1) / pi ./ ((xdata-p(2)).^2 + p(1)^2);
opts = optimset('Algorithm','levenberg-marquardt', 'Display','iter');
[p,~,res,~,info] = lsqnonlin(fun, pguess, [], [], opts);
fminres = sum(res.^2);
function [alpha, beta, msg] = ggd_song(x, theta0)
%
%[theta, sigma] = ggd_fit(x, theta0);
%
% estimate the shape and scale parameters of GGD
% based on song2006
% initial theta with theta0
msg = '';
% number of sample points
% x = x(find(abs(x)>0.0000001));
n = length(x);

% estimate the shape parameter
theta = theta0;
iter = 1;
T0 = theta0;
while (1)
    Y1 = mean(abs(x).^theta);
    Y2 = mean(abs(x).^(2*theta));
    Z = Y2 / Y1 / Y1 - (theta+1);
    U1 = mean(abs(x).^theta.*log(abs(x)));
    U2 = mean(abs(x).^(2*theta).*log(abs(x)));
    Z_dot = 2*U2/Y1/Y1 - 2*U1*Y2/Y1/Y1/Y1 - 1;
    theta = theta - Z/Z_dot;    
    T1 = theta;
    if abs(T0 - T1) < 10e-5 
        break; 
    else
        T0 = T1;
    end
    
    iter = iter + 1;
    if iter > 400
        msg = 'max iteration exceeded.';
        break;
    end
%     disp(iter);
end

% estimate the scale parameter
sigma = ((theta/n) * sum(abs(x).^theta)) .^ (1/theta);

beta = theta;
alpha = sigma / (gamma(3/b)/gamma(1/b))^0.5;


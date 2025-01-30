close all;
clear;

fs = 100e6;
fc = 5e6;
N = 730;
t = 0:1/fs:N/fs-1/fs;
phi = 5.655;
f_off = 0;
tx = cos(2*pi*(fc+f_off)*t+phi);


%% LPF
theta1 = zeros(1,N);
theta2 = zeros(1,N);
mu1 = 1/32;
mu2 = 0.01;

for k = 1:N
    cl_cos(k) = cos(2*pi*fc*t(k)+.314);
    cl_sin(k) = sin(2*pi*fc*t(k)+.314);
    f1in = tx(k)*cl_cos(k);
    f2in = tx(k)*cl_sin(k);
    %     f3in = tx(k)*2*cos(2*pi*fc*t(k)+theta1(k)+theta2(k));
    %     f4in = tx(k)*2*sin(2*pi*fc*t(k)+theta1(k)+theta2(k));

    error1(k) = (f1in)*(f2in)*mu1;
    %     error2 = (fliplr(h)*f3p')*(fliplr(h)*f4p');

    theta1(k+1) = theta1(k) + error1(k);
    %     theta2(k+1) = theta2(k) - mu2 * error2;

    car_est(k) = cos(2*pi*fc*t(k)+theta1(k));
end
figure(1)
plot(theta1)
title('freq')
% subplot(2,1,2)
% plot(theta2)
% title('phase')

% figure(2)
% subplot(2,1,1)
% plot(car_est)
% hold on
% plot(tx);
% hold off
% title('estimated carrier and carrier')
% subplot(2,1,2)
% plot((car_est-tx).^2)
% title('error between estimated carrier and carrier')



fid=fopen('error.txt');
f=textscan(fid,'%s', 'delimiter','\n');
fclose(fid);
tx = cell2mat(f{:});
tx(1,:) = [];

[nRow, nCol] = size(tx);
tx_num = zeros(nRow,nCol);
for ii = 1:nRow
    for jj = 1:nCol
        if tx(ii,jj) == '0'
            tx_num(ii,jj) = 0;
        else
            tx_num(ii,jj) = 1;
        end
    end
end

tx_dec = zeros(nRow, 1);

for ii = 1:length(tx_dec)
        tx_dec(ii) = posconvert(tx_num(ii,1:end));
end

function y = posconvert(x)
cum = 0;
x = fliplr(x);
for ii = 1:28
    cum = cum + x(ii)*2^(ii-28); % offsetnumber should be num bits - num int bits
end
y = cum;
end

function y = negconvert(x)
%First we get out of 2's complement then we convert as regular
xpos = zeros(1,length(x));
%flip the bits
for ii = 1:length(x)
    if x(ii) == 0
        xpos(ii) = 1;
    else
        xpos(ii) = 0;
    end
end
%add one
xpos = add1bin(xpos);
y = -posconvert(xpos);
end

function y = add1bin(x)
carryout = 1;
for ii = length(x):-1:1
    if x(ii) == 1 && carryout == 1
        carryout = 1;
        x(ii) = 0;
    elseif x(ii) == 0 && carryout == 1
        carryout = 0;
        x(ii) = 1;
    elseif x(ii) == 1 && carryout == 0
        carryout = 0;
        x(ii) = 1;
    else
        carryout = 0;
        x(ii) = 0;
    end
end
y = x;
end
%%Author: Mark Blair
%Simulated datapath of VHDL transmitter, also takes data from VHDL
%transmitter and adds noise and channel distortion

fs = 500e6;
fc = 100e6;
sps = 6;
%% Import Data, modulate, upsample, pulse shape
bits = importdata("bitstream.txt");
[syms_I, syms_Q] = qam4(bits);
syms_I = upsample(syms_I,sps);
syms_Q = upsample(syms_Q,sps);
nyq_fil = rcosdesign(0.4,8,sps,"sqrt");
syms_p_I = filter(nyq_fil,1,syms_I);
syms_p_Q = filter(nyq_fil,1,syms_Q);
%% Carrier Generation
t = 0:1/fs:length(syms_p_Q)*1/fs-1/fs;
cos_carrier = cos(2*pi*fc*t);
sin_carrier = sin(2*pi*fc*t);

tx = cos_carrier.*syms_p_I+sin_carrier.*syms_p_Q;

fbin = 1024;
w = -fs/2:fs/fbin:fs/2-fs/fbin;
figure(1)
plot(w,abs(fftshift(fft(tx_dec,fbin))))
hold on
plot(w,abs(fftshift(fft(tx,fbin))))
title('Spectral Comparison of simulated vs. hdl')
hold off

tx(1:2) = [];
tx_dec = tx_dec(1:length(tx));
figure(2)
plot(tx'-tx_dec)
title('difference between matlab and vhdl')

% There is a lot of quantization noise, I could help with that by truncating less LSB, there could be more fractional bits too. Will just accept that there is some quantization noise.
%% Channel Effects
%symbol power is 2 b/c QAM4 with symbols mapped to +/- 1 +/- 1j, bit power
%is 1
bit_pow = 1;
SNRdb = 20;
noise_pow = bit_pow/(10^(SNRdb/10));
chan = [0.05 .7 0.1 .02 .1 .09];
rx = tx_dec+sqrt(noise_pow)*randn(length(tx_dec),1);
rx = filter(chan,1,rx);

function [syms_I, syms_Q] = qam4(x)
syms_I = zeros(1,length(x)/2);
syms_Q = zeros(1,length(x)/2);
x_I = x(1:2:end);
x_Q = x(2:2:end);
for ii = 1:length(x)/2
    if x_Q(ii) == 1
        syms_Q(ii) = -1;
    else
        syms_Q(ii) = 1;
    end
    if x_I(ii) == 1
        syms_I(ii) = -1;
    else
        syms_I(ii) = 1;
    end
end
end
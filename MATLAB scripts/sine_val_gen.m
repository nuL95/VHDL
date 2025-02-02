%Author: Mark Blair
%Date: 1/15/2025
%Generate values for a sine wave, 32 samples, 8 bits per sample
numSamples = 32;
t = 0:1/numSamples:1-1/numSamples;
x = sin(2*pi*t);
x_scaled = round(x*(2^7 - 1));
x_bin = dec2bin(x_scaled);

plot(abs(fftshift(fft(x))))
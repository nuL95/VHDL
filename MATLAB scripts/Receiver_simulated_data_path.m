%%Author: Mark Blair
%This is the simulation of the datapath of the receiver, it should roughly
%match up with the vhdl simulation, minus some quantization noise.

clear;
%
rx = importdata("rx.mat");
mu = 1/16;
ref = 1/16;
L = 9;
a = zeros(1,length(rx));a(1) = 1;
f_regs = zeros(1,L)
for ii = 1:length(rx)
    s(ii) = a(ii)*rx(ii);
    f_in = f_regs(1)+s(ii).^2;
    f_regs = [f_in f_regs(1:end-1)];
    cic_out = (f_regs(1)-f_regs(end))/(L-1);
    err(ii) = mu*(ref-cic_out);
    a(ii+1) = a(ii) + err(ii);
end

plot(s)

%%Author: Mark Blair
%This is the simulation of the datapath of the receiver, it should roughly
%match up with the vhdl simulation, minus some quantization noise.

clear;
%
rx = importdata("rx.mat");
mu = 1/16;
ref = 1/16;
a = zeros(1,length(rx));a(1) = 1;
for ii = 1:length(rx)
    s(ii) = a(ii)*rx(ii);
    err(ii) = mu*(ref-s(ii).^2);
    a(ii+1) = a(ii) + err(ii);
end

plot(s)
% a = zeros(1,length(rx));a(1) = 1;
% zz = sqrt(.2)*randn(1,length(rx));
%
% mu = 1/16;
% ref = .0625;
% for ii = 1:length(rx)
%     s(ii) = a(ii)*rx(ii);
%     a(ii+1) = a(ii) + mu*(sign(a(ii)))*(ref-rx(ii).^2);
% end
%
% plot(s)
% n=50000; % # steps in simulation
% r=randn(n,1); % generate random inputs
% env=0.75+abs(sin(2*pi*[1:n]'/n)); % the fading pro file
% r=r.*env ; % apply to raw input r [ k ]
% ds=0.125; % desired power of output
% r = rx;
% a=zeros (1 ,n); a(1)=1; % i n i t i a l i z e AGC par ameter
% s=zeros (1 ,n); % initialize outputs
% mu= 0.0625; % algorithm stepsize
% for k=1:length(r)-1
% s(k)=a(k)* r(k); % normalize by a to get s
% a(k+1)=a(k)-mu*(s(k)^2- ds ); % adaptive update of a(k)
% end
%
% subplot(2,1,1)
% plot(a(1:length(rx)))
% subplot(2,1,2)
% plot(s(1:length(rx)))

y = fi(0.6, 1, 16, 13);
y.bin

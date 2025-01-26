%%Author: Mark Blair
%Takes the data from transmitted_simulated_data_path and puts it into
%signed fixed binary 16 bits with binary point of 13
clear;
close;
rx = importdata("rx.mat");

rx_bin = fi(rx, 1, 16, 13);

y = rx_bin.bin

file = fopen("rx_bin.txt",'w');
for ii = 1:length(rx)
fprintf(file, "%s \n", y(ii,:));
end
fclose(file);
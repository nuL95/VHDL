%%Author: Mark Blair
%Takes output from VHDL Transmitter which is signed fixed binary 32 bit with a
%binary point of 20 and puts it into decimal form

fid=fopen('tx_dat_v2.txt');
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
    if tx_num(ii,1) == 0
        tx_dec(ii) = posconvert(tx_num(ii,2:end));
    else
        tx_dec(ii) = negconvert(tx_num(ii,2:end));
    end
end

plot(tx_dec)

function y = posconvert(x)
cum = 0;
x = fliplr(x);
for ii = 1:31
    cum = cum + x(ii)*2^(ii-21);
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


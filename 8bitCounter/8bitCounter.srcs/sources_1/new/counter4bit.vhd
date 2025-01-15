----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/12/2025 10:47:35 AM
-- Design Name: 4 bit counter
-- Module Name: counter4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_bit.all;

entity counter4bit is
Port (ldn,clrn,p, t, clk : in bit;D: in unsigned(3 downto 0);Cout: out bit;Qout: out unsigned(3 downto 0 ));
end counter4bit;

architecture Behavioral of counter4bit is
signal Q: unsigned (3 downto 0);
begin
Qout <= Q;
Cout <= Q(3) and Q(2) and Q(1) and Q(0) and t;
process(clk)
begin
if clk'event and clk = '1' then
if clrn = '0' then Q<= "0000";
elsif ldn = '0' then Q<=D;
elsif (p and t) = '1' then Q<=Q+1;
end if;
end if;
end process;
end Behavioral;


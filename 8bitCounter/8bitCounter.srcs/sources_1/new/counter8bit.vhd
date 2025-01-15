----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/12/2025 11:37:34 AM
-- Design Name: 
-- Module Name: counter8bit - Behavioral
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

entity counter8bit is
port (clrn, ldn, p, t1, clk: in bit; Din1, Din2: in unsigned (3 downto 0);carry2: out bit; count: out integer range 0 to 255);
end counter8bit;

architecture Behavioral of counter8bit is
signal Q: unsigned (7 downto 0);
signal carry1: bit;
component counter4bit
Port (ldn,clrn,p, t, clk : in bit;D: in unsigned(3 downto 0);Cout: out bit;Qout: out unsigned(3 downto 0 ));
end component;
begin
counter1: counter4bit port map(ldn, clrn,p,t1,clk,Din1,carry1,Q(3 downto 0));
counter2: counter4bit port map(ldn,clrn,p,carry1,clk,Din2,carry2,Q(7 downto 4));
count <= to_integer(Q);

end Behavioral;

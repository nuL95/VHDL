----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/12/2025 11:10:29 AM
-- Design Name: counter test bench
-- Module Name: counter_tb - Behavioral
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

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
signal Din1: unsigned (3 downto 0) := "0000";
signal Din2: unsigned (3 downto 0) := "0000";
signal count: integer range 0 to 255;
signal clrn,ldn,p, t1, carry2: bit := '0';
signal clk: bit := '0';
component counter8bit
port (clrn, ldn, p, t1, clk: in bit; Din1, Din2: in unsigned (3 downto 0);carry2: out bit; count: out integer range 0 to 255);
end component;
begin
Counter: counter8bit port map (clrn,ldn,p,t1,clk,Din1,Din2, carry2,count) ;
Clock : process (clk)
begin
clk <= not clk after 1ns;
clk <= not clk after 1ns;
end process;

TB: process
begin
p<='1';
t1 <= '1';
clrn<= '1';
ldn<='1';
wait for 1000 ns;

end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/10/2025 03:01:16 PM
-- Design Name: 
-- Module Name: Behav_Sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Test bench for 4 bit adder
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

entity Behav_Sim is
end Behav_Sim;

architecture Behavioral of Behav_Sim is
component bit4adder
Port (A, B: in std_logic_vector(3 downto 0); Cin: in std_logic; S: out std_logic_vector(3 downto 0); Cout: out std_logic);
end component;
--
signal A, B: std_logic_vector(3 downto 0);
signal Cin: std_logic;
signal S: std_logic_vector(3 downto 0);
signal Cout: std_logic;
--

begin
A4B: bit4adder port map(A,B,Cin,S,Cout);

tb: process
begin
A<="0000";
B<="0000";
Cin<='0';
wait for 10 ns;
A<="0001";
B<="0010";
wait for 10 ns;
A<="0110";
B<="1100";
wait for 500 ns;
end process;
end Behavioral;

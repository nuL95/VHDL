----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 11:25:01 AM
-- Design Name: oscilator testbench
-- Module Name: osc_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: testbench for the oscillator, go through a few cycles.
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
use IEEE.NUMERIC_STD.ALL;



entity osc_tb is
end osc_tb;

architecture Behavioral of osc_tb is
signal clk: std_logic := '0';
signal rst: std_logic := '0';
signal en: std_logic := '0';
signal osci_out: signed (7 downto 0);
component osci
Port (clk, rst, en: in std_logic; osci_out: out signed (7 downto 0));
end component;
begin
oscillator: osci port map(clk => clk, rst => rst, en =>en, osci_out => osci_out);
dut_clk: process(clk)
begin
clk <= not clk after 2 ns;
end process;
dut: process
begin
rst <= '1';
wait for 400 ns;
end process;
end Behavioral;

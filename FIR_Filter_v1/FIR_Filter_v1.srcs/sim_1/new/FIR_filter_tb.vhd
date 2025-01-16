----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/16/2025 01:15:45 PM
-- Design Name: 
-- Module Name: FIR_filter_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: testbench for FIR_filter
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

entity FIR_filter_tb is
end FIR_filter_tb;

architecture Behavioral of FIR_filter_tb is
signal clk,en: std_logic := '0';
type data_bank is array (7 downto 0) of signed (7 downto 0);
signal dat: data_bank := ("00000010","00000001","00000000","00000100","00001001","00000111","00000100","00000001");
signal filt_in: signed (7 downto 0) := "00000000";
signal filt_out: signed (9 downto 0);
component FIR_filter
Port (clk, en: in std_logic; dat_in: in signed (7 downto 0); dat_out: out signed(9 downto 0 ));
end component;
begin
fir_dut: FIR_filter port map(clk => clk, en => en, dat_in => filt_in, dat_out => filt_out);
testing: process
begin
wait for 2 ns;
en <= '1';
for n in 0 to 7 loop
filt_in <= dat(n);
wait for 10 ns;
end loop;
filt_in <= "00000000";
wait for 900 ns;
end process;
clocking: process(clk)
begin
clk <= not clk after 5 ns;
end process;
end Behavioral;

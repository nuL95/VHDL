----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 03:32:32 PM
-- Design Name: 
-- Module Name: shiftReg_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity shiftReg_tb is
end shiftReg_tb;

architecture Behavioral of shiftReg_tb is
component shiftReg 
generic (sr_size: integer range 1 to 31; sr_depth: integer range 1 to 32);
Port (en, clk: in std_logic; dat_in: in std_logic_vector (sr_depth-1 downto 0);dat_out: out std_logic_vector (sr_depth-1 downto 0));
end component;
signal en: std_logic := '0';
signal clk: std_logic := '0';
signal dat_in: std_logic_vector (7 downto 0) := "00000000";
signal dat_out: std_logic_vector (7 downto 0);
type tb_data_array is array (3 downto 0) of std_logic_vector (7 downto 0);
signal tb_data_block: tb_data_array := ("00000000", "00000001", "10000000", "10101010");
begin
sr_dut: shiftReg generic map(sr_size => 5, sr_depth => 8) port map (clk =>clk, en=> en, dat_in => dat_in, dat_out => dat_out);
process begin
wait for 2 ns;
for n in 0 to 3 loop
dat_in <= tb_data_block(n);
wait for 10 ns;
end loop;
wait for 500 ns;
end process;
process(clk)
begin
clk <= not clk after 5 ns;
end process;
end Behavioral;

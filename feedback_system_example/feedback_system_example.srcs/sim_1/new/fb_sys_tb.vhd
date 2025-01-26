----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2025 09:46:36 AM
-- Design Name: 
-- Module Name: fb_sys_tb - Behavioral
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


entity fb_sys_tb is
end fb_sys_tb;

architecture Behavioral of fb_sys_tb is
signal x: std_logic_vector(15 downto 0);
signal y: std_logic_vector (15 downto 0);
signal clk, rst: std_logic := '0';

component fb_sys
    Port (reset, clk: in std_logic; system_input: in std_logic_vector (15 downto 0);system_output: out std_logic_vector(15 downto 0) );
end component;
begin
fb_sys_dut: fb_sys port map (reset => rst, clk => clk, system_input => x, system_output => y);

test: process
begin
rst <= '1';
wait for 10 ns;
rst <= '0';
x <= "0010000000000000";
wait for 500 ns;


end process;


clocking: process (clk)
begin
clk <= not clk after 5 ns;
end process;
end Behavioral;

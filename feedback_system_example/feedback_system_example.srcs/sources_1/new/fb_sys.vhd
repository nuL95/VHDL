----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2025 09:38:25 AM
-- Design Name: 
-- Module Name: fb_sys - Behavioral
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


entity fb_sys is
    Port (reset, clk: in std_logic; system_input: in std_logic_vector (15 downto 0);system_output: out std_logic_vector(15 downto 0) );
end fb_sys;

architecture Behavioral of fb_sys is
    constant gain: signed (15 downto 0):= "0001001100110011";
    signal system_output_int: std_logic_vector (15 downto 0);
begin
    system_output <= system_output_int;
    process (clk ,reset)
    variable loop_multi: signed (31 downto 0);
    variable LM_adjusted: signed (15 downto 0);
    begin
        if reset = '1' then
            system_output_int <= (others => '0');
        elsif rising_edge(clk) then
            loop_multi := gain*signed(system_output_int);
            LM_adjusted := loop_multi(31) & loop_multi(27 downto 26) & loop_multi(25 downto 13);
            system_output_int <= std_logic_vector(signed(system_input) - LM_adjusted);
        end if;
    end process;
end Behavioral;

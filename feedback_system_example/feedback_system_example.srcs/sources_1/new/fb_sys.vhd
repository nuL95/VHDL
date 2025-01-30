----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/26/2025 09:38:25 AM
-- Design Name: 
-- Module Name: fb_sys - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Implementation of CIC filter.
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
    Port (reset, clk: in std_logic; system_input: in std_logic_vector (31 downto 0);system_output: out std_logic_vector(31 downto 0) );
end fb_sys;

architecture Behavioral of fb_sys is
    type f_regs_type is array (8 downto 0) of signed(31 downto 0);
    signal f_regs: f_regs_type;
    signal cic_out: signed (31 downto 0);
begin
    system_output <=std_logic_vector(cic_out/8);
    process (clk ,reset)

    begin
        if reset = '1' then
            f_regs <= (others =>(others => '0'));
        elsif rising_edge(clk) then
            f_regs <= f_regs(f_regs'high-1 downto 0) & (f_regs(0) + signed(system_input));
            cic_out <= f_regs(0) - f_regs(f_regs'high);

        end if;
    end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 02:32:11 PM
-- Design Name: 
-- Module Name: shiftReg - Behavioral
-- Project Name: Shift Register Design
-- Target Devices: 
-- Tool Versions: 
-- Description: Design of a modular shift register
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


entity shiftReg is
generic (sr_size: integer range 1 to 31; sr_depth: integer range 1 to 32);
Port (en, clk: in std_logic; dat_in: in std_logic_vector (sr_depth-1 downto 0);dat_out: out std_logic_vector (sr_depth-1 downto 0));
end shiftReg;

architecture Behavioral of shiftReg is
type shift_reg_mem is array (sr_size-1 downto 0) of std_logic_vector (sr_depth-1 downto 0);
signal shift_reg: shift_reg_mem := (others=>(others=>'0'));
begin
dat_out <= shift_reg(shift_reg'high);
    process(clk)
    begin
        if rising_edge(clk) then
            if en = '0' then
               shift_reg <= shift_reg(sr_size-2 downto 0) & dat_in;
            end if;
        end if;
    end process;
end Behavioral;

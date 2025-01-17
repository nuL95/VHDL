----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/16/2025 12:54:25 PM
-- Design Name: 
-- Module Name: FIR_filter - Behavioral
-- Project Name: FIR Filter
-- Target Devices: 
-- Tool Versions: 
-- Description: First attempt at making an FIR filter module
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


entity FIR_filter is
Port (clk, en: in std_logic; dat_in: in signed (7 downto 0); dat_out: out signed(9 downto 0 ));
end FIR_filter;

architecture Behavioral of FIR_filter is
type f_tap_mem is array (3 downto 0) of signed (7 downto 0);
constant filter_taps: f_tap_mem := ("00000101","00000001","11101001","00001001");
type f_reg is array (3 downto 0) of signed (7 downto 0);
signal filter_regs: f_reg := (others=>(others=>'0'));
signal MAC: signed( 15 downto 0) := (others=> '0');
begin
dat_out <= MAC(9 downto 0);
shift_reg: process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                filter_regs <= filter_regs(2 downto 0) & dat_in;
            end if;
        end if;
    end process;
MAC_op: process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                MAC <= filter_taps(0)*filter_regs(0)+filter_taps(1)*filter_regs(1)+filter_taps(2)*filter_regs(2)+filter_taps(3)*filter_regs(3);
            end if;
        end if;
    end process;
end Behavioral;

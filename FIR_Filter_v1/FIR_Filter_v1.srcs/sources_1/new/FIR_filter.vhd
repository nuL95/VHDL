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
-- Description: Attempt at making an FIR filter module using transpose topology.
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
type output_registers is array (3 downto 0) of signed (15 downto 0);
signal out_regs: output_registers := (others=>(others=>'0'));
type m_regs is array (3 downto 0) of signed( 15 downto 0);
signal mult_regs: m_regs := (others=>(others=>'0'));
begin
dat_out <= out_regs(0)(9 downto 0);
MAC_op: process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                for n in 0 to 2 loop
                    filter_regs(n) <= dat_in;
                    mult_regs(n) <= filter_taps(n)*filter_regs(n);
                    out_regs(n) <= mult_regs(n)+out_regs(n+1);
                end loop;
                out_regs(out_regs'high) <= mult_regs(out_regs'high);
            end if;
        end if;
    end process;
end Behavioral;

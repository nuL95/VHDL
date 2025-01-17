----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 03:50:13 PM
-- Design Name: 
-- Module Name: silly - Behavioral
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
entity silly is
    Port (clk: in std_logic;a, b, c, d: out std_logic);
end silly;

architecture Behavioral of silly is
    signal xtest: std_logic := '0';
begin
    process(clk)
    variable ztest: std_logic := '0';
    begin
        if rising_edge(clk) then
            a <= ztest;
            ztest := '1';
            b <= ztest;
            ztest := '0';
            c <= ztest;
        end if;
    end process;
end Behavioral;

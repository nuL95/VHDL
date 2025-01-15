----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 11:05:05 AM
-- Design Name: oscillator
-- Module Name: osci - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity osci is
Port (clk, rst, en: in std_logic; osci_out: out signed (7 downto 0));
end osci;

architecture Behavioral of osci is
signal memAdd: unsigned (4 downto 0) := "00000";
type sinMem is array(31 downto 0) of signed (7 downto 0);
constant sinLUT: sinMem :=(
    "00000000",
    "00011001",
    "00110001",
    "01000111",
    "01011010",
    "01101010",
    "01110101",
    "01111101",
    "01111111",
    "01111101",
    "01110101",
    "01101010",
    "01011010",
    "01000111",
    "00110001",
    "00011001",
    "00000000",
    "11100111",
    "11001111",
    "10111001",
    "10100110",
    "10010110",
    "10001011",
    "10000011",
    "10000001",
    "10000011",
    "10001011",
    "10010110",
    "10100110",
    "10111001",
    "11001111",
    "11100111");
begin
osci_out <= sinLUT(to_integer(memAdd));
process(clk)
begin
if rising_edge(clk) then
if rst = '0' then memAdd <= (others=> '0');
elsif en = '0' then
memAdd <= memAdd + 1;
end if;
end if;
end process;
end Behavioral;

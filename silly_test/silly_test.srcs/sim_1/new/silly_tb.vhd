----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2025 03:50:27 PM
-- Design Name: 
-- Module Name: silly_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity silly_tb is
--  Port ( );
end silly_tb;

architecture Behavioral of silly_tb is
component silly
    Port (clk: in std_logic;a, b, c, d: out std_logic );
end component;
signal clk, a, b, c, d: std_logic := '0';
begin
dut : silly port map(clk => clk, a => a, b => b, c => c, d=> d);

clking : process(clk)
begin
clk <= not clk after 5 ns;
end process;
end Behavioral;

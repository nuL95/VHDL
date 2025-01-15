----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/10/2025 02:54:25 PM
-- Design Name: 
-- Module Name: bit4adder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: A 4 bit adder
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

entity bit4adder is
Port (A, B: in std_logic_vector(3 downto 0); Cin: in std_logic; S: out std_logic_vector(3 downto 0); Cout: out std_logic);
end bit4adder;

architecture Behavioral of bit4adder is
signal C: std_logic_vector (3 downto 1);
component FullAdder
Port (A, B, Cin: in std_logic;S, Cout: out std_logic );
end component;
begin
FA0: FullAdder port map(A(0),B(0),Cin, S(0),C(1));
FA1: FullAdder port map(A(1),B(1),C(1), S(1),C(2));
FA2: FullAdder port map(A(2),B(2),C(2), S(2),C(3));
FA3: FullAdder port map(A(3),B(3),C(3), S(3),Cout);
end Behavioral;

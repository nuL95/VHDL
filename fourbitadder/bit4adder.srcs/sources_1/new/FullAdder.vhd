----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/10/2025 02:49:50 PM
-- Design Name: 
-- Module Name: FullAdder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: A full bit adder
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

entity FullAdder is
Port (A, B, Cin: in std_logic;S, Cout: out std_logic );
end FullAdder;

architecture Behavioral of FullAdder is
begin
S <= (A xor B) xor Cin;
Cout <= ((A xor B) and Cin) or (A and B);
end Behavioral;
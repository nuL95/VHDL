----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/18/2025 10:21:22 AM
-- Design Name: 
-- Module Name: AXI_Slave - Behavioral
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

entity AXI_Slave is
Generic (bus_width: integer range 1 to 32 := 8);
Port (aclk: in std_logic; s_axis_t_data: in std_logic_vector (bus_width-1 downto 0);s_axis_t_valid: in std_logic;s_axis_t_last: in std_logic; s_axis_t_ready: out std_logic);
end AXI_Slave;

architecture Behavioral of AXI_Slave is

begin


end Behavioral;

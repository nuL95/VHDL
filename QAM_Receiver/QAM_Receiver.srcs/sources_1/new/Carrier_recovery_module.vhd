----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/29/2025 09:54:50 AM
-- Design Name: 
-- Module Name: Carrier_recovery_module - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Carrier recovery using second order costas loop, has an active tracking mode and an active mode.
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

entity Carrier_recovery_module is
Port (clk, rst: in std_logic;
tracking_en: in std_logic;
s_axis_data_tready: out std_logic;
s_axis_data_tvalid: in std_logic;
s_axis_data_tdata: in std_logic_vector (15 downto 0);
m_axis_data_tready: in std_logic;
m_axis_data_tvalid: out std_logic;
m_axis_data_tdata: out std_logic_vector (15 downto 0)
);
end Carrier_recovery_module;

architecture Behavioral of Carrier_recovery_module is

begin


end Behavioral;

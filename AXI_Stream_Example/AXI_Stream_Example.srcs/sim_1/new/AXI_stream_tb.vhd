----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/18/2025 10:21:50 AM
-- Design Name: 
-- Module Name: AXI_stream_tb - Behavioral
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

entity AXI_stream_tb is
end AXI_stream_tb;

architecture Behavioral of AXI_stream_tb is

signal aclk : std_logic := '0';
signal m_axis_t_ready : std_logic;
signal m_axis_t_data: std_logic_vector(7 downto 0);
signal m_axis_t_valid: std_logic;
signal m_axis_t_last: std_logic;
signal m_axis_aresetn : std_logic := '1';

signal data_out: std_logic_vector (7 downto 0);

component AXI_Master
    Generic (bus_width: integer range 1 to 32 := 8);
    Port (aresetn: in std_logic; aclk: in std_logic; m_axis_t_ready: in std_logic; m_axis_t_data: out std_logic_vector (bus_width-1 downto 0);m_axis_t_valid: out std_logic := '1';m_axis_t_last: out std_logic := '0');
end component;
component AXI_Slave
    Generic (bus_width: integer range 1 to 32 := 8);
    Port (aresetn: in std_logic; aclk: in std_logic; s_axis_t_data: in std_logic_vector (bus_width-1 downto 0);s_axis_t_valid: in std_logic;s_axis_t_last: in std_logic;
         s_axis_t_ready: out std_logic; data_received: out std_logic_vector (bus_width-1 downto 0));
end component;
begin
master_dut: AXI_Master generic map(bus_width => 8) port map (aresetn=>m_axis_aresetn, aclk => aclk, m_axis_t_ready => m_axis_t_ready,m_axis_t_data=>m_axis_t_data, m_axis_t_valid => m_axis_t_valid, m_axis_t_last=>m_axis_t_last);
slave_dut:  AXI_Slave generic map(bus_width => 8) port map (aresetn => m_axis_aresetn, aclk => aclk, s_axis_t_data => m_axis_t_data, s_axis_t_valid => m_axis_t_valid,
 s_axis_t_last => m_axis_t_last,s_axis_t_ready => m_axis_t_ready, data_received => data_out);
testing: process
begin
m_axis_aresetn <= '0';
wait for 5 ns;
m_axis_aresetn <= '1';
wait for 900 ns;
end process;
clking: process (aclk)
begin
aclk <= not aclk after 5 ns;
end process;
end Behavioral;

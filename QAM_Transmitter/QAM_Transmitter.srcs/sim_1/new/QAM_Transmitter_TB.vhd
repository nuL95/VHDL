----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/21/2025 11:45:18 AM
-- Design Name: 
-- Module Name: QAM_Transmitter_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: TB For QAM Transmitter
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

entity QAM_Transmitter_TB is
end QAM_Transmitter_TB;

architecture Behavioral of QAM_Transmitter_TB is
--Control Signals
signal clk, rst: std_logic := '0';

--Signals for file source
signal FS_m_axis_t_ready : std_logic := '1'; -- this will come from QAM module when its signal
signal FS_m_axis_t_valid : std_logic;
signal FS_m_axis_t_data : std_logic_vector (1 downto 0);


component file_read
    generic (file_name: string);
    Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic_vector (1 downto 0));
end component;
begin
FS_dut : file_read generic map(file_name => "bitstream.txt")
port map (clk => clk, rst => rst,m_axis_t_ready=> FS_m_axis_t_ready, m_axis_t_valid=>FS_m_axis_t_valid, data_out => FS_m_axis_t_data );
Testing: process
begin
wait for 1000 ns;
end process;
clocking: process(clk)
begin
    clk <= not clk after 5 ns;
end process;
end Behavioral;

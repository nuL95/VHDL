----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 11:54:32 AM
-- Design Name: 
-- Module Name: osci_ipc_tb - Behavioral
-- Project Name: oscillator using ipcore
-- Target Devices: 
-- Tool Versions: 
-- Description: Testing to see if I can create an oscillator using ipcores instead of manually designing one.
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity osci_ipc_tb is
--  Port ( );
end osci_ipc_tb;

architecture Behavioral of osci_ipc_tb is
signal clk : std_logic := '0';
signal osci_out : std_logic_vector (15 downto 0);
signal osci_phase_valid : std_logic := '0';
signal osci_phase_in: std_logic_vector (15 downto 0) := "0000000000000001";
signal dat_valid: std_logic;
component dds_compiler_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_phase_tvalid : IN STD_LOGIC;
    s_axis_phase_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
end component;
begin
oscillator: dds_compiler_0 port map(aclk => clk, s_axis_phase_tvalid => osci_phase_valid, s_axis_phase_tdata=> osci_phase_in, m_axis_data_tdata=> osci_out, m_axis_data_tvalid => dat_valid);

dut: process
begin
wait for 1000 ns;
end process;
process(clk)
begin
clk <= not clk after 50 ns;
end process;
end Behavioral;

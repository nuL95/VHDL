----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/18/2025 03:11:15 PM
-- Design Name: 
-- Module Name: FIR_filter_IPC_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: testbench for fir filter implemented with ip core.
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

entity FIR_filter_IPC_TB is
end FIR_filter_IPC_TB;

architecture Behavioral of FIR_filter_IPC_TB is
signal clk: std_logic := '0';
signal s_axis_data_tvalid : std_logic; -- needs to be 1 for filter to take in input
signal s_axis_data_tready: std_logic;
signal s_axis_data_tdata: std_logic_vector (15 downto 0); -- put signal to be filtered in here
signal m_axis_data_tvalid: std_logic;
signal m_axis_data_tdata: std_logic_vector (23 downto 0);

type mem is array (7 downto 0) of std_logic_vector(15 downto 0);
signal dat_bank: mem := (x"0001",x"0004",x"000A",x"0002",x"0000",x"0005",x"000F",x"0002");

component fir_compiler_0
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_data_tvalid : IN STD_LOGIC;
    s_axis_data_tready : OUT STD_LOGIC;
    s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    m_axis_data_tvalid : OUT STD_LOGIC;
    m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
  );
end component;
begin
dut: fir_compiler_0 port map(aclk => clk, s_axis_data_tvalid=>s_axis_data_tvalid,s_axis_data_tready=>s_axis_data_tready,m_axis_data_tvalid=>m_axis_data_tvalid , m_axis_data_tdata=>m_axis_data_tdata,s_axis_data_tdata=>s_axis_data_tdata );
testing: process
begin
s_axis_data_tvalid <= '1';
for n in 7 downto 0 loop
s_axis_data_tdata <= dat_bank(n);
wait for 10 ns;
end loop;
s_axis_data_tdata <= x"0000";
wait for 500 ns;
end process;
clocking: process(clk)
begin
clk <= not clk after 5 ns;
end process;
end Behavioral;

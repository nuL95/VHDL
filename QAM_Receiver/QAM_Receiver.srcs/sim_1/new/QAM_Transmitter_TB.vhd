----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/24/2025 09:02:33 PM
-- Design Name: 
-- Module Name: QAM_Transmitter_TB - Behavioral
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
use IEEE.NUMERIC_STD.ALL;



entity QAM_Transmitter_TB is
end QAM_Transmitter_TB;

architecture Behavioral of QAM_Transmitter_TB is
    constant clock_period: time := 2 ns;
    --control signal
    signal rst, clk: std_logic := '0';

    --file_read signals
    signal fr_m_axis_data_tdata: std_logic_vector(15 downto 0);
    signal fr_m_axis_data_tvalid: std_logic;
    signal fr_m_axis_data_tready: std_logic;

    --AGC signals
    signal AGC_m_axis_data_tdata: std_logic_vector (15 downto 0);
    signal AGC_m_axis_data_tvalid: std_logic;
    signal AGC_m_axis_data_tready: std_logic;
    signal test_signal_Active_input: std_logic_vector (15 downto 0);

    --carrier_recovery signals
    --component list
    component file_read
        generic (file_name: string);
        Port (clk, rst, m_axis_data_tready: in std_logic; m_axis_data_tvalid: out std_logic; m_axis_data_tdata: out std_logic_vector (15 downto 0));
    end component;
    component AGC
    Port (rst, clk : std_logic;
         s_axis_data_tdata: in std_logic_vector (15 downto 0);s_axis_data_tready: out std_logic; s_axis_data_tvalid: in std_logic;
         m_axis_data_tdata: out std_logic_vector (15 downto 0); m_axis_data_tready: in std_logic; m_axis_data_tvalid: out std_logic
         );
    end component;
begin
    FR_DUT: file_read generic map (file_name => "rx_bin.txt") port map(clk => clk, rst => rst, m_axis_data_tready => fr_m_axis_data_tready, m_axis_data_tvalid => fr_m_axis_data_tvalid, m_axis_data_tdata => fr_m_axis_data_tdata);
    AGC_DUT: AGC port map (rst => rst, clk => clk, s_axis_data_tdata => fr_m_axis_data_tdata, s_axis_data_tready => fr_m_axis_data_tready, s_axis_data_tvalid => fr_m_axis_Data_Tvalid,
                 m_Axis_data_tdata => AGC_m_axis_data_tdata, m_axis_data_tready => AGC_m_axis_data_tready, m_axis_data_tvalid => AGC_m_axis_data_tvalid);
    testing: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';
        wait for 10 ns;
        AGC_m_axis_data_tready <= '1';

        wait for 6500 ns;
    end process;

    clocking: process (clk)
    begin
        clk <= not clk after clock_period/2;
    end process;
end Behavioral;

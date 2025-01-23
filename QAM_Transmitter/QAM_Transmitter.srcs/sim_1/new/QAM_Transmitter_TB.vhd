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
    --Signals for file system and modulation
    signal FS_m_axis_t_ready :std_logic;
    signal FS_m_axis_t_Valid: std_logic;
    signal FS_m_axis_t_data_I, FS_m_axis_t_data_Q : std_logic_vector (15 downto 0);
    --Signals for pulse shaping
    signal SRRC_m_axis_t_valid_I,SRRC_m_axis_t_valid_Q: std_logic;
    signal SRRC_M_axis_t_data_I, SRRC_m_axis_t_data_Q: std_logic_vector (23 downto 0);

    --Signals for carrier
    signal carrier_m_axis_t_data: std_logic_vector (15 downto 0);
    signal carrier_m_axis_t_valid: std_logic;

    --Signals for mixer
    signal mixer_m_axis_t_data: std_logic_vector (31 downto 0);
    signal mixer_m_axis_t_valid: std_logic;
    signal mixer_m_axis_t_ready: std_logic; --this will be connected to the file sink module which will write the data to a file for matlab analysis.

    --component declarations
    component file_read is
        generic (file_name: string; upsample_rate: integer);
        Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out_I, data_out_Q: out std_logic_vector (15 downto 0));
    end component;
    component SRRC_Filter is
        PORT (
            aclk : IN STD_LOGIC;
            s_axis_data_tvalid : IN STD_LOGIC;
            s_axis_data_tready : OUT STD_LOGIC;
            s_axis_data_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
            m_axis_data_tvalid : OUT STD_LOGIC;
            m_axis_data_tdata : OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
        );
    end component;
    component SINCOS_GEN
        PORT (
            aclk : IN STD_LOGIC;
            m_axis_data_tvalid : OUT STD_LOGIC;
            m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    end component;
    component mixer
        Port (clk: in std_logic; rst: in std_logic;
             carrier_s_axis_t_valid: in std_logic;  carrier_s_axis_t_data: in std_logic_vector (15 downto 0);
             symbol_I_s_axis_t_valid: in std_logic; symbol_I_s_axis_t_data: in std_logic_vector (23 downto 0);
             symbol_Q_s_axis_t_valid: in std_logic; symbol_Q_s_axis_t_data: in std_logic_vector (23 downto 0);
             m_axis_t_valid: out std_logic; m_axis_t_ready: in std_logic; m_axis_t_data: out std_logic_vector (31 downto 0));
    end component;
    component file_sink
        generic (file_name: string);
        Port (clk, rst: in std_logic; s_axis_t_valid: in std_logic; data_in: std_logic_vector(31 downto 0);s_axis_t_ready: out std_logic);
    end component;
begin
    --Declaration of modules
    FS_dut : file_read generic map(file_name => "bitstream.txt", upsample_rate => 6)
        port map (clk => clk, rst => rst,m_axis_t_ready=> FS_m_axis_t_ready, m_axis_t_valid=>FS_m_axis_t_valid, data_out_I => FS_m_axis_t_data_I, data_out_Q =>FS_m_axis_t_data_Q );
    SRRC_I_dut: SRRC_Filter port map(aclk => clk, s_axis_data_tvalid => FS_m_axis_t_valid, s_axis_data_tdata => FS_m_axis_t_data_I,
                 s_axis_data_tready => FS_m_axis_t_ready, m_axis_data_tvalid => SRRC_m_axis_t_valid_I,  m_axis_data_tdata => SRRC_M_axis_t_data_I);
    SRRC_Q_dut: SRRC_Filter port map(aclk => clk, s_axis_data_tvalid => FS_m_axis_t_valid, s_axis_data_tdata => FS_m_axis_t_data_Q,
                 s_axis_data_tready => FS_m_axis_t_ready, m_axis_data_tvalid => SRRC_m_axis_t_valid_Q,  m_axis_data_tdata => SRRC_M_axis_t_data_Q);
    CARRIER_DUT: SINCOS_GEN port map (aclk => clk, m_axis_data_tvalid => carrier_m_axis_t_valid, m_axis_data_tdata => carrier_m_axis_t_data);
    MIXER_DIT: mixer port map (clk => clk, rst => rst, carrier_s_Axis_t_valid =>carrier_m_axis_t_valid, carrier_s_axis_t_data => carrier_m_axis_t_data,
                 symbol_I_s_axis_t_valid => SRRC_m_axis_t_valid_I, symbol_I_s_axis_t_data => SRRC_m_axis_t_data_I,
                 symbol_Q_s_axis_t_valid => SRRC_m_axis_t_valid_Q, symbol_Q_s_axis_t_data => SRRC_m_axis_t_data_Q,
                 m_axis_t_valid => mixer_m_axis_t_valid, m_axis_t_ready => mixer_m_axis_t_ready, m_axis_t_data => mixer_m_axis_t_data);
    FILE_SINK_DUT: file_sink generic map (file_name => "tx_dat.txt") port map (clk => clk, rst => rst, s_axis_t_valid => mixer_m_axis_t_valid, data_in => mixer_m_axis_t_data, s_axis_t_ready => mixer_m_axis_t_ready);
    Testing: process
    begin
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        wait for 6500 ns;
    end process;
    clocking: process(clk)
    begin
        clk <= not clk after 1 ns;
    end process;
end Behavioral;

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
    signal FS_m_axis_t_ready : std_logic; -- this will come from QAM module when its signal
    signal FS_m_axis_t_valid : std_logic;
    signal FS_m_axis_t_data : std_logic_vector (1 downto 0);

    --Signals for Modulator
    signal MOD_s_axis_t_ready: std_logic;
    signal MOD_m_axis_t_valid: std_logic;
    signal MOD_m_axis_t_data_inphase: std_logic_vector (15 downto 0);
    signal MOD_m_axis_t_data_quad: std_logic_vector (15 downto 0);

    --This signal should not be driven when the upsampler module is done.
    signal UPS_s_axis_t_ready: std_logic;
    signal UPS_m_axis_t_ready: std_logic  := '1';
    signal UPS_s_axis_t_valid: std_logic;
    signal UPS_m_axis_t_valid: std_logic;
    signal UPS_m_axis_t_data: std_logic_vector (15 downto 0);
    
    

    component file_read
        generic (file_name: string);
        Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic_vector (1 downto 0));
    end component;
    component QAM4_Modulator
        Port (rst, clk: in std_logic; s_axis_t_valid: in std_logic; m_axis_t_ready: in std_logic; s_axis_t_data: in std_logic_vector (1 downto 0);
             s_axis_t_ready: out std_logic; m_axis_t_valid: out std_logic; m_axis_t_data_inphase: out std_logic_vector (15 downto 0); m_axis_t_data_quad: out std_logic_vector(15 downto 0));
    end component;
    component Upsampler
        Generic (upsample_rate: integer range 1 to 20);
        Port (rst, clk: in std_logic; s_axis_t_valid: in std_logic; m_axis_t_ready: in std_logic; s_axis_t_data: in std_logic_vector (15 downto 0);
             s_axis_t_ready: out std_logic; m_axis_t_valid: out std_logic; m_axis_t_data: out std_logic_vector (15 downto 0));
    end component;
begin
    --Declaration of modules
    FS_dut : file_read generic map(file_name => "bitstream.txt")
        port map (clk => clk, rst => rst,m_axis_t_ready=> FS_m_axis_t_ready, m_axis_t_valid=>FS_m_axis_t_valid, data_out => FS_m_axis_t_data );
    MOD_dut: QAM4_Modulator port map (rst => rst, clk => clk, s_axis_t_valid => FS_m_axis_t_valid, m_axis_t_ready => UPS_s_axis_t_ready, s_axis_t_data => FS_m_axis_t_data,
    s_axis_t_ready => FS_m_axis_t_ready, m_axis_t_valid => UPS_s_axis_t_valid, m_axis_t_data_quad => MOD_m_axis_t_data_quad, m_axis_t_data_inphase => MOD_m_axis_t_data_inphase);
    US_DUT_I: Upsampler generic map(upsample_rate => 6) port map (rst => rst, clk => clk, s_axis_t_valid => UPS_s_axis_t_valid, m_axis_t_ready => UPS_m_axis_t_ready, s_axis_t_data => MOD_m_axis_t_data_inphase,
    s_axis_t_ready => UPS_s_axis_t_ready, m_axis_t_valid => UPS_m_axis_t_valid, m_axis_t_data => UPS_m_axis_t_data);
    Testing: process
    begin
        rst <= '1';
        wait for 2 ns;
        rst <= '0';
        for n in 0 to 10 loop
         --   FS_m_axis_t_ready <= '0';
            wait for 12 ns;
         --   FS_m_axis_t_ready <= '1';
            wait for 2 ns;
        end loop;
        wait for 3000 ns;
    end process;
    clocking: process(clk)
    begin
        clk <= not clk after 1 ns;
    end process;
end Behavioral;

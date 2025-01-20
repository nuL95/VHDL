----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/20/2025 10:27:16 AM
-- Design Name: 
-- Module Name: FIFO_TB - Behavioral
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
use IEEE.numeric_std.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;

entity FIFO_TB is
end FIFO_TB;

architecture Behavioral of FIFO_TB is

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal m_axis_t_ready : std_logic := '1';
    signal m_axis_t_valid : std_logic;
    signal in_test: std_logic;
    component file_read
        generic (file_name: string);
        Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic);
    end component;
begin
    dut: file_read generic map (file_name => "bitstream.txt") port map (clk => clk, rst=>rst, m_axis_t_ready => m_axis_t_ready, m_axis_t_valid =>m_axis_t_valid, data_out => in_test);
    testing: process
    begin
        wait for 1000 ns;
    end process;
    clocking: process(clk)
    begin
        clk <= not clk after 1 ns;
    end process;
end Behavioral;

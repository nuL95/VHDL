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
    -- test signals for file read
    signal m_axis_t_ready : std_logic;
    signal m_axis_t_valid : std_logic;
    signal in_test: std_logic;
    --test signals for file write
    type mem is array (9 downto 0) of std_logic_vector (31 downto 0);
    constant dat_bank : mem :=(x"00006431",x"00005613",x"00000111",x"0000011D",x"00000000",x"00004521",x"0000AB32",x"0000F213",x"00000124",x"000000FF");
    signal write_test_vector: std_logic_vector (31 downto 0);
    signal s_axis_t_ready: std_logic;
    signal s_axis_t_valid : std_logic := '1';


    component file_read
        generic (file_name: string);
        Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic);
    end component;
    component file_write
        generic (file_name: string);
        Port (clk, rst: in std_logic; s_axis_t_valid: in std_logic; data_in: std_logic_vector(31 downto 0);s_axis_t_ready: out std_logic; data_out: out std_logic_vector(31 downto 0));
    end component;
begin
    dut_read: file_read generic map (file_name => "bitstream.txt")
        port map (clk => clk, rst=>rst, m_axis_t_ready => m_axis_t_ready, m_axis_t_valid =>m_axis_t_valid, data_out => in_test);
    dut_write: file_write generic map(file_name => "output_test.txt")
        port map (clk => clk, rst => rst, s_axis_t_valid => s_axis_t_valid, s_axis_t_ready => s_axis_t_ready, data_in => write_test_vector);
    testing: process
    begin
        for n in 9 downto 0 loop
            write_test_vector <= dat_bank(n);
            wait for 10 ns;
        end loop;
        s_axis_t_valid <= '0';
        wait for 2900 ns;
    end process;
    clocking: process(clk)
    begin
        clk <= not clk after 5 ns;
    end process;
end Behavioral;

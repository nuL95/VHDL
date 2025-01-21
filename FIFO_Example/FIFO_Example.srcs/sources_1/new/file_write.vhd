----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/21/2025 10:25:32 AM
-- Design Name: 
-- Module Name: file_write - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Writes data from the 
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

--data_out is not needed, but is currently here for testing purposes only.
entity file_write is
    generic (file_name: string);
    Port (clk, rst: in std_logic; s_axis_t_valid: in std_logic; data_in: std_logic_vector(15 downto 0);s_axis_t_ready: out std_logic; data_out: out std_logic_vector(15 downto 0));
end file_write;

architecture Behavioral of file_write is
    signal    s_axis_t_ready_signal : std_logic;
begin
    s_axis_t_ready <= s_axis_t_ready_signal;
    process (clk, rst)
        file source_file : text open write_mode is
 file_name;
        variable row : line;
    begin
        if rst = '1' then
            --do reset things, I don't know what that would entail right now.
            s_axis_t_ready_signal <= '1';
        elsif rising_edge(clk) then
            s_axis_t_ready_signal<= '1';
            if s_axis_t_valid = '1' then
                write(row, data_in, right, 16);
                writeline(source_file, row);
            end if;
        end if;
    end process;
end Behavioral;

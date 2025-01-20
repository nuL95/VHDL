----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/20/2025 11:02:13 AM
-- Design Name: 
-- Module Name: file_read - Behavioral
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



entity file_read is
    generic (file_name: string);
    Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic); -- include generic string which is the file name perhaps?
end file_read;

architecture Behavioral of file_read is
begin
    process(clk, rst)
        file test_vector : text open read_mode is
file_name;
        variable row : line;
        variable data_in : std_logic;
    begin
        if rst = '1' then
        --im actually not sure how to reset, what I would like is for test_vector to go back to the beginning of file_name, I'm not sure how to write this. I'm a little confused how endfile works, i thought that 
        --test_vector was the entire file, and the line being read is row, so why does endfile only need test_vector and not row?
        elsif rising_edge(clk) then 
            if not endfile(test_vector) then
                m_axis_t_valid <= '1';
                if m_axis_t_ready = '1' then
                    readline (test_vector, row);
                    read(row, data_in);
                    data_out <= data_in;
                end if;
            else m_axis_t_valid <= '0';
            end if;
        end if;
    end process;
end Behavioral;

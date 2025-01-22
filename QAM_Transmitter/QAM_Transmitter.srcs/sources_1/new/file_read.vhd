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
-- Description: Reads a file using the generic file_name, the file should be binary with one number per line, two bits per clock cycle is read and passed to data_out. Only passes on bit when ready and valid ports are '1'.
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
    Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out: out std_logic_vector (1 downto 0)); -- data_out should be the appropriate data type, so for a 16 bit number it will be signed (15 downto 0)
end file_read;

architecture Behavioral of file_read is
    signal m_axis_t_valid_int: std_logic;
    type t_state is (IDLE, ACTIVE);
    signal status: t_state;
begin
    m_axis_t_valid <= m_axis_t_valid_int;
    process(clk)
        file source_file : text open read_mode is
 file_name;
        variable row : line;
        variable data_in : std_logic_vector (1 downto 0); -- Should be appropriate data type, ex signed (15 downto 0)
    begin
        if rst = '1' then
            status <= IDLE;
            m_axis_t_valid_int <= '0';
        --im actually not sure how to reset, what I would like is for source_file to go back to the beginning of file_name, I'm not sure how to write this. I'm a little confused how endfile works, i thought that 
        --source_file was the entire file, and the line being read is row, so why does endfile only need source_file and not row?
        elsif rising_edge(clk) then
            case status is
                when IDLE =>
                    m_axis_t_valid_int <= '0';
                    if m_axis_t_ready  = '1' and not endfile(source_file) then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    m_axis_t_valid_int <= '1';
                    if not endfile(source_file) then
                        readline (source_file, row);
                        read(row, data_in(1));
                    end if;
                    if not endfile(source_file) then
                        readline (source_file, row);
                        read(row, data_in(0));
                    end if;
                    data_out <= data_in;
                    if m_axis_t_ready = '0' or endfile(source_file) then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

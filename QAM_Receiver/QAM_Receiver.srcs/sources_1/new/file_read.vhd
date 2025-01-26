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
-- Description: Reads a file using the generic file_name
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
    Port (clk, rst, m_axis_data_tready: in std_logic; m_axis_data_tvalid: out std_logic; m_axis_data_tdata: out std_logic_vector (15 downto 0));
end file_read;

architecture Behavioral of file_read is
    type t_state is (IDLE, ACTIVE);
    signal status: t_state;
begin
    process(clk)
        file source_file : text open read_mode is
 file_name;
        variable row : line;
        variable data_in : std_logic_vector (15 downto 0); -- Should be appropriate data type, ex signed (15 downto 0)
        variable counter : unsigned (4 downto 0);
    begin
        if rst = '1' then
            status <= IDLE;
            m_axis_data_tvalid <= '0';
        elsif rising_edge(clk) then
            case status is
                when IDLE =>
                    m_axis_data_tvalid <= '0';
                    if m_axis_data_tready  = '1' and not endfile(source_file) then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    m_axis_data_tvalid<= '1';
                    if not endfile(source_file) then
                        readline (source_file, row);
                        read(row, data_in);
                    end if;
                   m_axis_data_tdata <= data_in;
                    if endfile(source_file) or m_axis_data_tready = '0' then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

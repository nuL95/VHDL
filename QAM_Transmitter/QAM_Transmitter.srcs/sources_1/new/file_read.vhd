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
    generic (file_name: string; upsample_rate: integer);
    Port (clk, rst, m_axis_t_ready: in std_logic; m_axis_t_valid: out std_logic; data_out_I, data_out_Q: out std_logic_vector (15 downto 0));
end file_read;

architecture Behavioral of file_read is
    signal m_axis_t_valid_int: std_logic;
    type t_state is (IDLE, ACTIVE, ACTIVE0);
    signal status: t_state;
begin
    m_axis_t_valid <= m_axis_t_valid_int;
    process(clk)
        file source_file : text open read_mode is
 file_name;
        variable row : line;
        variable data_in : std_logic_vector (1 downto 0); -- Should be appropriate data type, ex signed (15 downto 0)
        variable counter : unsigned (4 downto 0);
    begin
        if rst = '1' then
            status <= IDLE;
            m_axis_t_valid_int <= '0';
            counter := (others => '0');
        elsif rising_edge(clk) then
            case status is
                when IDLE =>
                    m_axis_t_valid_int <= '0';
                    if m_axis_t_ready  = '1' and not endfile(source_file) then
                        status <= ACTIVE0;
                    end if;
                when ACTIVE0 =>
                    counter := counter + 1;
                    if counter = upsample_rate-1 then
                        status <= ACTIVE;
                    end if;
                    data_out_I <= (others => '0');
                    data_out_Q <= (others => '0');
                    if m_axis_t_ready = '0' then
                        status <= IDLE;
                    end if;
                when ACTIVE =>
                    counter := (others => '0');
                    m_axis_t_valid_int <= '1';
                    if not endfile(source_file) then
                        readline (source_file, row);
                        read(row, data_in(1));
                    end if;
                    if not endfile(source_file) then
                        readline (source_file, row);
                        read(row, data_in(0));
                    end if;
                    if data_in(0) = '0' then
                        data_out_Q <= "0010000000000000"; --this is the integer 1 in the specified 16-bit format
                    else
                        data_out_Q <= "1110000000000000"; --this is the integer -1 in the specified 16-bit format
                    end if;
                    if data_in(1) = '0' then
                        data_out_I <="0010000000000000" ;
                    else
                        data_out_I <= "1110000000000000";
                    end if;
                    if endfile(source_file) then
                        status <= IDLE;
                    else status <= ACTIVE0;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

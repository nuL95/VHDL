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
-- Description: Writes data from the input to a file
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

entity file_sink is
    generic (file_name: string);
    Port (clk, rst: in std_logic; s_axis_t_valid: in std_logic; data_in: std_logic_vector(31 downto 0);s_axis_t_ready: out std_logic);
end file_sink;

architecture Behavioral of file_sink is
    type t_state is (IDLE,ACTIVE);
    signal status: t_state;
begin
    process (clk, rst)
        file source_file : text open write_mode is
 file_name;
        variable row : line;
    begin
        if rst = '1' then
            --do reset things
            status <= IDLE;
            s_axis_t_ready <= '0';
        elsif rising_edge(clk) then
            case (status) is
                when IDLE =>
                    s_axis_t_Ready <= '1';
                    if s_axis_t_valid = '1' then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    write(row, data_in, right, 16);
                    writeline(source_file, row);
            end case;
        end if;
    end process;
end Behavioral;

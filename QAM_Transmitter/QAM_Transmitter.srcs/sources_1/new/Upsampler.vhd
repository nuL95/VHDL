----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/21/2025 03:17:15 PM
-- Design Name: 
-- Module Name: Upsampler - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Upsampler should flag ready when its ready to produce a sample on its output, otherwise should output zeros.
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

entity Upsampler is
    Generic (upsample_rate: integer range 1 to 20);
    Port (rst, clk: in std_logic; s_axis_t_valid: in std_logic; m_axis_t_ready: in std_logic; s_axis_t_data: in std_logic_vector (15 downto 0);
         s_axis_t_ready: out std_logic; m_axis_t_valid: out std_logic; m_axis_t_data: out std_logic_vector (15 downto 0));
end Upsampler;

architecture Behavioral of Upsampler is
    type t_state is (ACTIVE0, ACTIVE);
    signal status: t_state;
begin
    process (clk)
        variable counter: unsigned (4 downto 0) := (others => '0');
    begin
        if rst = '1' then
            counter := (others => '0');
            m_axis_t_valid <= '0';
            s_axis_t_ready <= '0';
            status <= ACTIVE0;
        elsif rising_edge(clk) then
            case status is
                when ACTIVE0 =>
                    counter := counter + 1;
                    if counter = upsample_rate - 1 then
                        counter := (others => '0');
                        s_axis_t_ready <= '1';
                        m_axis_t_valid <= '1';
                        status <= ACTIVE;
                    else s_axis_t_ready <= '0';
                    end if;
                    m_axis_t_data <= (others => '0');
                when ACTIVE =>
                    m_axis_t_data <= s_axis_t_data;
                    status <= ACTIVE0;
            end case;
        end if;
    end process;
end Behavioral;

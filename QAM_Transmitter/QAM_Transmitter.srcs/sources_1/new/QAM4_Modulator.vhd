----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/21/2025 12:51:54 PM
-- Design Name: 
-- Module Name: QAM4_Modulator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module takes in two bits at a time and passes them along according to gray mapping to the in phase and quadrature channels which will be used for QAM4 modulation
-- The output is 16 bits: 1 sign bit, 9 integer bits, and 6 fractional bits.
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

entity QAM4_Modulator is
    Port (rst, clk: in std_logic; s_axis_t_valid: in std_logic; m_axis_t_ready: in std_logic; s_axis_t_data: in std_logic_vector (1 downto 0);
         s_axis_t_ready: out std_logic; m_axis_t_valid: out std_logic; m_axis_t_data_inphase: out std_logic_vector (15 downto 0); m_axis_t_data_quad: out std_logic_vector(15 downto 0)); -- (0) is quad, (1) is inphase
end QAM4_Modulator;

architecture Behavioral of QAM4_Modulator is
    type t_state is (IDLE, ACTIVE);
    signal status: t_state;

begin
    process (clk)
    begin
        if rst = '1' then
            status <= IDLE;
            s_axis_t_ready <= '0';
            m_axis_t_valid <= '0';
        elsif rising_edge(clk) then
            case (status) is
                when IDLE =>
                    if m_axis_t_ready = '1' then
                        s_axis_t_ready <= '1';
                    else s_axis_t_ready <='0';
                    end if;
                    m_axis_t_valid <= '0';
                    if m_axis_t_ready = '1' and s_axis_t_valid = '1' then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    s_axis_t_ready <= '1';
                    m_axis_t_valid <= '1';
                    if s_axis_t_data(0) = '0' then
                        m_axis_t_data_quad <= "0000000001000000"; --this is the integer 1 in the specified 16-bit format
                    else
                        m_axis_t_data_quad <= "1111111111000000"; --this is the integer -1 in the specified 16-bit format
                    end if;
                    if s_axis_t_data(1) = '0' then
                        m_axis_t_data_inphase <="0000000001000000" ;
                    else
                        m_axis_t_data_inphase <= "1111111111000000";
                    end if;
                    if m_axis_t_ready = '0' or s_axis_t_valid = '0' then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

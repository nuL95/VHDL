----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/23/2025 11:06:04 AM
-- Design Name: 
-- Module Name: mixer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: mixer that multiplies the 8-bit sinusoid carriers by the symbols then adds the inphase and quadrature components together. 
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
use IEEE.NUMERIC_STD.ALL;

entity mixer is
    Port (clk: in std_logic; rst: in std_logic;
         carrier_s_axis_t_valid: in std_logic;  carrier_s_axis_t_data: in std_logic_vector (15 downto 0);
         symbol_I_s_axis_t_valid: in std_logic; symbol_I_s_axis_t_data: in std_logic_vector (23 downto 0);
         symbol_Q_s_axis_t_valid: in std_logic; symbol_Q_s_axis_t_data: in std_logic_vector (23 downto 0);
         m_axis_t_valid: out std_logic; m_axis_t_ready: in std_logic; m_axis_t_data: out std_logic_vector (31 downto 0));
end mixer;

architecture Behavioral of mixer is
    type t_state is (ACTIVE,IDLE);
    signal status: t_state;
    signal signal_I,signal_Q: signed (31 downto 0);
    signal tx: std_logic_vector(31 downto 0);
begin
    process (clk)
    begin
        if rst = '1' then
            m_axis_t_Valid <= '0';
            m_axis_t_data <= (others =>'0');
            status <= IDLE;
        elsif rising_edge(clk) then
            case (status) is
                when IDLE =>
                    m_axis_t_Valid <= '0';
                    if m_axis_t_ready = '1' and carrier_s_axis_t_valid = '1' and symbol_I_s_axis_t_valid = '1' and symbol_Q_s_axis_t_valid = '1' then
                        status <= ACTIVE;
                    end if;
                when ACTIVE=>
                    m_axis_t_valid <= '1';
                    signal_I <=signed(carrier_s_axis_t_data(7 downto 0))*signed(symbol_I_s_axis_t_data);
                    signal_Q <=signed(carrier_s_axis_t_data(15 downto 8))*signed(symbol_Q_s_axis_t_data);
                    tx <= std_logic_vector(signal_I+signal_Q);
                    m_axis_t_data <= tx;
                    if m_axis_t_Ready ='0' or carrier_s_axis_t_valid = '0' or symbol_I_s_axis_t_valid = '0' or symbol_Q_s_axis_t_valid = '0' then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

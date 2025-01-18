----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/18/2025 10:21:22 AM
-- Design Name: 
-- Module Name: AXI_Master - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This module has a 8bit, 8 value data bank, it sends this data bank to the slave module and changes m_axis_t_last to '1' when the last address is sent. Then it resets are starts over again.
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
use IEEE.numeric_bit.all;


entity AXI_Master is
    Generic (bus_width: integer range 1 to 32 := 8);
    Port (aresetn: in std_logic; aclk: in std_logic; m_axis_t_ready: in std_logic; m_axis_t_data: out std_logic_vector (bus_width-1 downto 0);m_axis_t_valid: out std_logic := '1';m_axis_t_last: out std_logic := '0');
end AXI_Master;

architecture behavioral of AXI_master is
    --Data for the master to send.
    type memory is array (7 downto 0) of std_logic_vector(bus_width-1 downto 0);
    constant dat_bank: memory := (x"0D", x"F1",x"00",x"32",x"FF",x"04",x"1C",x"22");
    type t_state is (IDLE, ACTIVE);
    signal status : t_state;

    signal m_axis_t_valid_sig: std_logic := '0';
    signal mem_pointer: unsigned (2 downto 0) := (others=>'0');

begin
    m_axis_t_valid <= m_axis_t_valid_sig;
    StateMachine:    process(aclk, aresetn)
    begin
        if aresetn = '0' then
            status <= IDLE;
            mem_pointer <= (others=>'0');
            m_axis_t_valid_sig <= '0';
            m_axis_t_data <= (others=>'0');
            m_axis_t_last <= '0';
        end if;
        if rising_edge(aclk) then
            case (status) is
                when IDLE =>
                    m_axis_t_valid_sig <= '0';
                    if (m_axis_t_ready = '1') then
                        status <= ACTIVE;
                    else
                        status <= IDLE;
                    end if;
                when ACTIVE =>
                    m_axis_t_valid_sig <= '1';
                    if (m_axis_t_ready = '1') then
                        m_axis_t_data <= dat_bank(to_integer(mem_pointer));
                        mem_pointer <= mem_pointer + 1;
                        if mem_pointer = "111" then
                            m_axis_t_last <= '1';
                        else
                            m_axis_t_last <= '0';
                        end if;
                    else -- get rid of this statement and turn this into an else clause
                    status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end behavioral;

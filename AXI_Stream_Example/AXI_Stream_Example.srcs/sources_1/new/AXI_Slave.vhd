----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/18/2025 10:21:22 AM
-- Design Name: 
-- Module Name: AXI_Slave - Behavioral
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

entity AXI_Slave is
    Generic (bus_width: integer range 1 to 32 := 8);
    Port (aresetn: in std_logic; aclk: in std_logic; s_axis_t_data: in std_logic_vector (bus_width-1 downto 0);s_axis_t_valid: in std_logic;s_axis_t_last: in std_logic;
         s_axis_t_ready: out std_logic; data_received: out std_logic_vector (bus_width-1 downto 0));
end AXI_Slave;

architecture Behavioral of AXI_Slave is
    type t_state is (IDLE, ACTIVE);
    signal status : t_state;
    signal s_axis_t_ready_signal: std_logic := '0';
begin
    s_axis_t_ready <= s_axis_t_ready_signal;
    StateMachine : process(aclk, aresetn)
    begin
        if aresetn = '0' then
            s_axis_t_ready_signal <= '0';
            data_received <= (others=>'0');
            status <= IDLE;
        end if;
        if rising_edge(aclk) then
            case (status) is
                --In reality there could be many reasons to remain in the idle state, you might need time to process data, you might not need to get more, etc. This module just assumes you want to push data from master to slave ASAP
                when IDLE =>
                    if s_axis_t_valid = '1' then
                        status <= ACTIVE;
                    else
                        status <= IDLE;
                    end if;
                    s_axis_t_ready_signal <= '1'; --just give more data all the time
                when ACTIVE =>
                    s_axis_t_ready_signal <= '1';
                    if s_axis_t_valid = '1' then
                        data_received <= s_axis_t_data;
                    else --get rid of this if clause and turn into an aclk
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

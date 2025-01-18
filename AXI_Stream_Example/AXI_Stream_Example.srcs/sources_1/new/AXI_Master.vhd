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


entity AXI_Master is
    Generic (bus_width: integer range 1 to 32 := 8);
    Port (aclk: in std_logic; m_axis_t_ready: in std_logic; m_axis_t_data: out std_logic_vector (bus_width-1 downto 0);m_axis_t_valid: buffer std_logic := '1';m_axis_t_last: out std_logic := '0');
end AXI_Master;

architecture behavioral of AXI_master is
    --Data for the master to send.
    type memory is array (7 downto 0) of std_logic_vector(bus_width-1 downto 0);
    constant dat_bank: memory := (x"0D", x"F1",x"00",x"32",x"FF",x"04",x"1C",x"22");
    type t_state is (IDLE, ACTIVE);
    signal state : t_state := IDLE;
begin
    process(aclk)
        variable mem_pointer: integer range 0 to 7 := 0;
    begin
        if rising_edge(aclk) then
            if state = ACTIVE then
                if m_axis_t_ready = '1' and m_axis_t_valid = '1' then -- check this to see if i can do 1 bit vs 2
                    m_axis_t_data <= dat_bank(mem_pointer);
                    mem_pointer := mem_pointer+1;
                    m_axis_t_valid <= '0';
                    state <= IDLE;
                    if mem_pointer = 7 then
                        m_axis_t_last <= '1'; -- It might be a good idea to do something more robust for making sure that the mem pointer stops at the end but currently it will just cycle through which is okay for now
                        mem_pointer := 0;
                    else
                        m_axis_t_last <= '0';
                    end if;
                else
                   state <= IDLE;
                end if;
            else --IDLE State
                m_axis_t_valid <= '1';
                if m_axis_t_ready = '1' then
                    state <= ACTIVE;
                end if;
            end if;
        end if;
    end process;
end behavioral;

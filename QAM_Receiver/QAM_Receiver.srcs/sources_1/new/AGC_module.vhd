----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/24/2025 02:13:23 PM
-- Design Name: 
-- Module Name: AGC - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity AGC is
    Port (rst, clk : std_logic;
         s_axis_data_tdata: in std_logic_vector (15 downto 0);s_axis_data_tready: out std_logic; s_axis_data_tvalid: in std_logic;
         m_axis_data_tdata: out std_logic_vector (15 downto 0); m_axis_data_tready: in std_logic; m_axis_data_tvalid: out std_logic
         );
end AGC;

architecture Behavioral of AGC is
    --constant step: integer := 4;
    constant a_ref: signed (31 downto 0):= "00000000010000000000000000000000"; -- 0.0625

    type t_state is (IDLE,ACTIVE);
    signal status: t_state;

    signal gain_acum: signed (31 downto 0);
    signal AGC_out: signed (31 downto 0);
begin
    --m_axis_data_tdata <= std_logic_vector(int_test(31 downto 16));
    process (clk)
    variable ys_sq_int : signed (63 downto 0);
    variable error: signed (31 downto 0);
    variable agc_temp: signed (47 downto 0);
    begin
        if rst = '1' then
            gain_acum <= "00000100000000000000000000000000";
            s_axis_data_tready <= '0';
            m_axis_data_tvalid <= '0';
            AGC_out <= (others => '0');
            status <= IDLE;
        elsif rising_edge(clk) then
            case (status) is
                when IDLE =>
                    m_axis_data_tvalid <= '0';
                    s_axis_data_tready <= m_axis_data_tready;
                    if (s_axis_data_tvalid and m_axis_data_tready) = '1' then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    m_axis_data_tvalid <= '1';
                    agc_temp := signed(s_axis_data_tdata) * gain_acum;
                    AGC_out <= agc_temp(47) & agc_temp(43 downto 13);
                    ys_sq_int := AGC_out*AGC_out;
                    error := (a_ref - (ys_sq_int(63) & ys_sq_int(56 downto 26)))/16;
                    gain_acum <= gain_acum + error;
                    m_axis_data_tdata <= std_logic_vector(AGC_out(31) & AGC_out(27 downto 13));
                    if s_axis_data_tvalid = '0' or m_axis_data_tready = '0' then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;
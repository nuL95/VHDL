----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/29/2025 01:17:46 PM
-- Design Name: 
-- Module Name: costas_loop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This is a costas loop used to provide phase correction to the local oscillator based on the phase of an incoming sinusoid.
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

entity costas_loop is
    Port (aclk, rstn: in std_logic;
         s_axis_data_tvalid: in std_logic;
         s_axis_data_tready: out std_logic;
         s_axis_data_tdata: in std_logic_vector (7 downto 0);
         m_axis_data_tvalid: out std_logic;
         m_axis_data_tready: in std_logic;
         m_axis_data_tdata: out std_logic_vector(7 downto 0);
         debug_phase_out: out std_logic_vector (31 downto 0);
         debug_mult_out: out std_logic_vector (31 downto 0)
        );
end costas_loop;

architecture Behavioral of costas_loop is
    --NCO Signals
    signal en: std_logic;
    signal s_axis_NCO_tready: std_logic;
    signal s_axis_NCO_tvalid: std_logic;
    signal s_axis_NCO_tdata: std_logic_vector(31 downto 0);
    signal m_axis_NCO_tready: std_logic;
    signal m_axis_NCO_tvalid: std_logic;
    signal m_axis_NCO_tdata: std_logic_vector (15 downto 0);

    --costas loop signals
    signal phase_acum: signed (31 downto 0);

    --state signal
    type t_state is (IDLE, ACTIVE);
    signal status: t_state;

    COMPONENT PLL_NCO
        PORT (
            aclk : IN STD_LOGIC;
            aclken : IN STD_LOGIC;
            aresetn : IN STD_LOGIC;
            s_axis_phase_tvalid : IN STD_LOGIC;
            s_axis_phase_tready : OUT STD_LOGIC;
            s_axis_phase_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            m_axis_data_tvalid : OUT STD_LOGIC;
            m_axis_data_tready : IN STD_LOGIC;
            m_axis_data_tdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
        );
    END COMPONENT;
begin
    CL_NCO: PLL_NCO port map(aclk => aclk, aclken => en, aresetn => rstn, s_axis_phase_tvalid => s_axis_NCO_tvalid, s_axis_phase_tready => s_axis_NCO_tready, s_axis_phase_tdata => s_axis_NCO_tdata,
                 m_axis_data_tvalid => m_axis_NCO_tvalid, m_axis_data_tready => m_axis_NCO_tready, m_axis_data_tdata => m_axis_NCO_tdata);

    m_axis_data_tdata <= m_axis_NCO_tdata(15 downto 8);


    process(aclk, rstn)
        variable multi_out: signed (31 downto 0);
    begin
        if rstn = '0' then
            status <= IDLE;
            en <= '0';
            phase_acum <= (others => '0');
            s_axis_NCO_tvalid <= '1';
            m_axis_NCO_tready <= '1';
            s_axis_data_tready <= '0';
            m_axis_data_tvalid <= '0';
        elsif rising_edge(aclk) then
            case (status) is
                when IDLE =>
                    en <= '0';
                    s_axis_data_tready <= m_axis_data_tready;
                    m_axis_data_tvalid <= '0';
                    if s_axis_data_tvalid = '1' and m_axis_data_tready = '1' then
                        status <= ACTIVE;
                    end if;
                when ACTIVE =>
                    en <= '1';
                    m_axis_data_tvalid <= '1';
                    s_axis_NCO_tdata(27 downto 0) <= std_logic_vector(phase_acum(31 downto 4));
                    multi_out := (signed(s_axis_data_tdata)*signed(m_axis_NCO_tdata(15 downto 8))*signed(s_axis_data_tdata)*signed(m_axis_NCO_tdata(7 downto 0)));
                    debug_mult_out <= std_logic_vector(multi_out); 
                    phase_acum <= phase_acum + multi_out; --step size is 1/32
                    debug_phase_out <= std_logic_vector(phase_acum);
                    if s_axis_data_tvalid = '0' or m_axis_data_tready = '0' then
                        status <= IDLE;
                    end if;
            end case;
        end if;
    end process;
end Behavioral;

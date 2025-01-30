----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Mark Blair
-- 
-- Create Date: 01/15/2025 11:54:32 AM
-- Design Name: 
-- Module Name: osci_ipc_tb - Behavioral
-- Project Name: oscillator using ipcore
-- Target Devices: 
-- Tool Versions: 
-- Description: Testing to see if I can create an oscillator using ipcores instead of manually designing one.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity osci_ipc_tb is
    --  Port ( );
end osci_ipc_tb;

architecture Behavioral of osci_ipc_tb is
    --control signals
    signal aclk : std_logic := '0';
    signal rstn : std_logic := '0';

    --rx signals
    signal    m_axis_rx_tvalid : STD_LOGIC;
    signal    m_axis_rx_tdata : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal    m_axis_rx_tready : STD_LOGIC;

    --costas loop signals
    signal m_axis_CL_tvalid: std_logic;
    signal m_axis_CL_tready: std_logic := '1';
    signal m_axis_CL_tdata: std_logic_vector (7 downto 0);
    signal debug_phase: std_logic_vector (31 downto 0);
    signal debug_mult_out: std_logic_vector (27 downto 0);

    component costas_loop
        Port (aclk, rstn: in std_logic;
             s_axis_data_tvalid: in std_logic;
             s_axis_data_tready: out std_logic;
             s_axis_data_tdata: in std_logic_vector (7 downto 0);
             m_axis_data_tvalid: out std_logic;
             m_axis_data_tready: in std_logic;
             m_axis_data_tdata: out std_logic_vector(7 downto 0);
             debug_phase_out: out std_logic_vector (31 downto 0);
             debug_mult_out: out std_logic_vector(27 downto 0)
            );
    end component;
    COMPONENT dds_compiler_0
        PORT (
            aclk : IN STD_LOGIC;
            m_axis_data_tvalid : OUT STD_LOGIC;
            m_axis_data_tready : IN STD_LOGIC;
            m_axis_data_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
        );
    END COMPONENT;
begin
    costas_loop_DUT: costas_loop port map(aclk => aclk, rstn => rstn,
                 s_axis_data_tvalid => m_axis_rx_tvalid, s_axis_data_tready => m_axis_rx_tready, s_axis_data_tdata => m_axis_rx_tdata,
                 m_axis_data_tvalid => m_axis_CL_tvalid, m_axis_data_tready => m_axis_CL_tready, m_axis_data_tdata => m_axis_CL_tdata, debug_phase_out => debug_phase, debug_mult_out => debug_mult_out
                );
    dds_dut : dds_compiler_0
        PORT MAP (
            aclk => aclk,
            m_axis_data_tvalid => m_axis_rx_tvalid,
            m_axis_data_tready => m_axis_rx_tready,
            m_axis_data_tdata => m_axis_rx_tdata
        );
    dut: process
    begin
        wait for 4 ns;
        rstn <= '1';
        wait for 3000 ns;
    end process;
    file_Writing: process(aclk)
        file source_file : text open write_mode is
 "error.txt";
        variable row : line;
    begin
        if rising_edge(aclk) then
            write(row, debug_mult_out, right, 32);
            writeline(source_file, row);
        end if;
    end process;
    process(aclk)
    begin
        aclk <= not aclk after 2 ns;
    end process;
end Behavioral;

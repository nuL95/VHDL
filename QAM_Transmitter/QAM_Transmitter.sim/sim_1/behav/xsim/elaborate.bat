@echo off
REM ****************************************************************************
REM Vivado (TM) v2021.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Fri Jan 24 10:02:53 -0800 2025
REM SW Build 3367213 on Tue Oct 19 02:48:09 MDT 2021
REM
REM IP Build 3369179 on Thu Oct 21 08:25:16 MDT 2021
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab --incr --debug typical --relax --mt 2 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L xbip_pipe_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_17 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_dsp48_addsub_v3_0_6 -L xbip_dsp48_multadd_v3_0_6 -L dds_compiler_v6_0_21 -L fir_compiler_v7_2_17 -L secureip -L xpm --snapshot QAM_Transmitter_TB_behav xil_defaultlib.QAM_Transmitter_TB -log elaborate.log"
call xelab  --incr --debug typical --relax --mt 2 -L xil_defaultlib -L xbip_utils_v3_0_10 -L axi_utils_v2_0_6 -L xbip_pipe_v3_0_6 -L xbip_bram18k_v3_0_6 -L mult_gen_v12_0_17 -L xbip_dsp48_wrapper_v3_0_4 -L xbip_dsp48_addsub_v3_0_6 -L xbip_dsp48_multadd_v3_0_6 -L dds_compiler_v6_0_21 -L fir_compiler_v7_2_17 -L secureip -L xpm --snapshot QAM_Transmitter_TB_behav xil_defaultlib.QAM_Transmitter_TB -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0

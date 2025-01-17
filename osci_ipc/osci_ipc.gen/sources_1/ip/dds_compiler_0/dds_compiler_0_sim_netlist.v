// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.2 (win64) Build 3367213 Tue Oct 19 02:48:09 MDT 2021
// Date        : Fri Jan 17 10:58:06 2025
// Host        : DESKTOP-IIQHOR6 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/Mark/Desktop/review/VHDL/osci_ipc/osci_ipc.gen/sources_1/ip/dds_compiler_0/dds_compiler_0_sim_netlist.v
// Design      : dds_compiler_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k70tfbv676-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dds_compiler_0,dds_compiler_v6_0_21,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dds_compiler_v6_0_21,Vivado 2021.2" *) 
(* NotValidForBitStream *)
module dds_compiler_0
   (aclk,
    m_axis_data_tvalid,
    m_axis_data_tdata,
    m_axis_phase_tvalid,
    m_axis_phase_tdata);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_PHASE:S_AXIS_CONFIG:M_AXIS_DATA:S_AXIS_PHASE, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_DATA, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_data_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_DATA TDATA" *) output [15:0]m_axis_data_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TVALID" *) (* x_interface_parameter = "XIL_INTERFACENAME M_AXIS_PHASE, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) output m_axis_phase_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 M_AXIS_PHASE TDATA" *) output [31:0]m_axis_phase_tdata;

  wire aclk;
  wire [15:0]m_axis_data_tdata;
  wire m_axis_data_tvalid;
  wire [31:0]m_axis_phase_tdata;
  wire m_axis_phase_tvalid;
  wire NLW_U0_debug_axi_resync_in_UNCONNECTED;
  wire NLW_U0_debug_core_nd_UNCONNECTED;
  wire NLW_U0_debug_phase_nd_UNCONNECTED;
  wire NLW_U0_event_phase_in_invalid_UNCONNECTED;
  wire NLW_U0_event_pinc_invalid_UNCONNECTED;
  wire NLW_U0_event_poff_invalid_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_missing_UNCONNECTED;
  wire NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED;
  wire NLW_U0_m_axis_data_tlast_UNCONNECTED;
  wire NLW_U0_m_axis_phase_tlast_UNCONNECTED;
  wire NLW_U0_s_axis_config_tready_UNCONNECTED;
  wire NLW_U0_s_axis_phase_tready_UNCONNECTED;
  wire [0:0]NLW_U0_debug_axi_chan_in_UNCONNECTED;
  wire [27:0]NLW_U0_debug_axi_pinc_in_UNCONNECTED;
  wire [27:0]NLW_U0_debug_axi_poff_in_UNCONNECTED;
  wire [27:0]NLW_U0_debug_phase_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_data_tuser_UNCONNECTED;
  wire [0:0]NLW_U0_m_axis_phase_tuser_UNCONNECTED;

  (* C_ACCUMULATOR_WIDTH = "28" *) 
  (* C_AMPLITUDE = "0" *) 
  (* C_CHANNELS = "1" *) 
  (* C_CHAN_WIDTH = "1" *) 
  (* C_DEBUG_INTERFACE = "0" *) 
  (* C_HAS_ACLKEN = "0" *) 
  (* C_HAS_ARESETN = "0" *) 
  (* C_HAS_M_DATA = "1" *) 
  (* C_HAS_M_PHASE = "1" *) 
  (* C_HAS_PHASEGEN = "1" *) 
  (* C_HAS_PHASE_OUT = "1" *) 
  (* C_HAS_SINCOS = "1" *) 
  (* C_HAS_S_CONFIG = "0" *) 
  (* C_HAS_S_PHASE = "0" *) 
  (* C_HAS_TLAST = "0" *) 
  (* C_HAS_TREADY = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MODE_OF_OPERATION = "0" *) 
  (* C_MODULUS = "9" *) 
  (* C_M_DATA_HAS_TUSER = "0" *) 
  (* C_M_DATA_TDATA_WIDTH = "16" *) 
  (* C_M_DATA_TUSER_WIDTH = "1" *) 
  (* C_M_PHASE_HAS_TUSER = "0" *) 
  (* C_M_PHASE_TDATA_WIDTH = "32" *) 
  (* C_M_PHASE_TUSER_WIDTH = "1" *) 
  (* C_NEGATIVE_COSINE = "0" *) 
  (* C_NEGATIVE_SINE = "0" *) 
  (* C_NOISE_SHAPING = "0" *) 
  (* C_OPTIMISE_GOAL = "0" *) 
  (* C_OUTPUTS_REQUIRED = "2" *) 
  (* C_OUTPUT_FORM = "0" *) 
  (* C_OUTPUT_WIDTH = "8" *) 
  (* C_PHASE_ANGLE_WIDTH = "8" *) 
  (* C_PHASE_INCREMENT = "2" *) 
  (* C_PHASE_INCREMENT_VALUE = "1100110011001100110011001,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_PHASE_OFFSET = "0" *) 
  (* C_PHASE_OFFSET_VALUE = "0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0" *) 
  (* C_POR_MODE = "0" *) 
  (* C_RESYNC = "0" *) 
  (* C_S_CONFIG_SYNC_MODE = "0" *) 
  (* C_S_CONFIG_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_HAS_TUSER = "0" *) 
  (* C_S_PHASE_TDATA_WIDTH = "1" *) 
  (* C_S_PHASE_TUSER_WIDTH = "1" *) 
  (* C_USE_DSP48 = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  dds_compiler_0_dds_compiler_v6_0_21 U0
       (.aclk(aclk),
        .aclken(1'b1),
        .aresetn(1'b1),
        .debug_axi_chan_in(NLW_U0_debug_axi_chan_in_UNCONNECTED[0]),
        .debug_axi_pinc_in(NLW_U0_debug_axi_pinc_in_UNCONNECTED[27:0]),
        .debug_axi_poff_in(NLW_U0_debug_axi_poff_in_UNCONNECTED[27:0]),
        .debug_axi_resync_in(NLW_U0_debug_axi_resync_in_UNCONNECTED),
        .debug_core_nd(NLW_U0_debug_core_nd_UNCONNECTED),
        .debug_phase(NLW_U0_debug_phase_UNCONNECTED[27:0]),
        .debug_phase_nd(NLW_U0_debug_phase_nd_UNCONNECTED),
        .event_phase_in_invalid(NLW_U0_event_phase_in_invalid_UNCONNECTED),
        .event_pinc_invalid(NLW_U0_event_pinc_invalid_UNCONNECTED),
        .event_poff_invalid(NLW_U0_event_poff_invalid_UNCONNECTED),
        .event_s_config_tlast_missing(NLW_U0_event_s_config_tlast_missing_UNCONNECTED),
        .event_s_config_tlast_unexpected(NLW_U0_event_s_config_tlast_unexpected_UNCONNECTED),
        .event_s_phase_chanid_incorrect(NLW_U0_event_s_phase_chanid_incorrect_UNCONNECTED),
        .event_s_phase_tlast_missing(NLW_U0_event_s_phase_tlast_missing_UNCONNECTED),
        .event_s_phase_tlast_unexpected(NLW_U0_event_s_phase_tlast_unexpected_UNCONNECTED),
        .m_axis_data_tdata(m_axis_data_tdata),
        .m_axis_data_tlast(NLW_U0_m_axis_data_tlast_UNCONNECTED),
        .m_axis_data_tready(1'b0),
        .m_axis_data_tuser(NLW_U0_m_axis_data_tuser_UNCONNECTED[0]),
        .m_axis_data_tvalid(m_axis_data_tvalid),
        .m_axis_phase_tdata(m_axis_phase_tdata),
        .m_axis_phase_tlast(NLW_U0_m_axis_phase_tlast_UNCONNECTED),
        .m_axis_phase_tready(1'b0),
        .m_axis_phase_tuser(NLW_U0_m_axis_phase_tuser_UNCONNECTED[0]),
        .m_axis_phase_tvalid(m_axis_phase_tvalid),
        .s_axis_config_tdata(1'b0),
        .s_axis_config_tlast(1'b0),
        .s_axis_config_tready(NLW_U0_s_axis_config_tready_UNCONNECTED),
        .s_axis_config_tvalid(1'b0),
        .s_axis_phase_tdata(1'b0),
        .s_axis_phase_tlast(1'b0),
        .s_axis_phase_tready(NLW_U0_s_axis_phase_tready_UNCONNECTED),
        .s_axis_phase_tuser(1'b0),
        .s_axis_phase_tvalid(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2021.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C3FJCcOXv/ooHWXTaSsUzuG3LCea1kFLhxiMEs1WHRvlllAUbVeovr7CzPBNjUvjqE0CwBr5JiFE
C98wCkBbnKHiuK1l2Cju06e2FnPQSqFZEpJIDaNx4eFQT1Ntf21Z6FxvgyiC/lwA4L+CeSQ4t/AB
PPa1c5L1IbgGQyC6BPc=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
PR+lz4aMEKM9jrwzh+cxLBb7oOFENpi6VKQVg5Z/auNLefQHlDN37vC6NupkmzIMOQaMv4vwG5ED
ypm8ux97czVF/jpdAnLCui3yHt0tfpn3xaR8pw3L9GLqjc13xG8b2ADdgq5W73HbR5XAixq+jrWz
T6ZmunIwF7WjiPPBo+ApufR0FldATHNyygYVALlmAuzYNw47XQHFauhl7hvjYJMA5vASevWa9fgO
3hXOQ9C/ifBoIzCb9ro18xQmSPsQMQiuBGFPOAWPF04725QKrFBqFd31Pnf0BzSL+Q+NUi+HqP1N
aV1w8YhH42UnpawE+OIBz2tJ0gTuoerzm5z0sg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
p9SKDXb40dnTTd2nvmR4vnYN/ML2bYNHea2usUOM2yTyTFZFzFMjOAuCEaoV3BxLFthJz7U/9u0U
KkHHY5Gbiajc7hxRdFMD9jV3lwJzhgLJ3YNKDuH4+LnTNPiRPOvbiIe1F41R20K91mj8kbc+nVML
6hebVzjaOUp7NyToXK0=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FgimluZxnvdEwXNzvxOrVzW6WbGn97hS1VfgtcQyrR5x1hRzh5UzLLAiE05ffMyxrm5sudFSqsQl
ycovUBKRSzp8iO9QRHi/b9c2qvT7BwbP2MC7XmpNUBZASI9zbxFvlqbPg3y7FzY8IvGL3RRmfsOh
akAIp1EedMdbi8uJEdip0Ui0Z7xM8RKU7mVbeFVXwkThF6mKbdlhGEE9mjrbJHHXfXOe6CRDTf8g
6Bvuvx1w7n7z6h9ct6+qFvPooLI00LdIS8rcZTO05DOVMx+jfnFBAmRcgZLSJfpcTAbkgOjQ1Usq
vFnsxHK0EdaH0+wQIf/MK3BUAKsv0R3qW5/bjw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
QnAu/tvx0LgmGaZYyZOz27UGo+0WqoxABx9zk70WodyIaYuhIEUVlt3043lkL23jtD0uvchd2/Ac
VjmGdVWwwebMzniiO6xZhPWxSI7Lk3pvad59I3SSwW8SOxujEXMEcNZxL6vykjhziYAEBIfnjcOt
HvDrINdsZMgk6VyntHh2Yxvb5UPBpsOgFp/XNvSx730KyZoUhEhPUwaPiEWe6Cz0yvOJQ1zzfuqI
zp0UxCp84Y5spIU4Nr7U+gfQKcjVtTJTSG9sQvrUAOWchemR0+X+RGHfnPe8DptbKpeS51osQvxN
JkldgdZJSWeUxc9qwScfwvGEZ82dwe3on8SiwA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_01", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GFGvd84O+J1dml9ZOPmc3ZO76c7DMotBGPA3S4MXl8w595G/S/aV23N90H91I71VDP80staPsAD7
6qyBWuIulcHOkyr6QHFtAeL9BiDKEBvKcKY8LkKYc0Jqtgq9oYpqDsQ0V8bBc2C3kv33H3Z7Fn2r
ZwGokq9JZBaSF7o2GG5oNPrDokq3szauslCcju/cA5pVAyUdolPNrNTOhqLUPdIjTt9XFtFviRsO
oghSId+t+3tKN31FYcSjLvAXWQAdCJKZ3s/5Kr2M5km/njceqoXY/nFIFXx6B3W6RLuNMEH5i43S
kTGZWORNUuElamGzToa/NQtTZTU+JgEuzdOYgw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
C+cTCnJcow6trrWkCuGK/j2MpXSbgGSqEZH77Bvr15o/N0MlEzb3EhgIwtR0is4cHe2OFfXgcuh9
cxJpBZ6f346B8x6uuUDbQrZPIcUalCIoMih/AEMoYWsj6k+LZLdozPAspnWe3qdSIEMZh30audRL
9nLm78MkNBjnP/9MTHQcmkBYY12c+8IFip0PAqa/EbdgHLpVGrwbOElGyw8QRKozgds5bgMzdXIH
5qr6PVpCEQNjVqF2UFS6bFbar3hfrzvHVd0ZXCIuwwiNiigd798rUJMiLJO5uFjA3Ma2I0qpxSOw
wXKGHfw0hEjZ98b5GEuu6cBsoSEkWnjmece64w==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
NSTrEXT7eTCefIQjxNa6ganxpjQjVP1sXenVfL93XqcEWQ2ZZCBWi3EPevkgxkI2Jiz/RBNi6lGO
3L8us7xA7HC/dI8Dp+XiZ2qxBDh0CGPH3J+CYSkhK8OeOIc+RZjsbVtrxAZr1bbwvRt17s/d4RYN
dXwCucBL2EWMOkXFqZatHDEY5y4CLM0sIx/U1jiFJ43Y9hmApftEXaiayjzX7WJS41EqhT4qwVXZ
riwhDgibLNTZEBZpQZIXuzzcAUEIxVRXoAJbrwmOVr1gBUN8TlOzNmuvr3WkkSoK+OQEp9OSJK4D
RvkifSbyJx2IQbOcJ06qKz3A3g0OYpmASsoTzHi7J9Kn6+64KZynxncdO25+7nXbNflRa1qH3Uo+
2bZtRJXbBMPdd9n5N5willAtidC4Jken6AsCDOeym3s7ie9xyNzSvH87Wxrej7IA59c5rxK0IYO4
mqnuv/1J/21N0VIqtKopjgOdB6pZj1B7abfaqjMm+g/iXa1QPffrMawC

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
e24Ac2eoCzH4d2MGDNjllrsz302JWX7SHmHY4ZeqELsJGYMPdwmKEbabeI3yvuORUVgvLtlk0dCL
2ksTyI8O69mMICGIwp6B/1FoqxHpr8UH8nRiFk2Ljy7ZwrtKbSNgbf9yGCY8ly/53F4WV5PRjv8I
zmU3oN+s0krwTrhWYXE81mI5k96nJHt15YTTIYDgDU7ysC+gLLHYgkkKlqeavAZWInINVY5pNruw
mIllybKlTMyeuO5hnECXVAq3TCgO8xBlsIEZd7GQASsc6GIlFuQqAW/vknNbsU1n02oklkdvqp3+
2Vym+T4DrCmmDbzEhHEANWvGEa2cG0C9fW3sjg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
bnmA6lCw18roQ4AvT0/S9Z/nWzWzP68BjUJL495/8Y5WtCdm+y2GUDBR9qkgfJlG5NKB2QkS2T0z
R2qRsxcjnqY21wvgtNg9Tvy7B/GGNNu/RfNHE+ePoLROJBtkzh5lQyUJwIeXhBGGE0oxF6VY9YDE
85/4K1XZNKlm7ZZqBSM+kDeYrfQblv/WdhwdvdDFRe069HxGbrDGlWaqKXyTJfTHO5ES5RyBC8id
EACICXw7y1qCi99U8Myj6y6MoC8QFegdbImwZv0WHl3yA2avzaOZbax1AtO3Bv4CPgU7Se8OjykB
uJA4oKWk0rXrmA5pW4NDEaWKHQJnFyvrRzgbuA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
B63p2uG24mbqK2evOt6gCxWht8ZOxcztlIrSsWk7nSCWoziw1p8o03X42gWL4+RTjrBIVq7oetV5
9lq9otUWXEXP3BMst04BG4sbgjpHtUeYawxon4WyQu7lfY+dxucdS/sqOonAGlgz59yv8E/lKPdU
t8PPMxEryEnesJke8UHvxt3NDPdvfC/MBjfwyJ2DKvhC6LrL4lXqWkUMfNFNB5Gxss6ICSGenrs5
YXuP3kLsPAtCjq2R8+fLcJ7AGu01iNNtD/fDDvUjW+Lv0hypY7LTiO5nH+K16QO/TGOUTg2PHeka
1KLLRr9aBgH63b/+PKCKDHe6K/99nzVvuxCqkA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 58960)
`pragma protect data_block
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
M+NGJ7c9yrcLzOEaUa8TXbJtUEyc4A==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif

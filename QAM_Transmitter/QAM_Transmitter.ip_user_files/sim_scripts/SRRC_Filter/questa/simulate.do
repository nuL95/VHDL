onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib SRRC_Filter_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {SRRC_Filter.udo}

run -all

quit -force

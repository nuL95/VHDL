onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib PLL_NCO_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {PLL_NCO.udo}

run -all

quit -force

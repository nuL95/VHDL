onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib SINCOS_GEN_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {SINCOS_GEN.udo}

run -all

quit -force

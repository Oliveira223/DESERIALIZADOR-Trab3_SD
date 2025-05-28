if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work ../../HDL/deserializer.sv

vlog -work work deserializer_tb.sv
vsim -voptargs=+acc work.deserializer_tb

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run -all

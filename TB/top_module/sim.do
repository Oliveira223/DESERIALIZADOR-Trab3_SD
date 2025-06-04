if {[file isdirectory work]} {vdel -all -lib work}
vlib work
vmap work work

vlog -work work ../../HDL/top_module.sv
vlog -work work ../../HDL/clock_divider.sv
vlog -work work ../../HDL/deserializer.sv
vlog -work work ../../HDL/queue.sv

vlog -work work top_module_tb.sv
vsim -voptargs=+acc work.top_module_tb

quietly set StdArithNoWarnings 1
quietly set StdVitalGlitchNoWarnings 1

do wave.do
run -all

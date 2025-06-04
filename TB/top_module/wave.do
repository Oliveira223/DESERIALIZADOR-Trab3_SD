onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate top_module_tb/reset
add wave -divider "Clocks"
add wave -noupdate top_module_tb/clock_1M
add wave -noupdate top_module_tb/DUT/clock_100k
add wave -noupdate top_module_tb/DUT/clock_10k

add wave -divider "Desserializer"
add wave -noupdate top_module_tb/data_in

add wave -noupdate top_module_tb/DUT/data_ready_des
add wave -noupdate top_module_tb/DUT/data_out_des

add wave -divider "Queue"
add wave -noupdate top_module_tb/DUT/data_out
add wave -noupdate top_module_tb/DUT/len_out
add wave -noupdate top_module_tb/DUT/status_out


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0} 0}
quietly wave cursor active 1

configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update

WaveRestoreZoom {0 ns} {200 ns}
view wave
WaveCollapseAll -1

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate clock_divider_tb/reset
add wave -noupdate clock_divider_tb/clock_1M
add wave -noupdate clock_divider_tb/clock_100k
add wave -noupdate clock_divider_tb/clock_10k
 
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {377768 ns} 0}
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
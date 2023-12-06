#after connecting FPGA to PC
close_hw_manager
open_hw
connect_hw_server
current_hw_target
open_hw_target



set bit_file [glob [file join $Impl *.bit]]

set_property PROBES.FILE {} [get_hw_devices xc7a200t_0]
set_property FULL_PROBES.FILE {} [get_hw_devices xc7a200t_0]
set_property PROGRAM.FILE $bit_file [get_hw_devices xc7a200t_0]
program_hw_devices [get_hw_devices xc7a200t_0]

refresh_hw_device [lindex [get_hw_devices xc7a200t_0] 0]

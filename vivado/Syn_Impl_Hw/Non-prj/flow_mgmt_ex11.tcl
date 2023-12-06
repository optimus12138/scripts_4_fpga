# flow_mgmt_ex11.tcl
read_edif [glob ./Sources/netlist/*.edn]
read_ip [glob ./Sources/ip/*.xcix]
read_xdc [glob ./Sources/xdc/*.xdc]
link_design -top wave_gen -part xc7k70tfbg676-1

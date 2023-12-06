# scan_strategy_project.tcl
set device             xc7k70t
set package            fbg676
set speed              -1
set part               $device$package$speed
set prj_name           wavegeny
set prj_dir            ./$prj_name
set src_dir            ./Sources
set flow              {Vivado Implementation 2020}
set rpt_strat         {Timing Closure Reports}

create_project $prj_name $prj_dir -part $part
add_file      [glob $src_dir/hdl/*.v]
add_file      [glob $src_dir/hdl/*.vh]
add_file      [glob $src_dir/ip/*.xcix]
update_compile_order -fileset sources_1

add_file -fileset constrs_1 [glob $src_dir/xdc/*.xdc]

add_file -fileset sim_1 [glob $src_dir/tb/*.v]
update_compile_order -fileset sim_1

set_param general.maxThreads 6
set_property REPORT_STRATEGY $rpt_strat [get_runs impl_1]

set strat [list \
    Performance_Explore \
    Performance_WLBlockPlacement \
    Performance_NetDelay_high \
    Performance_ExtraTimingOpt \
    Area_Explore \
]

launch_runs synth_1
wait_on_run synth_1
foreach i_strat $strat {
    create_run impl_${i_strat} -parent_run synth_1 \
        -flow $flow -strategy $i_strat -report_strategy $rpt_strat
}
launch_runs [get_runs impl*] -jobs [llength $strat]
start_gui

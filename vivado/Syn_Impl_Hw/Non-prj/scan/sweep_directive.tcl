# sweep_directive.tcl
set src_dir ./Sources
set res_dir ./SweepOutputDir
set dcp_name wave_gen_opt.dcp
set opt_dcp [glob $src_dir/post_opt/$dcp_name]
set place_drtv {Default Explore ExtraNetDelay_high}
set phys_opt_drtv {Default Explore AggressiveExplore}
set route_drtv {Default Explore NoTimingRelaxation}

set fid [open $res_dir/compare_report.csv w]
puts $fid [join {place_design phys_opt_design route_design} ,]

foreach i_p $place_drtv i_ph $phys_opt_drtv i_r $route_drtv {
    set x {}
    open_checkpoint $opt_dcp
    place_design -directive $i_p > $res_dir/place_${i_p}.log
    set i_x [sweep_directive_ns::get_timing_info $res_dir place $i_p] 
    lappend x $i_p|[join $i_x |]

    phys_opt_design -directive $i_ph > $res_dir/phys_opt_${i_ph}.log
    set i_x [sweep_directive_ns::get_timing_info $res_dir phys_opt $i_ph]
    lappend x $i_ph|[join $i_x |]

    route_design -directive $i_r > $res_dir/route_${i_r}.log
    set i_x [sweep_directive_ns::get_timing_info $res_dir route $i_r]
    lappend x $i_r|[join $i_x |]

    close_design
    puts $fid [join $x ,]
}
close $fid





namespace eval run {
    # Generate dcp for specific phase
    # phase: synth_design, opt_design, place_design
    # phys_opt_design(AP:after place)
    # route_design 
    # phys_opt_design(AR:after routing)
    proc gen_dcp {phase dir dcp_name} {
        write_checkpoint -force $dir/$dcp_name
        puts "*****$phase: DCP is successfully generated!*****"
    }

    proc design_analysis {phase dir fn} {
        report_timing_summary -file $dir/${fn}_timing_summary.rpt
        report_utilization -file $dir/${fn}_util.rpt
        puts "*****$phase: design analysis is done!*****"
    } 
}

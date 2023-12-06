# sweep_directive_ns.tcl
namespace eval sweep_directive_ns {
    proc get_timing_info {dir phase drtv} {
        set tps [get_timing_paths -max_paths 100 -setup]
        set wns [get_property SLACK [lindex $tps 0]]
        set tph [get_timing_paths -max_paths 100 -hold]
        set whs [get_property SLACK [lindex $tps 0]]
        report_timing_summary -file $dir/${phase}_${drtv}_timing_summary.rpt
        return [list $wns $whs]
    }
}


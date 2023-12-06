# run_synth_v3.tcl
# Read sources (RTL IP & constraints)
set phase synth_design
set fn post_synth_${date}
# Run synthesis top module  
synth_design -top $top -part $part -directive $synDtv
# Gen dcp
if {$synDcp==1} {
    run::gen_dcp $phase $SynOutputDir $fn
}
if {$synAna==1} {
    run::design_analysis $phase $SynOutputDir $fn
}


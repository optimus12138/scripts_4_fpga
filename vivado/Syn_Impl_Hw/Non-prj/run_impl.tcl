# run_impl_v3.tcl
set impl_cmd \
    [list opt_design place_design phys_opt_design route_design]
set impl_dtv \
    [list $optDtv $placeDtv $physOptDtvAp $routeDtv]
set impl_dcp \
    [list $optDcp $placeDcp $physOptApDcp $routeDcp]
set impl_ana \
    [list $optAna $placeAna $physOptApAna $routeAna]

foreach i_cmd $impl_cmd i_dtv $impl_dtv i_dcp $impl_dcp i_ana $impl_ana {
    $i_cmd -directive $i_dtv
    puts "*******$i_cmd is successfully done!*********"
    if {$i_dcp==1} {
        run::gen_dcp $i_cmd \
            $ImplOutputDir post_${i_cmd}_${date}
    }
    if {$i_ana==1} {
        run::design_analysis $i_cmd \
            $ImplOutputDir post_${i_cmd}_${date}
    }

} 
if {$physOptArEn==1} {
    phys_opt_design -directive $physOptDtvAr
    if {$physOptArDcp==1} {
        run::gen_dcp phys_opt_design(AR) \
            $ImplOutputDir post_phys_opt_design_Ar_${date}
    }
    if {$physOptArAna==1} {
        run::design_analysis phys_opt_design(AR) \
        $ImplOutputDir post_phys_opt_design_Ar_${date}
    }
}

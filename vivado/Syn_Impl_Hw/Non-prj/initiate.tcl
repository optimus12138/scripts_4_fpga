file delete -force ./.Xil

set Impl "./ImplOutputDir"
set Syn "./SynOutputDir"

if {[file exist $Impl]} {
file delete -force $Impl
file mkdir $Impl
} else {
    file mkdir $Impl
}


if {[file exist $Syn]} {
file delete -force $Syn
file mkdir $Syn
}  else {
    file mkdir $Syn
}

puts "***initiation done***"
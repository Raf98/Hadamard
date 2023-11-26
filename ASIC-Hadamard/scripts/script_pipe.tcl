
########################################################
## Include TCL utility scripts..
########################################################

include load_etc.tcl

##############################################################################
## Preset global variables and attributes
##############################################################################

set DESIGN  HadamardCombinational


set_attribute lib_search_path {. /cadence/Library/NangateOpenCellLib_45nm/Front_End/Liberty/CCS/  /cadence/Library/NangateOpenCellLib_45nm/Back_End/lef/} /
set_attribute hdl_search_path { ../HadamardPipeline } /
set_attribute lp_power_unit mW /



###############################################################
## Library setup
###############################################################
set_attribute library {NangateOpenCellLibrary_typical_ccs.lib}
set_attribute lef_library { NangateOpenCellLibrary.tech.lef NangateOpenCellLibrary.lef}    


####################################################################
## Load RTL Design verilog or vhdl, (create a single top file to call all others)
####################################################################
puts "Reading HDLs..."

read_hdl -vhdl {HadamardPackage.vhd FullAdder.vhd Mux.vhd MuxMulti.vhd RippleCarry.vhd ShiftRight.vhd Register.vhd RegisterBarrier.vhd HadamardPipeline.vhd}
 
puts "Elaborate Design..."
elaborate $DESIGN 
puts "Runtime & Memory after 'read_hdl'"
timestat Elaboration 

check_design -unresolved 

####################################################################
## Constraints Setup
####################################################################
puts "Setting uo constraints..."
read_sdc ../scripts/constraints.sdc

report timing -lint


################################################################################
## Power Directives
################################################################################

set_attribute lp_power_analysis_effort medium


build_rtl_power_models -clean_up_netlist -design $DESIGN


####################################################################################################
## Synthesizing 
####################################################################################################
synthesize -to_generic -eff medium

synthesize -to_mapped -eff medium -no_incr

synthesize -to_mapped -eff medium -incr   

check_design -all


#############################################################################
## Reports & Results
#############################################################################

report area -depth 3
report power -depth 2
report qor

puts "Final Runtime & Memory."
timestat FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

#quit

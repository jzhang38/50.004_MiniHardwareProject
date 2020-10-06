set projDir "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/vivado"
set projName "MiniHardwareProject"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/au_top_0.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/incrementer_1.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/reset_conditioner_2.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/three_bits_adder_3.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/counter_4.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/edge_detector_5.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/full_adder_6.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/button_conditioner_7.v" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/verilog/pipeline_8.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/constraint/avoid_error.xdc" "C:/Users/23945/Documents/AlchitryProjects/MiniHardwareProject/work/constraint/custom.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

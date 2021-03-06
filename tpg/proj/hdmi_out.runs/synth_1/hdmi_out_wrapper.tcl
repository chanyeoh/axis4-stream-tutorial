# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7z010clg400-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/axis_tut/tpg/proj/hdmi_out.cache/wt [current_project]
set_property parent.project_path C:/axis_tut/tpg/proj/hdmi_out.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_repo_paths {
  c:/axis_tut/ip_repo
  c:/axis_tut/tpg/repo
} [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
add_files C:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/hdmi_out.bd
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_axi_gpio_hdmi_0/hdmi_out_axi_gpio_hdmi_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_axi_gpio_hdmi_0/hdmi_out_axi_gpio_hdmi_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_axi_gpio_hdmi_0/hdmi_out_axi_gpio_hdmi_0.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_proc_sys_reset_0_0/hdmi_out_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_proc_sys_reset_0_0/hdmi_out_proc_sys_reset_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_proc_sys_reset_0_0/hdmi_out_proc_sys_reset_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_processing_system7_0_0/hdmi_out_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_xbar_0/hdmi_out_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_rgb2dvi_0_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_rgb2dvi_0_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_v_axi4s_vid_out_0_0/hdmi_out_v_axi4s_vid_out_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_v_axi4s_vid_out_0_0/hdmi_out_v_axi4s_vid_out_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_v_tc_0_0/hdmi_out_v_tc_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_v_tc_0_0/hdmi_out_v_tc_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/ip/hdmi_out_auto_pc_0/hdmi_out_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/hdmi_out_ooc.xdc]
set_property is_locked true [get_files C:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/hdmi_out.bd]

read_vhdl -library xil_defaultlib C:/axis_tut/tpg/proj/hdmi_out.srcs/sources_1/bd/hdmi_out/hdl/hdmi_out_wrapper.vhd
read_xdc C:/axis_tut/tpg/src/constraints/ZYBO_Master.xdc
set_property used_in_implementation false [get_files C:/axis_tut/tpg/src/constraints/ZYBO_Master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
synth_design -top hdmi_out_wrapper -part xc7z010clg400-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off
write_checkpoint -noxdef hdmi_out_wrapper.dcp
catch { report_utilization -file hdmi_out_wrapper_utilization_synth.rpt -pb hdmi_out_wrapper_utilization_synth.pb }

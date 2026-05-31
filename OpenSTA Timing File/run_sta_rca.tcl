read_liberty sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog rca_netlist.v
link_design rca
read_sdc constraints.sdc
report_timing -path_type full -digits 3
report_wns
report_tns
exit

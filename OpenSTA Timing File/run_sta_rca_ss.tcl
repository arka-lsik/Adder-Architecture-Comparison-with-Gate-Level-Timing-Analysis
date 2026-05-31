#SS coner for ripple carry adder

read_liberty sky130_fd_sc_hd__ss_100C_1v60.lib
read_verilog rca_netlist.v
link_design rca
read_sdc constraints.sdc
report_checks -path_delay max -digits 3
report_wns
report_tns
exit

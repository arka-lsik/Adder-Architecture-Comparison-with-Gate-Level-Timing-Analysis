read_verilog cla.v
hierarchy -check -top rca
proc; opt; techmap; opt
dfflibmap -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty sky130_fd_sc_hd__tt_025C_1v80.lib
clean
write_verilog -noattr rca_netlist.v
stat

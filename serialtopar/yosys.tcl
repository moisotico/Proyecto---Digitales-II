 #!/usr/local/bin/tclsh
# read design 
yosys read_verilog $::env(VLOG_FILE_NAME)
# elaborate design hierarchy
yosys hierarchy -check -top $::env(TOP_MODULE)
#high-level synthesis
yosys proc
yosys opt
yosys fsm
yosys opt
yosys memory
yosys opt
#mapping to internal cell library
yosys techmap
yosys opt
# mapping flip-flops to mycells.lib
yosys dfflibmap -liberty $::env(LIB)
#mapping logic to mycells.lib
yosys abc -liberty $::env(LIB)
#clean up
yosys clean
#write synthetized design
yosys write_verilog $::env(OUTPUT_SYNTH)

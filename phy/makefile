# makefile for TAREA6 IE0523
# @Author Giancarlo Marin H.
# @Date 29/05/2019
# @Brief UCR - IE0523 - makefile del phy para el pcie

# Tags de Variables de Programa
CC := iverilog
CC_SYNTH := yosys
CC_RUN := vvp
VISUAL := gtkwave
SRC = yosys.tcl

# Tags de Variables de modulo con valores por defecto 
TARGET_TOP := phy.v
TARGET_VIS := config.gtkw
OUTPUT_SIM := phy.out
export LIB := cmos_cells.lib
export VLOG_FILE_NAME := phy.v
NEW_VLOG_FILE_NAME = phy_synth.v
export TOP_MODULE := phy
NEW_TOP_MODULE = phy_synth
export OUTPUT_SYNTH = phy_synth.v

.PHONY: clean

autoinst_verilog: 
	emacs-tealeg --batch --no-site-file -l verilog-mode.el tb.v phy.v -f verilog-auto -f save-buffer

assign_tb: 
	$(eval TARGET_TOP = tb.v)

all: compile synth rename rename2 clean
	$(MAKE) tb
	@echo 'All Done'

compile:
	@echo 'Compiling Design $(TARGET_TOP)'
	$(CC) $(TARGET_TOP) -o $(OUTPUT_SIM)

run: 
	@echo 'Running Design $(TARGET_TOP)'
	$(CC_RUN) $(OUTPUT_SIM)

sim: 
	@echo 'Show simulation on GTKWave $(TARGET_VIS)'
	$(VISUAL) $(TARGET_VIS) &

synth:
	@echo 'Synthetizing module $(TOP_MODULE) with $(LIB)'
	$(CC_SYNTH)	-c 	$(SRC)

rename:
	@echo 'Renaming module $(NEW_TOP_MODULE)'
	sed -i 's/$(TOP_MODULE)/$(NEW_TOP_MODULE)/' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module mux/module mux_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module demux/module demux_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module bs/module bs_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module gen_clk/module gen_clk_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module partoserial/module partoserial_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module byte_unstripping/module byte_unstripping_synth/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/module serialtopar/module serialtopar_synth/g' $(NEW_VLOG_FILE_NAME)


rename2:
	sed -i 's/byte_unstripping byte_uns/byte_unstripping_synth byte_uns/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/demux demux0/demux_synth demux0/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/serialtopar line0/serialtopar_synth line0/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/serialtopar line1/serialtopar_synth line1/g' $(NEW_VLOG_FILE_NAME)
	
	sed -i 's/bs byte/bs_synth byte/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/mux mux0/mux_synth mux0/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/partoserial line0/partoserial_synth line0/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/partoserial line1/partoserial_synth line1/g' $(NEW_VLOG_FILE_NAME)
	sed -i 's/gen_clk clocks/gen_clk_synth clocks/g' $(NEW_VLOG_FILE_NAME)


tb: assign_tb compile run sim clean
	@echo 'Testbench tested'

clean: 
	rm *.out	
	@echo 'Clean dir succesful...'

$(V).SILENT:

# end

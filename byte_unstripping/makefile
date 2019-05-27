# @Date 14/05/2019
# @Brief UCR - IE0523 - Proyecto 1 - byte unstriping con 2 bits de valid en la entrada y uno en la salida

# Tags de Variables de Programa
CC := iverilog
CC_SYNTH := yosys
CC_RUN := vvp
VISUAL := gtkwave
YS = yosy.ys

# Tags de Variables de modulo con valores por defecto 
TOP_NAME := byte_unstripping
TARGET_TOP := byte_unstripping.v
TARGET_VIS := byte_unstripping.vcd
OUTPUT_SIM := bus.out
export LIB := cmos_cells.lib
export VLOG_FILE_NAME := byte_unstripping.v
NEW_VLOG_FILE_NAME = $(TOP_NAME)_synth.v
export TOP_MODULE := $(TOP_NAME) 
NEW_TOP_MODULE = $(TOP_NAME)_synth
export OUTPUT_SYNTH = $(TOP_NAME)_synth.v

.PHONY: clean

#autoinst_verilog: 
#	emacs-tealeg --batch --no-site-file -l verilog-mode.el tb.v -f verilog-auto -f save-buffer

assign_testbench:
	$(eval TARGET_TOP = testbench.v)

all: compile synth rename clean
	$(MAKE) testbench
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
	$(CC_SYNTH) $(YS)
rename:
	@echo 'Renaming module $(NEW_TOP_MODULE)'
	sed -i 's/$(TOP_MODULE)/$(NEW_TOP_MODULE)/' $(NEW_VLOG_FILE_NAME)

testbench: assign_testbench compile run sim clean
	@echo 'Testbench tested'

clean: 
	rm *.out	
	@echo 'Clean dir succesful...'

$(V).SILENT:

# end

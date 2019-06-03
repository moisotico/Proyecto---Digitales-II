# makefile for TAREA6 IE0523
# @Author Giancarlo Marin H.
# @Date 15/05/2019
# @Brief UCR - IE0523 - P1 - demux 1:2 de 7bits con bits de valid

# Tags de Variables de Programa
FLAGS := -C

# Tags de Variables de modulo con valores por defecto 
export DIR := phy/

.PHONY: clean

all: 
	$(MAKE) $(FLAGS) $(DIR) all

compile:
	$(MAKE) $(FLAGS) $(DIR) compile	

run: 
	$(MAKE) $(FLAGS) $(DIR) run		

sim: 
	$(MAKE) $(FLAGS) $(DIR) sim

synth:
	$(MAKE) $(FLAGS) $(DIR) synth

rename:
	$(MAKE) $(FLAGS) $(DIR) rename	

tb: 
	$(MAKE) $(FLAGS) $(DIR) tb	

clean: 
	$(MAKE) $(FLAGS) $(DIR) clean	

$(V).SILENT:

# end
NOMBRE=bancopruebas
BANCO=$(NOMBRE).v
SYNTH=partoserialSynth.v
VCD=$(NOMBRE).vcd
VC=iverilog

EJEC=banco
VR=vvp
FLAGSVC= -o $(EJEC)

FLAGSLIMP=rm *.vcd $(EJEC) *.dot *.pdf $(SYNTH)

YOSYS=yosys
YOSFILE=yosy.ys
GTKCONFIG=config.gtkw
GTK=gtkwave

ORIG=partoserial
FINAL=partoserialSynth
 

all: sintetizar compilar visualizar limpiar
	

sintetizar:
	$(YOSYS) $(YOSFILE)
	sed -i 's/$(ORIG)/$(FINAL)/g' $(SYNTH)
	sed -i '2i\`include "./CMOS/cmos_cells.v"\' $(SYNTH)
compilar:
	$(VC) $(BANCO) $(FLAGSVC)
	$(VR) $(EJEC)
visualizar:
	$(GTK) $(VCD) $(GTKCONFIG) 

limpiar: 
	$(FLAGSLIMP)


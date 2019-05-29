NOMBRE=bancopruebas
BANCO=$(NOMBRE).v
SYNTH=phy_txSynth.v
VCD=$(NOMBRE).vcd
VC=iverilog

EJEC=banco
VR=vvp
FLAGSVC= -o $(EJEC)

FLAGSLIMP=rm *.vcd $(EJEC) $(SYNTH)

YOSYS=yosys
YOSFILE=yosy.ys
GTKCONFIG=config.gtkw
GTK=gtkwave

ORIG=phy_tx
FINAL=phy_txSynth
 

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


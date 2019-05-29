NOMBRE=bancopruebas
BANCO=$(NOMBRE).v
SYNTH=phy_rxSynth.v
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

ORIG=phy_rx
FINAL=phy_rxSynth
 

all: sintetizar compilar visualizar limpiar
	

sintetizar:
	sed -i '1i\`include "gen_clk.v"\' phy_rx.v
	sed -i '1i\`include "demux.v"\' phy_rx.v
	sed -i '1i\`include "serialtopar.v"\' phy_rx.v
	sed -i '1i\`include "byte_unstripping.v"\' phy_rx.v
	$(YOSYS) $(YOSFILE)
	sed -i 's/$(ORIG)/$(FINAL)/g' $(SYNTH)
	sed -i '2i\`include "./CMOS/cmos_cells.v"\' $(SYNTH)
	sed -i '/`include "gen_clk.v"/d' phy_rx.v
	sed -i '/`include "demux.v"/d' phy_rx.v
	sed -i '/`include "serialtopar.v"/d' phy_rx.v
	sed -i '/`include "byte_unstripping.v"/d' phy_rx.v
	sed -i 's/cond/estruct/g' $(SYNTH)

compilar:
	$(VC) $(BANCO) $(FLAGSVC)
	$(VR) $(EJEC)
visualizar:
	$(GTK) $(VCD) $(GTKCONFIG) 

limpiar: 
	$(FLAGSLIMP)


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
	sed -i '1i\`include "gen_clk.v"\' phy_tx.v
	sed -i '1i\`include "mux.v"\' phy_tx.v
	sed -i '1i\`include "partoserial.v"\' phy_tx.v
	sed -i '1i\`include "bs.v"\' phy_tx.v
	$(YOSYS) $(YOSFILE)
	sed -i 's/$(ORIG)/$(FINAL)/g' $(SYNTH)
	sed -i '2i\`include "./CMOS/cmos_cells.v"\' $(SYNTH)
	sed -i '/`include "gen_clk.v"/d' phy_tx.v
	sed -i '/`include "mux.v"/d' phy_tx.v
	sed -i '/`include "partoserial.v"/d' phy_tx.v
	sed -i '/`include "bs.v"/d' phy_tx.v
	sed -i 's/cond/estruct/g' $(SYNTH)

compilar:
	$(VC) $(BANCO) $(FLAGSVC)
	$(VR) $(EJEC)
visualizar:
	$(GTK) $(VCD) $(GTKCONFIG) 

limpiar: 
	$(FLAGSLIMP)


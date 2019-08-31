transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/clockDivider.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/MipsMulticycle.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/ALUOperation.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Datapath.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/ControlBlock.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Registers/RegistersBank.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Registers/RegisterNBits.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/SignalExtension.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/Mux4x1.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/Mux2x1.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Miscellany/LeftShift.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Memory/Memory.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/Memory/bram.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/ALU/Logical.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/ALU/Arithmetic.vhd}
vcom -93 -work work {C:/Users/pedro/Documents/GitHub/INE5406/RelatorioIII/Source/ALU/ALU.vhd}


force /Clock_mips 1 0 ns, 0 10 ns -r 20 ns
force /clock_ram 1 0ns, 0 5ns -r 10ns
force /Reset 1 0 ns, 0 10 ns

force /PCEscCond 0 0ns, 1 160ns, 0 200ns
force /PCEsc 1 0ns, 0 20ns, 1 180ns, 0 200ns
force /IouD 0 0ns, 1 60ns, 0 80ns, 1 100ns, 0 120ns
force /LerMem 1 0ns, 0 20ns, 1 60ns, 0 80ns
force /EscMem 0 0ns, 1 100ns, 0 120ns
force /MemParaReg 0 0ns, 1 80ns, 0 100ns, 1 200ns
force /IREsc 1 0ns, 0 20ns
force /RegDst 0 0ns, 1 140ns, 0 180ns
force /EscReg 0 0ns, 1 80ns, 0 100ns, 1 140ns, 0 180ns
force /ULAFonteA 0 0ns, 1 40ns, 0 60ns, 1 120ns, 0 140ns, 1 160ns, 0 180ns, 1 200ns

force /ULAFonteB 01 0ns, 11 20ns, 10 40ns, 00 60ns, 10 200ns
force /ULAOp 00 0ns, 10 120ns, 00 140ns, 01 160ns, 00 180ns
force /FontePC 00 0ns, 01 160ns, 10 180ns, 00 200ns
radix define CurrentState {
10'b00000000000 "S0",
10'b00000000011 "S1",
10'b00000000101 "S2",
10'b00000001001 "S3",
10'b00000010001 "S4",
10'b00000100001 "S5",
10'b00001000001 "S6",
10'b00010000001 "S7",
10'b00100000001 "S8",
10'b01000000001 "S9",
10'b10000000001 "S10"
-default symb
}

radix define instr {
5'b100011 "lw",
5'b101011 "sw",
5'b000000 "R",
5'b000100 "beq",
5'b000010 "jump",
5'b001000 "addi"
-default symb
}

force /Clock 1 0ns, 0 5ns -r 10ns
force /Reset 1 0ns, 0 10ns
force /opcode 000000 0ns, 000010 100ns, 000100 200ns, 100011 300ns, 101011 400ns, 001000 490ns

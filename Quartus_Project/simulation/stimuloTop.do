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

radix define ControlState {
4'b0000 "S0",
4'b0001 "S1",
4'b0010 "S2",
4'b0011 "S3",
4'b0100 "S4",
4'b0101 "S5",
4'b0110 "S6",
4'b0111 "S7",
4'b1000 "S8",
4'b1001 "S9",
4'b1010 "S10"
-default symb
}

force /Clock 1 0ns, 0 10ns -r 20ns
force /Reset 1 0ns, 0 20ns
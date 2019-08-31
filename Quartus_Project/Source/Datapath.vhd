library ieee;
use ieee.std_logic_1164.all;

entity Datapath is 
    port(
        Clock_mips, clock_ram, Reset: in std_logic;
        PCEscCond, PCEsc, IouD, LerMem, EscMem, MemParaReg, IREsc, RegDst, EscReg, ULAFonteA: in std_logic;
        ULAFonteB, ULAOp, FontePC: in std_logic_vector(1 downto 0);
        opcode: out std_logic_vector(5 downto 0);
        InstructionAddress, DataAddress, InstructionValue, DataValue, ALUValue: out std_logic_vector(15 downto 0)
    );
end entity;

architecture Structural of Datapath is
  
    component ALU is
    	generic(VectorLength: positive := 32);
        port(
            InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
            Operation: in std_logic_vector(2 downto 0);
            Output: out std_logic_vector(VectorLength-1 downto 0);
            Zero: out std_logic
        );
    end component;

    component ALUOperation is
    	port(
            ULAOp: in std_logic_vector(1 downto 0);
            funct: in std_logic_vector(5 downto 0);
            Operation: out std_logic_vector(2 downto 0)
        );
    end component;

    component Memory is
    	port(
            Clock: in std_logic;
            ReadMem, WrtMem: in std_logic;
            DataWrt: in std_logic_vector(31 downto 0);
            Address: in std_logic_vector(31 downto 0);
            DataRd: out std_logic_vector(31 downto 0)
        );
    end component;

    component LeftShift is
        generic(VectorLength: positive := 32);
        port(
            Input: in std_logic_vector(VectorLength-1 downto 0);
            Output: out std_logic_vector(VectorLength-1 downto 0)
        );
    end component;

    component Mux4x1 is
    	generic(VectorLength: positive := 32);
        port(
            InputA, InputB, InputC, InputD: in std_logic_vector(VectorLength-1 downto 0);
            Selection: in std_logic_vector(1 downto 0);
            Output: out std_logic_vector(VectorLength-1 downto 0)
        );
    end component;

    component Mux2x1 is
        generic(VectorLength: positive := 32);
        port (
            InputA, InputB: in std_logic_vector(VectorLength-1 downto 0);
            Selection: in std_logic;
            Output: out std_logic_vector(VectorLength-1 downto 0)
        );
    end component;

    component RegistersBank is
        generic(
            VectorLength: positive := 32;
            BitsRegisterAddress: positive := 5
        );
        port(
            Clock, Reset: in std_logic;
            EscReg: in std_logic;
            RegisterReadAddressA, RegisterReadAddressB, RegisterWriteAddress: in std_logic_vector(BitsRegisterAddress-1 downto 0);
            RegisterWrite: in std_logic_vector(VectorLength-1 downto 0);      
            RegisterReadA, RegisterReadB: out std_logic_vector(VectorLength-1 downto 0)
        );
    end component;

    component RegisterNBits is
        generic(
            VectorLength: positive:= 32
        );
        port(
            Clock, Reset, Enable: in std_logic;
            Input: in std_logic_vector(VectorLength-1 downto 0);
            Output: out std_logic_vector(VectorLength-1 downto 0)
        );
    end component;

    component SignalExtension is
        generic(
            OriginalVectorLength: positive := 16;
            ExtendedVectorLength: positive := 32);
        port(
            Input: in std_logic_vector(OriginalVectorLength-1 downto 0);
            Output: out std_logic_vector(ExtendedVectorLength-1 downto 0)
        );
    end component;

	 constant MipsResolution: positive := 32;
    constant Four: std_logic_vector(MipsResolution-1 downto 0) := (0 => '1', others => '0');

    -- ALU Signals
    signal ZeroALU_s: std_logic;
    signal ControlALU_s: std_logic_vector(2 downto 0);
    signal OutputALU_s: std_logic_vector(MipsResolution-1 downto 0);

    -- Registers Signals
    signal EnableRegPC_s: std_logic;
    signal InputRegPC_s, OutputRegPC_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputRegALU_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputRegInstr_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputRegData_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputRegA_s, OutputRegB_s: std_logic_vector(MipsResolution-1 downto 0);

    --Register Bank signals
    signal RegBankRead1_s, RegBankRead2_s: std_logic_vector(MipsResolution-1 downto 0);

    -- Memory Signals
    signal OutputMemory_s: std_logic_vector(MipsResolution-1 downto 0);

    -- Mux Signals
    signal OutputMuxPC_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputMuxData_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputMuxAALU_s, OutputMuxBALU_s: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputMuxAddrReg_s: std_logic_vector(4 downto 0);

    -- Miscellany Signals
    signal OutputSignalExtension_s, OutputSignalExtensionShifted_s: std_logic_vector(MipsResolution-1 downto 0);
    signal JumpAddress: std_logic_vector(MipsResolution-1 downto 0);
    signal OutputInstrShifted_s: std_logic_vector(MipsResolution-5 downto 0);

begin

-- Muxes  
   
    MuxPC: Mux2x1 
        port map (
            OutputRegPC_s, OutputRegALU_s, 
            IouD, 
            OutputMuxPC_s
        );
    MuxWriteRegister: Mux2x1 
        generic map (5) 
        port map (
            OutputRegInstr_s(20 downto 16), OutputRegInstr_s(15 downto 11), 
            RegDst, 
            OutputMuxAddrReg_s
        );
    MuxWriteData: Mux2x1 
        port map (
            OutputRegALU_s, OutputRegData_s, 
            MemParaReg, 
            OutputMuxData_s
        );
    MuxA: Mux2x1 
        port map (
            OutputRegPC_s, OutputRegA_s, 
            ULAFonteA, 
            OutputMuxAALU_s
        );
    MuxB: Mux4x1 
        port map (
            OutputRegB_s, Four, OutputSignalExtension_s, OutputSignalExtensionShifted_s, 
            ULAFonteB, 
            OutputMuxBALU_s
        );
    MuxALU_s: Mux4x1 
        port map (
            OutputALU_s, OutputRegALU_s, JumpAddress, (others => '0'), 
            FontePC, 
            InputRegPC_s
        );

-- Memory elements
   
    RAM: Memory 
        port map (
            clock_ram, 
            LerMem, EscMem, 
            OutputRegB_s, 
            OutputMuxPC_s, 
            OutputMemory_s
        );
    Registers: RegistersBank 
        port map (
            clock_mips, reset, 
            EscReg, 
            OutputRegInstr_s(25 downto 21), OutputRegInstr_s(20 downto 16), OutputMuxAddrReg_s, 
            OutputMuxData_s, RegBankRead1_s, RegBankRead2_s
        );
    RegisterInstr: RegisterNbits  
        port map (
            clock_mips, reset, IREsc, 
            OutputMemory_s, 
            OutputRegInstr_s
        );
    RegisterMemoryData: RegisterNbits 
        port map (
            clock_mips, reset, '1', 
            OutputMemory_s, 
            OutputRegData_s
        );
    RegisterPC: RegisterNBits 
        port map (
            clock_mips, reset, EnableRegPC_s, 
            InputRegPC_s, 
            OutputRegPC_s
        );
    RegisterA: RegisterNbits 
        port map (
            clock_mips, reset, '1', 
            RegBankRead1_s, 
            OutputRegA_s
        );
    RegisterB: RegisterNbits 
        port map (
            clock_mips, reset, '1', 
            RegBankRead2_s, 
            OutputRegB_s
        );
    RegisterALU_s: RegisterNbits 
        port map (
            clock_mips, reset, '1', 
            OutputALU_s, 
            OutputRegALU_s
        );

-- Arithmetic and Logic unit
    
    ArithmeticLogicUnit: ALU 
        port map (OutputMuxAALU_s, OutputMuxBALU_s, ControlALU_s, OutputALU_s, ZeroALU_s);

-- Miscellany
    
    SignExtend: SignalExtension 
        port map (OutputRegInstr_s(15 downto 0), OutputSignalExtension_s);
    ALUControl: ALUOperation 
        port map(ULAOp, OutputRegInstr_s(5 downto 0), ControlALU_s);
    LeftShiftInstr: LeftShift 
        generic map (32)
        port map(OutputSignalExtension_s, OutputSignalExtensionShifted_s);
    LeftShiftInstrPC: LeftShift 
        generic map (28)
        port map(OutputRegInstr_s(27 downto 0), OutputInstrShifted_s);        

    JumpAddress   <= OutputRegPC_s(31 downto 28) & OutputInstrShifted_s;
    EnableRegPC_s <= PCEsc or (PCEscCond and ZeroALU_s); 
    opcode        <= OutputRegInstr_s(31 downto 26);

-- Board Interface

    InstructionAddress <= OutputRegPC_s(15 downto 0); 
    DataAddress        <= OutputRegALU_s(15 downto 0);
    InstructionValue   <= OutputRegInstr_s(15 downto 0);
    DataValue          <= OutputRegData_s(15 downto 0);
    ALUValue           <= OutputRegALU_s(15 downto 0);

end architecture;
    
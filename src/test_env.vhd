----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2020 01:34:06 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( sw : in STD_LOGIC_VECTOR (15 downto 0);
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;


architecture Behavioral of test_env is

--------------------------------
--se vor declasa semnalele corespunzatoare MIPS pipeline
signal adrUrmIf: STD_LOGIC_VECTOR(15 downto 0);
signal instrucIf: STD_LOGIC_VECTOR(15 downto 0);
----------------------------------------------
signal adrUrmId: STD_LOGIC_VECTOR(15 downto 0);
signal instrucId: STD_LOGIC_VECTOR(15 downto 0);
----------------------------------------------

----------------------------------------------
signal regDstId: STD_LOGIC;
signal jumpId: STD_LOGIC;
signal memtoregId: STD_LOGIC;
signal regWriteId: STD_LOGIC;
signal branchId: STD_LOGIC;
signal aluopId: STD_LOGIC_VECTOR(2 downto 0);
signal aluSRCId: STD_LOGIC;
signal memwriteId: STD_LOGIC;
signal adrUrmIdn: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal rd1Id: STD_LOGIC_VECTOR(15 downto 0);
signal rd2Id: STD_LOGIC_VECTOR(15 downto 0);
signal adrScriuId: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal extId: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ALUId: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal s1Id: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal s2Id: STD_LOGIC_VECTOR(2 downto 0);

signal regDstEX: STD_LOGIC;
signal jumpEX: STD_LOGIC;
signal memtoregEX: STD_LOGIC;
signal regWriteEX: STD_LOGIC;
signal branchEX: STD_LOGIC;
signal aluopEx: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal aluSRCEX: STD_LOGIC;
signal memwriteEX: STD_LOGIC;
signal adrUrmEX: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal rd1EX: STD_LOGIC_VECTOR(15 downto 0);
signal rd2EX: STD_LOGIC_VECTOR(15 downto 0);
signal adrScriuEX: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal extEX: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ALUEX: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal s1EX: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal s2EX: STD_LOGIC_VECTOR(2 downto 0);
------------------------------------------

------------------------------------------

signal memtoregEXn : STD_LOGIC;
signal regwriteEXn : STD_LOGIC;
signal memWriteEXn : STD_LOGIC;
signal BranchExn : STD_LOGIC;
signal rezEx: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal rd2Exn: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ZEROEX1: STD_LOGIC;
signal branchAdrEX: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ScriuEX: STD_LOGIC_VECTOR(2 DOWNTO 0);

signal memtoregMEM : STD_LOGIC;
signal regwriteMEM : STD_LOGIC;
signal memWriteMEM : STD_LOGIC;
signal BranchMEM : STD_LOGIC;
signal rezMEM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal rd2MEM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ZEROMEM: STD_LOGIC;
signal branchAdrMEM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ScriuMEM: STD_LOGIC_VECTOR(2 DOWNTO 0);

-------------------------------------------------

-------------------------------------------------
signal memtoregMEMn: STD_LOGIC;
signal regwriteMEMn : STD_LOGIC;
signal ReadDataMEM : STD_LOGIC_VECTOR(15 DOWNTO 0);
signal AdressMEM: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ScriuMEMn : STD_LOGIC_VECTOR(2 DOWNTO 0);

signal memtoregWB: STD_LOGIC;
signal regwriteWB : STD_LOGIC;
signal ReadDataWB: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal AdressWB: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal ScriuWB : STD_LOGIC_VECTOR(2 DOWNTO 0);
----------------------------------------------------

signal s: std_logic_vector(15 downto 0) := "0000000000000000";
signal reset, enable, enable2: std_logic;
signal data_out, iesire_ram: std_logic_vector (15 downto 0);
--signal sw1, sw2, sw3, rezultat: std_logic_vector(15 downto 0
component ALUmips is
    Port ( IN1 : in STD_LOGIC_VECTOR (15 downto 0);
           IN2 : in STD_LOGIC_VECTOR (15 downto 0);
           sa : in STD_LOGIC;
           sel : in STD_LOGIC_VECTOR (3 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           zero : out STD_LOGIC;
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component InstructionFetch is
    Port ( clk : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           adrBranch : in STD_LOGIC_VECTOR (15 downto 0);
           adrJump : in STD_LOGIC_VECTOR (15 downto 0);
           Jump : in STD_LOGIC;
           PCsrc : in STD_LOGIC;
           adrUrm : out STD_LOGIC_VECTOR (15 downto 0);
           Instr : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component IC is
    Port ( clk : in STD_LOGIC;
           Instr : in STD_LOGIC_VECTOR (15 downto 0);
           WD : in STD_LOGIC_VECTOR (15 downto 0);
           RegWr : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           ExtOp : in STD_LOGIC;
           enable: in std_logic;
           RD1 : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : out STD_LOGIC_VECTOR (15 downto 0);
           Ext_imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           wa: in std_logic_vector (2 downto 0);
           sa : out STD_LOGIC);
end component;
component mpg is 
    Port ( en : out STD_LOGIC; 
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
  end component; 
  
component ssd is
    Port ( intrare : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;
component MEM is
    Port ( ALUrez : in STD_LOGIC_VECTOR (15 downto 0);
           MemWrite : in STD_LOGIC;
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           enable: in STD_LOGIC;
           MemData : out STD_LOGIC_VECTOR (15 downto 0);
           AluRezout : out STD_LOGIC_VECTOR (15 downto 0));
end component;
component UC is
    Port ( Instr : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR(2 downto 0);
           MemWrite : out STD_LOGIC;
           MemtoReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end component;

component rf is
    Port ( ra1 : in STD_LOGIC_VECTOR (2 downto 0);
           ra2: in STD_LOGIC_VECTOR (2 downto 0);
           wa: in STD_LOGIC_VECTOR (2 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           enable: in STD_LOGIC;
           rd2: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           rd1: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
           wd: in STD_LOGIC_VECTOR(15 DOWNTO 0));
end component;

component EX is
    Port ( RegDst: in STD_LOGIC;
           s1: in std_logic_vector(2 downto 0);
           s2: in std_logic_vector(2 downto 0);
           rezS: out std_logic_vector(2 downto 0);
           RD1 : in STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0);
           AluSrc : in STD_LOGIC;
           Ext_Imm : in STD_LOGIC_VECTOR (15 downto 0);
           func : in STD_LOGIC_VECTOR (2 downto 0);
           sa : in STD_LOGIC;
           AluOp : in STD_LOGIC_VECTOR(2 downto 0);
           InstrUrm : in STD_LOGIC_VECTOR (15 downto 0);
           registru: in STD_LOGIC_VECTOR(2 downto 0);
           Zero : out STD_LOGIC;
           AdrBranch : out STD_LOGIC_VECTOR (15 downto 0);
           iesire: out STD_LOGIC_VECTOR(3 DOWNTO 0);
           rez : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component ram is
    Port ( intrare : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           regWr : in STD_LOGIC;
           iesire : out STD_LOGIC_VECTOR (15 downto 0));
end component;
signal instructiune, adresaUrm, adrjump, PC, adrbranch: std_logic_vector(15 downto 0);
signal ssdsig,ssig, r: std_logic_vector(15 downto 0);
signal sw7, rezS: std_logic_vector(2 downto 0);
signal RegDst,ExtOp,ALUSrc,Branch,JumpUC,jump,MemWrite,RegWrite, MemtoReg : STD_LOGIC;
signal wd, rd1, rd2, ext: std_logic_vector (15 downto 0);
signal sa, regWr: STD_LOGIC;
signal func,ALUOp, wa : STD_LOGIC_VECTOR(2 downto 0);
signal ZEROex, PCSrc: STD_LOGIC;
signal iesire: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal adresabranch, rez,rezultat, aleg, iesire1,DataMEM, ALUrezultat: STD_LOGIC_VECTOR(15 DOWNTO 0);
begin
sw7 <= sw(7 downto 5);
prima : mpg port map (enable, btn(0), clk);
adoua: mpg port map (reset, btn(1), clk);


dinnou: InstructionFetch port map (clk, enable, reset, branchAdrMEM, adrjump, Jump, PCSrc, adresaUrm, instructiune);
------------------------------------------
--IF/ID
adrUrmIf(15 downto 0) <= adresaUrm;
instrucIf(15 downto 0) <= instructiune;

IF_ID_reg: process(clk)
begin
if(rising_edge(clk))then
    if enable ='1' then 
       instrucId<= instrucIf;
       adrUrmId <= adrUrmIf;
        end if;
    end if;
end process;
--------------------------------------------
UCport: UC port map ( instrucId(15 downto 13), RegDst,ExtOp,ALUSrc,Branch,Jump,ALUOp,MemWrite, MemtoReg, RegWrite ); 

ICportmap: IC port map(clk, instrucId, wd, RegWrite, RegDst, ExtOp, enable, rd1, rd2, ext, func, scriuWB, sa);
---------------------------------------------
--ID/EX
RegDstId <= RegDst;
jumpId<=Jump;
memtoRegId<=MemtoReg;
regWriteId <= regWrite;
branchId <= Branch;
aluopId <= ALUop;
aluSRCid<=ALUsrc;
memwriteID<=memWrite;
adrUrmIdn <= adrUrmId ;
rd1Id <= rd1;
rd2Id <= rd2;
--adrScriuId <= wa ;
extId <= ext;
ALUid <= func;
s1Id <= instrucId(6 downto 4);
s2Id<= instrucId(9 downto 7);
process(clk)
begin 
    if(clk='1' and clk'event) then 
        if enable ='1' then 
            regDstEX <= regDstID;
            jumpEX <= jumpId;
            memtoRegEX <= memtoRegId;
            regWriteEX<= regWriteID;
            branchEX<= branchID;
            aluopEX <= aluopId;
            alusrcEX<=aluSrcId;
            MEMWRITEex<=memWriteID;
            adrUrmEX <= adrUrmIdn;
            rd1EX<=rd1Id;
            rd2EX<=rd2Id;
            --adrScriuEX<=adrScriuID;
            extEX<=extId;
            ALUex<=ALUid;
            s1EX <= s1Id;
            s2EX <= s2Id;
         end if;
    end if;
end process;

---------------------------------------------
--ghg: rf port map (instructiune(12 downto 10), instructiune (9 downto 7), instructiune (6 downto 4), clk, '1', enable, rd1, rd2,wd);
EXportmap: EX port map (RegDstEX, s1EX, s2EX, rezS, rd1EX, rd2EX, ALUSrcEX, extEX, ALUex, sa, ALUOpEX, adrUrmEX,instructiune(9 downto 7), ZEROex1, adresabranch,iesire, rez);
--Al: ALUmips port map(rd1, rd2, sa, "0001","000", zeros, rezultat);
-------------------------------------------------------------------
--EX/MEM
memtoregEXn <= memtoRegEX;
regWriteEXn <= regWriteEX;
memWriteEXn <= memWriteEX;
BranchEXn <= BranchEX;
rezEX <= rez;
rd2EXn <= rd2EX;
ZeroEx1 <= Zeroex;
branchAdrEx <= adresabranch;
ScriuEx <= rezS;

EX_MEM_reg: process(clk)
begin
if(rising_edge(clk))then
    if enable ='1' then 
      memtoRegMEM <= memtoRegExn;
      regWriteMEM <= regWriteEXn;
      memWriteMEM <= memWriteEXn;
      BranchMEM <=BranchEXn;
      rezMEM <= rezEX;
      rd2MEM <= rd2EXn;
      ZEROMEM <= ZEROEX1;
      branchAdrMEM <= branchAdrEx;
      ScriuMEM <= ScriuEX;
      
        end if;
    end if;
end process;


-------------------------------------------------------------------
MEMportmap: MEM port map (rezMEM, MemWriteMEM,rd2MEM, clk, enable, DataMEM, ALUrezultat);

memtoRegMEMn <= MEMtoregmem;
regwritememn <= memwritemem;
readdatamem <= DataMem;
AdressMEM<= ALUrezultat;
ScriuMEMn <= ScriuMEM;
MEM_eX_reg: process(clk)
begin
if(rising_edge(clk))then
    if enable ='1' then 
       memtoREGWB <= memtoregMEMn;
      regWriteWB <= regwriteMEMn;
      readdataWB <= readdataMEM;
      AdressWB <= AdressMEM;
      ScriuWB <= ScriuMEM;
        end if;
    end if;
end process;



process(MemtoRegWB)
begin
    case MemtoRegWB is 
        when '1' => wd <= readDataWB;
        when '0' => wd <= AdressWB;
    end case;
end process;
PCSrc <= ZEROMEM and branchMEM;
PC <= adrUrmID- 1;
adrjump<= PC(15 downto 13)  & instrucId(12 downto 0);
r<="000000000000000" & JumpUC;
iesire1 <= "000000000000000" & Jump;


process(sw7)
begin 
case sw7 is
    when "000" => ssdsig <= instructiune;
    when "001" => ssdsig <= adresaUrm;
    when "010" => ssdsig <= rd1EX;
    when "011" => ssdsig <= rd2EX;
    when "100" => ssdsig <= rezEX;
    when "101" => ssdsig <= branchAdrMEM;
    when "110" => ssdsig <= adrJump ;
    when "111" => ssdsig <= wd;
    when others => ssdsig <= "0000000000000000";
    
end case;
end process;
 
doua: ssd port map (ssdsig, clk, an ,cat);

end Behavioral;

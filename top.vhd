library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity top is
port (


 clk_top: in std_logic;
 reset_top: in std_logic
 

);
end top;



architecture Behavioral of top is



component PC is
port (
	clk: in std_logic;
	PS: in std_logic_vector (1 downto 0);
	address_branchOrjump : in std_logic_vector(15 downto 0);
	 
	out_PC: out std_logic_vector(15 downto 0)

);
end component;

component RF is
port (

 clk: in std_logic;
 RW_RF :in std_logic;
 AA: IN std_logic_vector(3 downto 0);
 DA:	IN std_logic_vector(3 downto 0);
 BA:	in std_logic_vector(3 downto 0);
 D:	in std_logic_vector(15 downto 0);
 A:	out std_logic_vector(15 downto 0);
 B:	out std_logic_vector(15 downto 0)
 
 

);
end component;

component Reg_Addr_Logic is
port (

AX : IN std_logic_vector(3 downto 0);
	BX : IN std_logic_vector(3 downto 0);
	DX : IN std_logic_vector(3 downto 0);
	DR : IN std_logic_vector(2 downto 0);
	SA : IN std_logic_vector(2 downto 0);
	SB : IN std_logic_vector(2 downto 0);
	
	toAA: out std_logic_vector(3 downto 0);
	toDA: out std_logic_vector(3 downto 0);
	toBA: out std_logic_vector(3 downto 0)
 
 

);
end component;

component InstrucReg is
port (

IR : IN std_logic_vector(15 downto 0);
	IL : in std_logic;
	Opcode : OUT std_logic_vector(6 downto 0);
	DRIR : OUT std_logic_vector(2 downto 0);
	SAIR : out std_logic_vector(2 downto 0);
	SBIR : out std_logic_vector(2 downto 0)
	
	
 
 

);
end component;



component Func_Unit is
port (
	clk: in std_logic;
	A_FU : IN std_logic_vector(15 downto 0);
	B_FU : IN std_logic_vector(15 downto 0);
	

	FS_FU: in std_logic_vector(3 downto 0);
	VCNZ: out std_logic_vector(3 downto 0);
	F: out std_logic_vector(15 downto 0)
	
);
end component;

component Memory is
port (
	clk : in std_logic;
	Data_in : in std_logic_vector(15 downto 0);
	address : in std_logic_vector(15 downto 0);
	MW :in std_logic; 
	Data_out : out std_logic_vector(15 downto 0)
	
);
end component;




component control is
port (
	clk : in std_logic;
	reset: in std_logic;
	
	Ctrl_VCNZ : IN std_logic_vector(3 downto 0);
	Opcode : IN std_logic_vector(6 downto 0);
	MW : out std_logic;
	MM	: out std_logic;
	RW	: out std_logic;
	MD	: out std_logic;
	FS	: out std_logic_vector(3 downto 0);
	MB : out std_logic;
	BX	: out std_logic_vector(3 downto 0);
	AX	: out std_logic_vector(3 downto 0);
	DX	: out std_logic_vector(3 downto 0);
	IL	: out std_logic;
	PS	:	out std_logic_vector(1 downto 0)
	
	

);
end component;
	
	signal temp_PC: std_logic_vector(15 downto 0);		--PC
	

	signal temp_A: std_logic_vector(15 downto 0):=x"0000";
	signal temp_B: std_logic_vector(15 downto 0):=x"0000";
	signal temp_FS: std_logic_vector(3 downto 0);
	signal temp_VCNZ: std_logic_vector(3 downto 0);
	signal temp_F: std_logic_vector(15 downto 0);
	
	signal temp_RW: std_logic;
	signal temp_D: std_logic_vector(15 downto 0);
	
	
	signal temp_instruc: std_logic_vector(15 downto 0);
	
	signal temp_Opcode: std_logic_vector(6 downto 0);
	signal temp_DR: std_logic_vector(2 downto 0);
	signal temp_SA: std_logic_vector(2 downto 0);
	signal temp_SB: std_logic_vector(2 downto 0);
	signal temp_AX: std_logic_vector(3 downto 0);
	signal temp_BX: std_logic_vector(3 downto 0);
	signal temp_DX: std_logic_vector(3 downto 0);
	
	signal temp_AA: std_logic_vector(3 downto 0);
	signal temp_BA: std_logic_vector(3 downto 0);
	signal temp_DA: std_logic_vector(3 downto 0);
	
	
	signal t_DataToMem: std_logic_vector(15 downto 0):=x"0000";		--memory
	signal t_DataFromMem: std_logic_vector(15 downto 0);
	signal t_ToAddrMem: std_logic_vector(15 downto 0);
	
	
	signal temp_MD : std_logic;			--control
	signal temp_MB : std_logic;
	signal temp_MM : std_logic;
	signal temp_MW : std_logic;
	signal temp_IL : std_logic;
--	signal temp_DA: std_logic_vector(2 downto 0);
	signal temp_PS: std_logic_vector(1 downto 0);
	signal toAddrBrcOrJmp: std_logic_vector(15 downto 0);
	
begin


	to_control: control port map (clk_top,reset_top,temp_VCNZ,temp_Opcode,temp_MW,temp_MM,temp_RW,temp_MD,temp_FS,temp_MB,temp_BX,temp_AX,temp_DX,temp_IL,temp_PS);


	toAddrBrcOrJmp <= temp_PC - ("0000000000"&temp_instruc(8 downto 6)&temp_instruc(2 downto 0)); --calculate brach addr
	
	
	
	
	to_PC: PC port map (clk_top,temp_PS,toAddrBrcOrJmp,temp_PC);
	

	temp_instruc <= t_DataFromMem WHEN temp_IL = '1' else
						temp_instruc;
	


	temp_Opcode<= temp_instruc(15 downto 9);
	temp_DR <=temp_instruc(8 downto 6);
	temp_SA <=temp_instruc(5 downto 3);
	temp_SB <=temp_instruc(2 downto 0);
	
	
	t_DataToMem <= temp_B when temp_MB = '0' else
						"0000000000000"&temp_SB ;
						
	t_ToAddrMem <= temp_A when temp_MM = '0' else
						temp_PC;
	
	to_memory: memory port map(clk_top,t_DataToMem,t_ToAddrMem,temp_MW,t_DataFromMem);
	
	to_RALogic: Reg_Addr_Logic port map (temp_AX,temp_BX,temp_DX,temp_DR,temp_SA,temp_SB,temp_AA,temp_DA,temp_BA);
	
	temp_D <= temp_F when temp_MD = '0' else 
				t_DataFromMem;
	
	
	to_RF: RF port map(clk_top,temp_RW,temp_AA,temp_DA,temp_BA,temp_D,temp_A,temp_B);
	
	
	
	to_FU: Func_Unit port map(clk_top,temp_A,t_DataToMem,temp_FS,temp_VCNZ,temp_F);

	
	







	
	
	
	


end Behavioral;
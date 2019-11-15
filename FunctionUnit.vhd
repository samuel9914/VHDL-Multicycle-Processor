library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity Func_Unit is
port (clk:in std_logic;
	A_FU : IN std_logic_vector(15 downto 0):=x"0000";
	B_FU : IN std_logic_vector(15 downto 0):= x"0000";
	

	FS_FU: in std_logic_vector(3 downto 0);
	VCNZ: out std_logic_vector(3 downto 0);
	F: out std_logic_vector(15 downto 0)
	

);
end Func_Unit;

architecture Behavioral of  Func_Unit is
signal V,C,N,Z :  std_logic;
BEGIN


	
	Z <= '1' when A_FU - B_FU = x"0000" and not (FS_FU = "0110" )  else
			'1' when A_FU = x"0000" and (FS_FU = "0110" ) else
			
			'0';
			
	V <= '1' when A_FU + B_FU > "1111111111111111" else
			'0';
			
	N <= '1' when FS_FU = "0101" and B_FU > A_FU else
			'0';
			
	C <= '0';
	VCNZ <= V&C&N&Z;
	
	
	
	

	F <= 	A_FU when FS_FU = "0000" else
			A_FU + '1' when FS_FU = "0001" else
			A_FU +B_FU	 when FS_FU = "0010" else
			A_FU - B_FU when FS_FU = "0101" else
			A_FU -'1' when FS_FU = "0110" else
			A_FU and B_FU when FS_FU = "1000" else
			A_FU or B_FU when FS_FU = "1001" else
			A_FU xor B_FU when FS_FU = "1010" else
			not (A_FU) when FS_FU = "1011" else
			B_FU when FS_FU ="1100" else
			'0'&B_FU(15 downto 1) when FS_FU = "1101" else
			B_FU(14 downto 0 )&'0' when FS_FU = "1110";
			
			
	



	
end Behavioral;
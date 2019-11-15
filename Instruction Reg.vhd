library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity InstrucReg is
port (
	IR : IN std_logic_vector(15 downto 0);
	IL : in std_logic;
	Opcode : OUT std_logic_vector(6 downto 0);
	DRIR : OUT std_logic_vector(2 downto 0);
	SAIR : out std_logic_vector(2 downto 0);
	SBIR : out std_logic_vector(2 downto 0)
	
	
	

);
end InstrucReg;
architecture Behavioral of  InstrucReg is

	SIGNAL tIR : std_logic_vector(15 downto 0);

BEGIN
	tIR<= IR when IL='1';

	Opcode <= tIR(15 downto 9) ;
	DRIR <= tIR(8 downto 6);
	SAIR <= tIR(5 downto 3);
	SBIR <= tIR(2 downto 0);


end Behavioral;
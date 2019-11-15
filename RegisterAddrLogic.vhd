library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity Reg_Addr_Logic is
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
end Reg_Addr_Logic;
architecture Behavioral of  Reg_Addr_Logic is
begin
	
	
	toAA <= '0'&SA when AX(3)= '0' else
				AX when AX(3)= '1';
				
	toDA <= '0'&DR when DX(3)= '0' else
				DX when DX(3)= '1';
				
	toBA <= '0'&SB when BX(3)= '0' else
				BX when BX(3)= '1';





end Behavioral;
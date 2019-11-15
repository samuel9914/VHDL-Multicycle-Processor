library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity PC is
port (
	clk: in std_logic;
	PS: in std_logic_vector (1 downto 0);
	address_branchOrjump : in std_logic_vector(15 downto 0);
	
	out_PC: out std_logic_vector(15 downto 0)
);
end PC;


architecture Behavioral of PC is

signal PCnow : std_logic_vector(15 downto 0):= x"0000";

begin


process (clk)
begin
	if (clk'event and clk='1') then

	if PS = "00" then
		PCnow <= PCnow;
		out_PC <= PCnow;
	elsif PS = "01" then
		PCnow <= PCnow + "0001" ;
		out_PC <= PCnow + "0001";
	elsif PS = "10" then
		PCnow <=  address_branchOrjump ;
		out_PC <=  address_branchOrjump;
	elsif PS = "11" then
		PCnow <=  address_branchOrjump;
		out_PC <=  address_branchOrjump;
		
	end if;
	
--PCnow <= 	PCnow when PS = "00" else
--				PCnow +"0001" when PS = "01" else
--				address_branch when PS = "10" else
--				address_jump;
				


end if;
end process;

end Behavioral;
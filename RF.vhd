library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity RF is
port (


 clk : in std_logic;
 RW_RF :in std_logic;
 AA: IN std_logic_vector(3 downto 0);
 DA:	IN std_logic_vector(3 downto 0);
 BA:	in std_logic_vector(3 downto 0);
 D:	in std_logic_vector(15 downto 0);
 A:	out std_logic_vector(15 downto 0):= x"0000";
 B:	out std_logic_vector(15 downto 0):= x"0000"
 
 

);
end RF;
architecture Behavioral of RF is


type ROM_type is array (0 to 15 ) of std_logic_vector(15 downto 0);
 signal Reg: ROM_type:=(
   "0000000000000010",
   "0000000000000001",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000",
	"0000000000000000"
  );
BEGIN

A <= Reg(to_integer(unsigned(AA)));
B <= Reg(to_integer(unsigned(BA)));

process (clk)
begin
	if (clk'event and clk='1') then
		
		if RW_RF = '1' then 
				Reg(to_integer(unsigned(DA))) <=  D ;
		end if;
		
		
	end if;
end process;


	

end Behavioral;
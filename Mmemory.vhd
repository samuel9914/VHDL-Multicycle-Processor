library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all; 

entity Memory is
port (
 
	clk : in std_logic;
	Data_in : in std_logic_vector(15 downto 0);
	address : in std_logic_vector(15 downto 0):= x"0000";
	MW :in std_logic; 
	Data_out : out std_logic_vector(15 downto 0)
);
end Memory;

architecture Behavioral of Memory is


 type ROM_type is array (0 to 15 ) of std_logic_vector(15 downto 0);
 signal data: ROM_type:=(
	
   "0000101000000001", -- SUB R0,R1
   "0000101000000001", -- SUB R0,R1
	"1100000000000010", -- BRZ R0,2
	"0001101000000111", -- shift right R0 7 times
	"0100000000001000",-- store to memory address 9
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
  
 
  
  begin
  
	process (clk)
	begin
	
if (clk'event and clk='1') then
	if MW = '0' and address < x"0010" then 
		Data_out <= data(to_integer(unsigned(address)));
	end if;
	--Data_out <= data(to_integer(unsigned(address))) when (MW = '0' and address < x"0010") ;
					
	if  MW = '1' and address < x"0010" then 
		data(to_integer(unsigned(address)) +8)<= Data_in;
	end if;
	--data(to_integer(unsigned(address)) +8)<= Data_in when (MW = '1' and address < x"0010");
end if;	

 
	end process;
end Behavioral;
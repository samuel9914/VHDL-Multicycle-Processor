library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity control is
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
end control;

architecture Behavioral of  control is
	signal Ctrlstate :  std_logic_vector(3 downto 0);
	type state_type is (RES,  EXE0,EXE1,EXE2,EXE3,EXE4);
	signal cur_state, next_state : state_type;
begin
	state_register:process(clk, reset)
	begin
		if(reset='1') then
			cur_state<=RES;
		elsif (clk'event and clk='1') then
			cur_state<=next_state;
		end if;
	end process;
	
	
	
	out_func: process (cur_state, Opcode, Ctrl_VCNZ(0))
	begin
		
		
		case cur_state is
			when RES =>
				next_state <= EXE0;
				
				
				IL<= '1';
				PS <= "00";
				RW<= '0';
				MM<= '1';
				MW <= '0';
			
			when EXE0 =>
			
			
			IL <='0';
			
			AX<= "0000";
			BX<= "0000";
			MM <= '0';
		
		
		
		case Opcode is
			when "0000000" =>
				PS <= "01";
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0000001" =>
				PS <= "01";
				MB <= '0';
				FS<= "0001";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0000010" =>
				PS <= "01";
				MB <= '0';
				FS<= "0010";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0000101" =>
				PS <= "01";
				MB <= '0';
				FS<= "0101";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0000110" =>
				PS <= "01";
				MB <= '0';
				FS<= "0110";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
			when "0001000" =>
				PS <= "01";
				MB <= '0';
				FS<= "1000";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0001001" =>
				PS <= "01";
				MB <= '0';
				FS<= "1001";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0001010" =>
				PS <= "01";
				MB <= '0';
				FS<= "1010";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0001011" =>
				PS <= "01";
				MB <= '0';
				FS<= "1011";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0001100" =>
				PS <= "01";
				MB <= '0';
				FS<= "1100";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0010000" =>
				PS <= "01";
				MB <= '0';
				FS<= "0000";
				MD <= '1';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "0100000" =>
				PS <= "01";
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '0';
				MW <= '1';
				DX<= "0000";
				next_state <= RES;
			when "1001100" =>
				PS <= "01";
				MB <= '1';
				FS<= "1100";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when "1000010" =>
				PS <= "01";
				MB <= '1';
				FS<= "0010";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			when ("1100000" )=>
				if Ctrl_VCNZ(0 ) = '1' then 
					PS <= "10";
					MB <= '0';
					FS<= "0000";
					MD <= '0';
					RW <= '0';
					MW <= '0';
					DX<= "0000";
					next_state <= RES;
				elsif Ctrl_VCNZ(0 ) = '0' then
					PS <= "01";
					MB <= '0';
					FS<= "0000";
					MD <= '0';
					RW <= '0';
					MW <= '0';
					DX<= "0000";
					next_state <= RES;
					
				end if;
				
				
			
			when ("1100001" ) =>
				if Ctrl_VCNZ (1) = '1' then
			
					PS <= "10";
					MB <= '0';
					FS<= "0000";
					MD <= '0';
					RW <= '0';
					MW <= '0';
					DX<= "0000";
					next_state <= RES;
								elsif Ctrl_VCNZ (1) = '0' then
					PS <= "01";
					MB <= '0';
					FS<= "0000";
					MD <= '0';
					RW <= '0';
					MW <= '0';
					DX<= "0000";
					next_state <= RES;
				
				
				end if;
		
			when "1110000" =>
				PS <= "11";
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '0';
				MW <= '0';
				DX<= "0000";
				next_state <= RES;
			
			when "0001101" =>
				
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "1000";
				if Ctrl_VCNZ(0)='1' then 
					PS <= "01";
					next_state <= RES;
				elsif Ctrl_VCNZ(0)='0' then
					PS <= "00";
					next_state <= EXE1;
				end if;
				
			when "0001110" =>
				
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "1000";
				if Ctrl_VCNZ(0)='1' then 
					PS <= "01";
					next_state <= RES;
				elsif Ctrl_VCNZ(0)='0' then
					PS <= "00";
					next_state <= EXE1;
				end if;
				
				
				when others =>
		end case;
		
		
		
			WHEN EXE1 =>
				
				MB <= '1';
				FS<= "1100";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "1001";
				if Ctrl_VCNZ(0)='1' then 
					next_state <= RES;
					PS <= "01";
				elsif Ctrl_VCNZ(0)='0' then
					PS <= "00";
					next_state <= EXE2;
				end if;
					
					
			WHEN EXE2 =>
				
				MB <= '0';
				FS<= "1101";
				
				if Opcode = "0001110" then 
					FS<= "1110";
					
				elsif Opcode = "0001101" then
					FS<= "1101";
				
					end if;
				
				
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "1000";
				BX<= "1000";
				
				PS <= "00";
				next_state <= EXE3;
				
				
			WHEN EXE3 =>
				
				MB <= '1';
				FS<= "0110";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				DX<= "1001";
				AX<= "1001";
				if Ctrl_VCNZ(0)='1' then 
					
					next_state <=EXE4;
					PS <= "01";
					
				elsif Ctrl_VCNZ(0)='0' then
					
					PS <= "00";
					next_state <= EXE2;
					
				END IF;
			WHEN EXE4 =>
				
				MB <= '0';
				FS<= "0000";
				MD <= '0';
				RW <= '1';
				MW <= '0';
				AX<= "1000";
				DX<= "0000";
				
				PS <= "00";
				next_state <= RES;
				
			when others =>	
	end case;
		
		
	
end process; 



end Behavioral;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

-- FPGA board frequency = 50 MHz divided by 2 for rise and fall edge of clock

entity Double_dabble is
generic(n_dab:integer := 6);
port(
	clock, reset : in std_logic;
	a_i : in std_logic_vector (n_dab downto 0);
	ones_o, tens_o : out std_logic_vector (3 downto 0)
);
end Double_dabble;

-- Convert binary value to decimal value (HEX to BCD)
-- is made to convert values between 0 and 99

-- Example for hundred :
-- elsif (hund_v > "0100") then
-- 		hund_v := hund_v + "0011";
--		hund_v := hund_v(2 downto 0) & tens_v(3);
--		tens_v := tens_v(2 downto 0) & ones_v(3);
--		ones_v := ones_v(2 downto 0) & a_v(n_dab);
--		a_v := a_v(n_dab-1 downto 0) & '0';


architecture dabble of Double_dabble is

begin
	process(clock, reset, a_i)
	-- Increment for the loop
	variable inc_v : std_logic_vector (n_dab downto 0);
	
	 -- a_i value in the loop
	variable a_v : std_logic_vector (n_dab downto 0) := a_i;
	
	-- ones and tens values in the loop
	variable ones_v, tens_v : std_logic_vector (3 downto 0);
	begin
		if(reset='0') then
			a_v := a_i;
			ones_v := (others => '0');
			tens_v := (others => '0');
		elsif(clock'event and clock='1') then
			-- Reset values every rise of clock so it doesn't keep the last values residues
			a_v := a_i;
			ones_v := (others => '0');
			tens_v := (others => '0');
			
			for C_v in 0 to n_dab loop
				-- If ones > 4, add 3 then shift
				if(ones_v > "0100") then
					ones_v := ones_v + "0011";
					tens_v := tens_v(2 downto 0) & ones_v(3);
					ones_v := ones_v(2 downto 0) & a_v(n_dab);
					a_v := a_v(n_dab-1 downto 0) & '0';
					
				-- If tens > 4, add 3 then shift
				elsif (tens_v > "0100") then
					tens_v := tens_v + "0011";
					tens_v := tens_v(2 downto 0) & ones_v(3);
					ones_v := ones_v(2 downto 0) & a_v(n_dab);
					a_v := a_v(n_dab-1 downto 0) & '0';
					
				-- Else, just shift
				else
					tens_v := tens_v(2 downto 0) & ones_v(3);
					ones_v := ones_v(2 downto 0) & a_v(n_dab);
					a_v := a_v(n_dab-1 downto 0) & '0';
				end if;
			end loop;
		end if;
		-- Results settings
		ones_o <= ones_v;
		tens_o <= tens_v;
	end process;
end architecture dabble;
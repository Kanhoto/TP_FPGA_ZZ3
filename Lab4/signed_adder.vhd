-- Quartus II VHDL Template
-- Signed Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signed_adder is
generic(DATA_WIDTH : integer := 8);
port 
(
	-- Input ports
	a : in signed ((DATA_WIDTH-1) downto 0);
	b : in signed ((DATA_WIDTH-1) downto 0);
	flg_neg : out std_logic;
	
	-- Output ports
	result : out signed ((DATA_WIDTH-1) downto 0)
);
end entity;

architecture rtl of signed_adder is
signal temp : signed ((DATA_WIDTH-1) downto 0);
begin

	temp <= a + b;
	flg_neg <= 	'1' when temp < 0 else
				'0';
	
	result <= temp;

end rtl;

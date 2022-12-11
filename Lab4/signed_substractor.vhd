-- Quartus II VHDL Template
-- Signed Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signed_substractor is
generic(DATA_WIDTH : integer := 8);
port 
(
	-- Input ports
	a : in signed ((DATA_WIDTH-1) downto 0);
	b : in signed ((DATA_WIDTH-1) downto 0);
	ena_remaind : in std_logic;
	
	-- Output ports
	result : out signed ((DATA_WIDTH-1) downto 0)
);
end entity;

architecture rtl of signed_substractor is
signal result_v : signed ((DATA_WIDTH-1) downto 0);
begin
	with ena_remaind select
		result_v <=	a - b when '1',
					(others => '0') when others;
	
	result <= result_v;
end rtl;

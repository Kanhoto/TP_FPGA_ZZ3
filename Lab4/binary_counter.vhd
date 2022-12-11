-- Quartus II VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity binary_counter is
generic(MIN_COUNT : natural := 0; MAX_COUNT : natural := 255);
port
(
	-- Input ports
	clk, reset, enable : in std_logic;
	
	-- Output ports
	q : out integer range MIN_COUNT to MAX_COUNT
);
end entity;

architecture rtl of binary_counter is
begin
	process (clk, reset)
	variable cnt : integer range MIN_COUNT to MAX_COUNT;
	begin
		if reset = '0' then
			-- Reset the counter to 0
			cnt := 0;
		elsif (clk'event and clk = '1') then
			if enable = '1' then
				-- Increment the counter if counting is enabled			   
				cnt := cnt + 1;
			end if;
		end if;
		-- Output the current count
		q <= cnt;
	end process;
end rtl;

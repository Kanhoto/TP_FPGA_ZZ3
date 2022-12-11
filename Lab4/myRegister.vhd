library ieee;
use ieee.std_logic_1164.all;

entity myRegister is
generic(DATA_WIDTH : integer := 8);
port
(
	-- Input ports
	clk, reset, ena_reg	: in  std_logic;
	a_i	: in  std_logic_vector((DATA_WIDTH-1) downto 0);

	-- Output ports
	s_o	: out std_logic_vector((DATA_WIDTH-1) downto 0)
);
end myRegister;

architecture myregister of myRegister is
begin
	-- Process Statement (optional)
	process (clk, reset)
	begin
		-- Reset whenever the reset signal goes low, regardless of the clock
		if (reset = '0') then
			s_o <= (others => '0');
		-- If not resetting, update the register output on the clock's rising edge
		elsif (clk'event and clk = '1') then
			if(ena_reg = '1') then
				s_o <= a_i;
			end if;
		end if;
	end process;
end myregister;
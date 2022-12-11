library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MuxNbits is
generic(DATA_WIDTH : integer := 8);
port
(
	-- Input ports
	a_i, b_i	: in  std_logic_vector((DATA_WIDTH-1) downto 0);
	cmd_mux : in std_logic;

	-- Output ports
	s_o	: out std_logic_vector((DATA_WIDTH-1) downto 0)
);
end MuxNbits;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture muxNbits2adr of MuxNbits is
begin
	with cmd_mux select
		s_o <= 	a_i when '0',
				b_i when others;

end muxNbits2adr;
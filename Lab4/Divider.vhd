library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Divider is
port
(
	-- Input ports
	cmd_mux, clk, reset : in  std_logic;
	Dividend, Divisor : std_logic_vector(7 downto 0);

	-- Output ports
	Remainder, Quotient	: out std_logic_vector(7 downto 0)
);
end Divider;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture Divide of Divider is

component Mux8bits is
generic(DATA_WIDTH : integer := 8);
port
(
	-- Input ports
	a_i, b_i	: in  std_logic_vector((DATA_WIDTH-1) downto 0);
	cmd_mux : in std_logic;

	-- Output ports
	s_o	: out std_logic_vector((DATA_WIDTH-1) downto 0)
);
end component;

-- Declarations (optional)
signal flg_neg, ena_reg, ena_remaind : std_logic;

begin

-- Process Statement (optional)

-- Concurrent Procedure Call (optional)

-- Concurrent Signal Assignment (optional)

-- Conditional Signal Assignment (optional)

-- Selected Signal Assignment (optional)

-- Component Instantiation Statement (optional)

-- Generate Statement (optional)

end Divide;

-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity ControlUnit is
port(
	-- Inputs ports
	clk, reset, flg_neg : in std_logic;
	
	-- Outputs ports
	cmd_mux, ena_reg, ena_remaind, ena_quot : out std_logic;
	output : out std_logic_vector(1 downto 0)
);
end entity;

architecture rtl of ControlUnit is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1);

	-- Register to hold the current state
	signal state : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	variable cmd_mux_v : std_logic;
	begin
		if reset = '1' then
			-- Variables initialisations
			cmd_mux_v := '1';
			
			-- Outputs initialisations
			state <= s0;
			cmd_mux <= '0';
			ena_reg <= '1';
			ena_remaind <= '0';
			ena_quot <= '1';
			
		elsif (clk'event and clk = '1') then
			if flg_neg = '1' then
				state <= s1;
			else
				state <= s0;
			end if;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when s0 =>
				cmd_mux <= '1';
			when s1 =>
				ena_reg <= '0';
				ena_remaind <= '1';
				ena_quot <= '0';
		end case;
	end process;

end rtl;

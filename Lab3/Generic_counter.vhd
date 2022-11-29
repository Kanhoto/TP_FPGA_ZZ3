library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

-- FPGA board frequency = 50 MHz divided by 2 for rise and fall edge of clock

entity Generic_counter is
generic(n_gen:integer := 50000000);
port(
	clock, reset, enable_i : in std_logic;
	S_o : buffer std_logic_vector (integer(ceil(log2(real(n_gen)))) downto 0);
	dividedClk_o : buffer std_logic
);
end Generic_counter;

-- This counter is made to just have a rise at 50Mega and stay low elsewhere
-- if you want something that goes 25Mega on rise and 25Mega on low
-- Consider changing dividedClk_o <= '1'; to dividedClk_o <= not(dividedClk_o);
-- and removing dividedClk_o <= '0';

architecture counter of Generic_counter is
begin
	process(clock,reset)
	variable inc_v : std_logic_vector (integer(ceil(log2(real(n_gen)))) downto 0);
	variable enable_v : std_logic;
	variable lock_v : std_logic;
	begin
		if (reset = '0') then
			inc_v := (others => '0');
			S_o <= (others => '0');
			dividedClk_o <= '0';
			enable_v := '1';
			lock_v := '0';
		elsif (clock = '1' and clock'event) then
			-- If the counter attain max values, reset counter to 0
			if (inc_v = n_gen-1) then
				dividedClk_o <= '1';
				inc_v := (others => '0');
				
			-- Else, counter just count
			else
				dividedClk_o <= '0';
				
				-- Set the state of enable on KEY1 button press
				if(enable_i = '0') then
					-- Flag to keep him from doing multiple assertion for one click
					if(lock_v = '0') then
						lock_v := '1';
						enable_v := not(enable_v);
					end if;
				else
					-- Unlock when KEY1 button is released
					lock_v := '0';
				end if;
				
				-- If the flag enable is on, the counter can count
				if(enable_v = '1') then
					inc_v := inc_v + 1;
				end if;
			end if;
			S_o <= inc_v;
		end if;
	end process;
end counter;
library ieee;
use ieee.std_logic_1164.all;

entity Generic_AND is
generic(n: integer:=10);
port(
	A_i : in std_logic_vector(0 to n);
	S_o : out std_logic
	);
end entity Generic_AND;

architecture Gen_AND of Generic_AND is
signal C_s: std_logic_vector(1 to n-1);

begin
	cell_array: for i in 1 to n generate
		--first cell
		first_cell: if i = 1 generate
		C_s(1) <= A_i(0) and A_i(1);
		end generate first_cell;
		
		--mid cell
		mid_cell: if i>1 and i<n generate
		C_s(i) <= C_s(i-1) and A_i(i);
		end generate mid_cell;
		
		--end cell
		end_cell: if i=n generate
		S_o <= C_s(i-1) and A_i(i);
		end generate end_cell;
	end generate cell_array;
end Gen_AND;
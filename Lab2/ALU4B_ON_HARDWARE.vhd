library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU4B_ON_HARDWARE is
generic(n:integer := 7);
port(
	A_i, B_i : in std_logic_vector(n-1 downto 0);
	S_o : buffer std_logic_vector(6 downto 0);
	sel_i : in std_logic_vector(3 downto 0);
	null_o, even_o, overflow_o : out std_logic;
	T_off: out std_logic;
	S7_o : out std_logic_vector(6 downto 0);
	S6_o : out std_logic_vector(6 downto 0);
	S5_o : out std_logic_vector(6 downto 0);
	S4_o : out std_logic_vector(6 downto 0);
	S3_o : out std_logic_vector(6 downto 0);
	S2_o : out std_logic_vector(6 downto 0);
	S0_o : out std_logic_vector(6 downto 0)
);
end ALU4B_ON_HARDWARE;

-- Benchmark for ALU 4 bits testing purpose
-- Display A on hex7 and hex6
-- Display B on hex5 and hex4
-- Display S on hex3 and hex2
-- Display sel on hex0

-- for example: 
-- if sel = 0
-- S <= A + B

architecture description of ALU4B_ON_HARDWARE is

-- Generic ALU to make operations with n-bits
component Generic_ALU is
generic(n: integer:=7);
port(
	A_i, B_i : in std_logic_vector(n-1 downto 0);
	sel_i : in std_logic_vector(3 downto 0);
	S_o : buffer std_logic_vector(n-1 downto 0);
	null_o, even_o, overflow_o : out std_logic
);
end component;

-- Display an HEX of 4 bits on a 7 segments
component Decoder_7_Segment is
port(
	e_i: in std_logic_vector (3 downto 0);
	seg_o: out std_logic_vector(6 downto 0)
);
end component;

begin
	-- Forgot what uses it had (^v^;)
	T_off <= '1';
	
	-- Generic ALU
	AL:Generic_ALU port map(A_i, B_i, sel_i, S_o, null_o, even_o, overflow_o);
	
	-- Display for A value
	H7:Decoder_7_Segment port map('0' & A_i(6 downto 4), S7_o);
	H6:Decoder_7_Segment port map(A_i(3 downto 0), S6_o);
	
	-- Display for B value
	H5:Decoder_7_Segment port map('0' & B_i(6 downto 4), S5_o);
	H4:Decoder_7_Segment port map(B_i(3 downto 0), S4_o);
	
	-- Display for S value
	H3:Decoder_7_Segment port map('0' & S_o(6 downto 4), S3_o);
	H2:Decoder_7_Segment port map(S_o(3 downto 0), S2_o);
	
	-- Display for selection commands
	H0:Decoder_7_Segment port map(sel_i, S0_o);
end description;
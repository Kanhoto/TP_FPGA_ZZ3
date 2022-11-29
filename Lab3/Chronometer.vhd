library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.all;

-- FPGA board frequency = 50 MHz divided by 2 for rise and fall edge of clock

entity Chronometer is
generic(n_chrono:integer := 50000000);
port(
	clock, reset, start_stop : in std_logic;
	seg_secondes_s, seg_minutes_s : out std_logic_vector(13 downto 0)
);
end entity Chronometer;

architecture Chrono of Chronometer is

-- Clock divider
signal divClk_secondes_s : std_logic; 
signal divClk_minutes_s : std_logic; 
signal divClk_hours_s : std_logic; 

-- Signals to save time values
signal S_hz_s : std_logic_vector(integer(ceil(log2(real(n_chrono)))) downto 0);
signal S_secondes_s : std_logic_vector(6 downto 0); 
signal S_minutes_s : std_logic_vector(6 downto 0); 

-- time values converted in BCD for display
signal Sdec_secondes_s : std_logic_vector(7 downto 0); 
signal Sdec_minutes_s : std_logic_vector(7 downto 0); 

-- Generic counter with n_gen being the counter max_value
component Generic_counter is
generic(n_gen:integer := 50000000);
port(
	clock, reset, enable_i : in std_logic;
	S_o : buffer std_logic_vector (integer(ceil(log2(real(n_gen)))) downto 0);
	dividedClk_o : buffer std_logic
);
end component;

-- Display an HEX of 4 bits on a 7 segments
component Decoder_7_Segment is
port(
	e_i: in std_logic_vector (3 downto 0);
	seg_o: out std_logic_vector(6 downto 0)
);
end component;

-- Convert binary value to decimal value (HEX to BCD)
component Double_dabble is
generic(n_dab:integer := 6);
port(
	clock, reset : in std_logic;
	a_i : in std_logic_vector (n_dab downto 0);
	ones_o, tens_o : out std_logic_vector (3 downto 0)
);
end component;

-- Convert binary value to decimal value (HEX to BCD)
component Double_dabble_seq is
generic(n_dab:integer := 6);
port(
	clock, reset : in std_logic;
	a_i : in std_logic_vector (n_dab downto 0);
	ones_o, tens_o : out std_logic_vector (3 downto 0)
);
end component;

begin
	-- count 50Mega Hz to rise every seconds
	Counter_HZ : Generic_counter generic map(n_chrono) port map(clock, reset, start_stop, S_hz_s, divClk_secondes_s);
	
	-- count 60 seconds to rise every minutes
	Counter_secondes : Generic_counter generic map(60) port map(divClk_secondes_s, reset, start_stop, S_secondes_s, divClk_minutes_s);
	
	-- count 60 minutes to rise rise every hours
	Counter_minutes : Generic_counter generic map(60) port map(divClk_minutes_s, reset, start_stop, S_minutes_s, divClk_hours_s);
	
	-- Convert binary value of seconds to BCD
		--Version with FOR
		-- dabble_secondes : Double_dabble generic map(6) port map(clock, reset, S_secondes_s, Sdec_secondes_s(3 downto 0), Sdec_secondes_s(7 downto 4));
		
		--Version without FOR
		dabble_secondes : Double_dabble_seq generic map(6) port map(clock, reset, S_secondes_s, Sdec_secondes_s(3 downto 0), Sdec_secondes_s(7 downto 4));
	
	-- Convert binary value of minutes to BCD
		-- Version with FOR
		-- dabble_minutes : Double_dabble generic map(6) port map(clock, reset, S_minutes_s, Sdec_minutes_s(3 downto 0), Sdec_minutes_s(7 downto 4));
		
		-- Version without FOR
		dabble_minutes : Double_dabble_seq generic map(6) port map(clock, reset, S_minutes_s, Sdec_minutes_s(3 downto 0), Sdec_minutes_s(7 downto 4));
	
	-- Display units of seconds
	Decode_secondes_unit : Decoder_7_Segment port map(Sdec_secondes_s(3 downto 0), seg_secondes_s(6 downto 0));
	
	-- Display dozen of seconds
	Decode_secondes_dozen : Decoder_7_Segment port map(Sdec_secondes_s(7 downto 4), seg_secondes_s(13 downto 7));
	
	-- Display units of minutes
	Decode_minutes_unit : Decoder_7_Segment port map(Sdec_minutes_s(3 downto 0), seg_minutes_s(6 downto 0));
	
	-- Display dozen of minutes
	Decode_minutes_dozen : Decoder_7_Segment port map(Sdec_minutes_s(7 downto 4), seg_minutes_s(13 downto 7));
end architecture Chrono;
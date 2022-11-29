Library ieee;
Use ieee.std_logic_1164.all;

entity Decoder_7_Segment is
port(
	e_i: in std_logic_vector (3 downto 0);
	seg_o: out std_logic_vector(6 downto 0)
);
end Decoder_7_Segment;

-- Take an input of HEX and give an output to 
-- display it on a 7 segment displayer

architecture DECODER of Decoder_7_segment is
begin
	with e_i select
	seg_o <= "1111001" when X"1",
			 "0100100" when X"2",
			 "0110000" when X"3",
			 "0011001" when X"4",
			 "0010010" when X"5",
			 "0000010" when X"6",
			 "1111000" when X"7",
			 "0000000" when X"8",
			 "0010000" when X"9",
			 "0001000" when X"a",
			 "0000011" when X"b",
			 "1000110" when X"c",
			 "0100001" when X"d",
			 "0000110" when X"e",
			 "0001110" when X"f",
			 "1000000" when others;
end DECODER;
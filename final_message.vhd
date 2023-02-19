library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity clock_divider is
	port ( 	
				clock_in: in std_logic;
				num_of_rising_edges: in integer;
				clock_out: out std_logic
);
end clock_divider;
  
architecture clock_divider_architecture of clock_divider is
  
signal counter: integer := 1;
signal output : std_logic := '0';
  
begin
  
Clock_divider_process: process(clock_in)
begin

if rising_edge(clock_in) then
	if (counter = num_of_rising_edges) then
       output <= not output;
       counter <= 0;
   else
       counter <= counter + 1;
   end if;
end if;
clock_out <= output;
end process;
  
end clock_divider_architecture;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity final_message is 
	port( 
			CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
			GPIO:			out std_logic_vector(35 downto 0)
		); 
end entity final_message; 


architecture final_message_architecture of final_message is 

constant message_length: integer := 11; 	-- This is the length of the string 
constant message: string(1 to message_length) := "ANNI KEVIN ";
constant matrix_length: integer := message_length * 6 - 1;

type row_bits_matrix is array (0 to 5) of std_logic_vector(7 downto 0);

function get_row_bits(ascii: std_logic_vector := "1111111") return row_bits_matrix is
	variable row_bits: row_bits_matrix;
	begin
case ascii is
    when "1000001" => -- A 
        row_bits := ("01111110" , "10010000" , "10010000" , "10010000" , "01111110" , "00000000");
    when "1000010" => -- B 
        row_bits := ("11111110" , "10010010" , "10010010" , "10010010" , "01101100" , "00000000");
    when "1000011" => -- C 
        row_bits := ("01111100" , "10000010" , "10000010" , "10000010" , "01000100" , "00000000");
    when "1000100" => -- D 
        row_bits := ("11111110" , "10000010" , "10000010" , "10000010" , "01111100" , "00000000");
    when "1000101" => -- E 
        row_bits := ("11111110" , "10010010" , "10010010" , "10010010" , "10000010" , "00000000");
    when "1000110" => -- F 
        row_bits := ("11111110" , "10010000" , "10010000" , "10010000" , "10000000" , "00000000");
    when "1000111" => -- G 
        row_bits := ("01111100" , "10000010" , "10001010" , "10001010" , "01001110" , "00000000");
    when "1001000" => -- H 
        row_bits := ("11111110" , "00010000" , "00010000" , "00010000" , "11111110" , "00000000");
    when "1001001" => -- I 
        row_bits := ("00000000" , "10000010" , "11111110" , "10000010" , "00000000" , "00000000");
    when "1001010" => -- J 
        row_bits := ("00000100" , "00000010" , "00000010" , "00000010" , "11111100" , "00000000");
    when "1001011" => -- K 
        row_bits := ("11111110" , "00010000" , "00101000" , "01000100" , "10000010" , "00000000");
    when "1001100" => -- L 
        row_bits := ("11111110" , "00000010" , "00000010" , "00000010" , "00000010" , "00000000");
    when "1001101" => -- M 
        row_bits := ("11111110" , "01000000" , "00110000" , "01000000" , "11111110" , "00000000");
    when "1001110" => -- N 
        row_bits := ("11111110" , "00100000" , "00010000" , "00001000" , "11111110" , "00000000");
    when "1001111" => -- O 
        row_bits := ("01111100" , "10000010" , "10000010" , "10000010" , "01111100" , "00000000");
    when "1010000" => -- P 
        row_bits := ("11111110" , "10001000" , "10001000" , "10001000" , "01110000" , "00000000");
    when "1010001" => -- Q 
        row_bits := ("01111100" , "10000010" , "10001010" , "10000100" , "01111010" , "00000000");
    when "1010010" => -- R 
        row_bits := ("11111110" , "10010000" , "10011000" , "10010100" , "01100010" , "00000000");
    when "1010011" => -- S 
        row_bits := ("01100100" , "10010010" , "10010010" , "10010010" , "01001100" , "00000000");
    when "1010100" => -- T 
        row_bits := ("10000000" , "10000000" , "11111110" , "10000000" , "10000000" , "00000000");
    when "1010101" => -- U 
        row_bits := ("11111100" , "00000010" , "00000010" , "00000010" , "11111100" , "00000000");
    when "1010110" => -- V 
        row_bits := ("11111000" , "00000100" , "00000010" , "00000100" , "11111000" , "00000000");
    when "1010111" => -- W 
        row_bits := ("11111110" , "00000100" , "00011000" , "00000100" , "11111110" , "00000000");
    when "1011000" => -- X 
        row_bits := ("11000110" , "00101000" , "00010000" , "00101000" , "11000110" , "00000000");
    when "1011001" => -- Y 
        row_bits := ("11000000" , "00100000" , "00011110" , "00100000" , "11000000" , "00000000");
    when "1011010" => -- Z 
        row_bits := ("10000110" , "10001010" , "10010010" , "10100010" , "11000010" , "00000000");
    when "0110000" => -- 0 
        row_bits := ("01111100" , "10001010" , "10010010" , "10100010" , "01111100" , "00000000");
    when "0110001" => -- 1 
        row_bits := ("00000000" , "01000010" , "11111110" , "00000010" , "00000000" , "00000000");
    when "0110010" => -- 2 
        row_bits := ("01000110" , "10001010" , "10010010" , "10010010" , "01100000" , "00000000");
    when "0110011" => -- 3 
        row_bits := ("01000100" , "10000010" , "10010010" , "10010010" , "01101100" , "00000000");
    when "0110100" => -- 4 
        row_bits := ("00011000" , "00101000" , "01001000" , "11111110" , "00001000" , "00000000");
    when "0110101" => -- 5 
        row_bits := ("11100100" , "10100010" , "10100010" , "10100010" , "10011100" , "00000000");
    when "0110110" => -- 6 
        row_bits := ("00111100" , "01010010" , "10010010" , "10010010" , "10001100" , "00000000");
    when "0110111" => -- 7 
        row_bits := ("10000000" , "10001110" , "10010000" , "10100000" , "11000000" , "00000000");
    when "0111000" => -- 8 
        row_bits := ("01101100" , "10010010" , "10010010" , "10010010" , "01101100" , "00000000");
    when "0111001" => -- 9 
        row_bits := ("01100100" , "10010010" , "10010010" , "10010010" , "01111100" , "00000000");
    when "0100000" => -- Blank 
        row_bits := ("00000000" , "00000000" , "00000000" , "00000000" , "00000000" , "00000000");
    when "0101101" => -- Dash 
        row_bits := ("00010000" , "00010000" , "00010000" , "00010000" , "00010000" , "00000000");
    when others => -- Error
        row_bits := ("10010010" , "10010010" , "10010010" , "10010010" , "10010010" , "00000000");
	end case;
	return row_bits;
end function get_row_bits;
	
type final_message_array_type is array (0 to matrix_length) of std_logic_vector(7 downto 0); -- 173 = message_length * 6 - 1

function get_final_message_array(message: string := "BME-393L DIGITAL SYSTEMS LAB ") return final_message_array_type is
	variable final_message_array: final_message_array_type := (others => "00000000");
	variable current_row_bits: row_bits_matrix;
	variable counter : integer := 0;
	begin
--		final_message_array := null;
		for i in 1 to message'length loop
			
			current_row_bits := get_row_bits(std_logic_vector(to_unsigned(character'pos(message(i)), 7))); -- std_logic_vector
			for j in 0 to 5 loop
					final_message_array(counter) := current_row_bits(j);
					counter := counter + 1;
			end loop;
		end loop;
	return final_message_array;
end function get_final_message_array;
			
component clock_divider is
	port ( 	
				clock_in: in std_logic;
				num_of_rising_edges: in integer;
				clock_out: out std_logic
);
end component;

signal final_message_matrix : final_message_array_type := (get_final_message_array(message));

signal row_driver: std_logic_vector(7 downto 0) := "11111110"; -- top row to bottom row, red to green is row 1 to 8, should be the first element in the matrix
signal col_driver: std_logic_vector(0 to 7) := "01111111"; -- left col to right col, orange to black is col 1 to 8
signal slow_clock, fast_clock: std_logic;
signal current_row_index: unsigned(2 downto 0);

signal done_filling_matrix: std_logic := '0'; -- UNUSED
begin 


fast_clock_inst: entity work.clock_divider(clock_divider_architecture) port map (CLOCK_50_B5B, 25000, fast_clock);
slow_clock_inst: entity work.clock_divider(clock_divider_architecture) port map (CLOCK_50_B5B, 5000000, slow_clock);

current_row_index <= current_row_index + 1 when rising_edge(fast_clock); 

final_message_matrix <= final_message_matrix(1 to matrix_length) & final_message_matrix(0) when rising_edge(slow_clock);  	

row_driver <= final_message_matrix(to_integer(current_row_index)); 

col_driver <= col_driver(7) & col_driver(0 to 6) when rising_edge(fast_clock);
							
GPIO( 1) <= row_driver(0); -- bottom row
GPIO( 3) <= row_driver(1); 
GPIO( 5) <= row_driver(2); 
GPIO( 7) <= row_driver(3); 
GPIO( 9) <= row_driver(4); 
GPIO(11) <= row_driver(5); 
GPIO(13) <= row_driver(6); 
GPIO(15) <= row_driver(7); -- top row

GPIO(21) <= col_driver(0); -- left col
GPIO(23) <= col_driver(1); 
GPIO(25) <= col_driver(2); 
GPIO(27) <= col_driver(3); 
GPIO(29) <= col_driver(4); 
GPIO(31) <= col_driver(5); 
GPIO(33) <= col_driver(6); 
GPIO(35) <= col_driver(7); -- right col
end architecture final_message_architecture; 

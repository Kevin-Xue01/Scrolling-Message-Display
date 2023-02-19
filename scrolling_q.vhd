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


entity scrolling_q is 
	port( 
			CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
			GPIO:			out std_logic_vector(35 downto 0)
		); 
end entity scrolling_q; 


architecture scrolling_q_architecture of scrolling_q is 

component clock_divider is
	port ( 	
				clock_in: in std_logic;
				num_of_rising_edges: in integer;
				clock_out: out std_logic
);
end component;

type matrix is array (0 to 7) of std_logic_vector(7 downto 0);

signal scrolling_q_matrix : matrix := ("01111100","10000010","10001010","10000100","01111010","00000000","00000000","00000000");
signal row_driver: std_logic_vector(7 downto 0) := "01111100"; -- top row to bottom row, red to green is row 1 to 8
signal col_driver: std_logic_vector(0 to 7) := "01111111"; -- left col to right col, orange to black is col 1 to 8
signal slow_clock, fast_clock: std_logic;
signal current_row_index: unsigned(2 downto 0);
begin 

fast_clock_inst: entity work.clock_divider(clock_divider_architecture) port map (CLOCK_50_B5B, 25000, fast_clock);
slow_clock_inst: entity work.clock_divider(clock_divider_architecture) port map (CLOCK_50_B5B, 5000000, slow_clock);

current_row_index <= current_row_index + 1 when rising_edge(fast_clock); 

scrolling_q_matrix <= scrolling_q_matrix(1 to 7) & scrolling_q_matrix(0) when rising_edge(slow_clock);  	

row_driver <= scrolling_q_matrix(to_integer(current_row_index)); 

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
end architecture scrolling_q_architecture; 

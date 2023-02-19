library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
  
entity clock_divider is
	port ( 	
				clock_in, reset: in std_logic;
				clock_out: out std_logic
);
end clock_divider;
  
architecture clock_divider_architecture of clock_divider is
  
signal counter: integer := 1;
signal output : std_logic := '0';
  
begin
  
Clock_divider_process: process(clock_in, reset)
begin

if(reset = '1') then
	counter <= 1;
	output <= '0';
	
elsif rising_edge(clock_in) then
	if (counter = 25000000) then
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


entity dot_scrolling is 
	port( 
			CLOCK_50_B5B:	in  std_logic ;    -- 50MHz clock on the board 
			GPIO:			out std_logic_vector(35 downto 0)
		); 
end entity dot_scrolling; 


architecture dot_scrolling_architecture of dot_scrolling is 

component clock_divider is
	port ( 	
				clock_in, reset: in std_logic;
				clock_out: out std_logic
);
end component;

signal row_driver: std_logic_vector(7 downto 0) := "10000000"; 
signal col_driver: std_logic_vector(0 to 7) := "01111111"; 
signal one_hertz_clock: std_logic;

begin 
clock_divider_inst: entity work.clock_divider(clock_divider_architecture) port map (CLOCK_50_B5B, '0', one_hertz_clock);

scroll_dot_process: process (one_hertz_clock)
begin
if rising_edge(one_hertz_clock) then
	if (col_driver(7) = '0') then
       row_driver <= row_driver(0) & row_driver(7 downto 1);
   end if;
	col_driver <= col_driver(7) & col_driver(0 to 6);
end if;
end process;

GPIO( 1) <= row_driver(0); 	-- Pin connections between GPIO port and the PCB 
GPIO( 3) <= row_driver(1); 
GPIO( 5) <= row_driver(2); 
GPIO( 7) <= row_driver(3); 
GPIO( 9) <= row_driver(4); 
GPIO(11) <= row_driver(5); 
GPIO(13) <= row_driver(6); 
GPIO(15) <= row_driver(7); 

GPIO(21) <= col_driver(0); 
GPIO(23) <= col_driver(1); 
GPIO(25) <= col_driver(2); 
GPIO(27) <= col_driver(3); 
GPIO(29) <= col_driver(4); 
GPIO(31) <= col_driver(5); 
GPIO(33) <= col_driver(6); 
GPIO(35) <= col_driver(7); 
end architecture dot_scrolling_architecture; 

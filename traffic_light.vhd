-- P.S this vhdl program was created for educational purposes. Please do not implement in real life traffic signal.
-- The vhdl code does not have delay, counter, or sensor. 
library ieee;
use ieee.std_logic_1164.all; 

entity traffic_light_controller is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           d : in  STD_LOGIC;
           r1 : out  STD_LOGIC; -- red light N-S
           y1 : out  STD_LOGIC; -- yellow light N-S 
           g1 : out  STD_LOGIC; -- green light N-S
           r2 : out  STD_LOGIC; -- red light E-W
           y2 : out  STD_LOGIC; -- yellow light E-W	
           g2 : out  STD_LOGIC); -- green lisht E-W
end traffic_light_controller;

architecture Behavioral of traffic_light_controller is
type statetype is (s0,s1,s2,s3,s4,s5);
signal currentstate, nextstate: statetype;

begin

process (clk,reset) begin
if (reset = '0') then 
currentstate <= s0;
elsif (rising_edge(clk)) then 
currentstate <= nextstate;
end if; 
end process;

process (currentstate, nextstate, d)
begin 
case (currentstate) is 

when s0 => 
r1 <= '1'; -- red light N-S will turn on
y1 <= '0';
g1 <= '0';
r2 <= '1'; -- red light E-W will turn on 
y2 <= '0';
g2 <= '0';
if (d = '0') then 
nextstate <= s0;
else 
nextstate <= s1;
end if;

when s1 => 
r1 <= '0'; 
y1 <= '0';
g1 <= '1';-- green light N-S will turn on
r2 <= '1'; -- red light E-W will turn on 
y2 <= '0';
g2 <= '0';
if (d = '1') then 
nextstate <= s1;
else 
nextstate <= s2;
end if;

when s2 =>
r1 <= '0'; 
y1 <= '1';-- yellow light N-S will turn on
g1 <= '0';
r2 <= '1'; -- red light E-W will turn on 
y2 <= '0';
g2 <= '0';
if (d = '0') then 
nextstate <= s2;
else 
nextstate <= s3;
end if;

when s3 =>
r1 <= '1'; -- red light N-S will turn on
y1 <= '0';
g1 <= '0';
r2 <= '1'; -- red light E-W will turn on 
y2 <= '0';
g2 <= '0';
if (d = '1') then 
nextstate <= s3;
else 
nextstate <= s4;
end if;

when s4 =>
r1 <= '1'; -- red light N-S will turn on
y1 <= '0';
g1 <= '0';
r2 <= '0'; 
y2 <= '0';
g2 <= '1'; -- green light E-W will turn on 
if (d = '0') then 
nextstate <= s4;
else 
nextstate <= s5;
end if;

when s5 =>
r1 <= '1'; -- red light N-S will turn on
y1 <= '0';
g1 <= '0';
r2 <= '0'; 
y2 <= '1';-- yellow light E-W will turn on 
g2 <= '0';
if (d = '1') then 
nextstate <= s5;
else 
nextstate <= s0;
end if;

end case;
end process;

end Behavioral;

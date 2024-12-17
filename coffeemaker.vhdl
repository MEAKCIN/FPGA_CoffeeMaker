library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity coffeemaker is
  Port ( clk : in  STD_LOGIC;
         led : out STD_LOGIC_Vector(4 downto 0) ;
         sw  : in STD_LOGIC_Vector (4 downto 0)
       );
end coffeemaker;

-- sw0 for power on and off
-- sw1 for espresso on and lungo off
-- sw2 most significant bit pw3
-- sw3 second most pw2 
-- sw4 least significant bit pw1
-- passwords: "000" "001" "011"
architecture Behavioral of coffeemaker is
  signal pulse : std_logic := '0';
  signal count : integer range 0 to 99999999 := 0;
begin
  process(clk, sw)
  begin
    
    
    if sw(0) = '0' or not ((sw(2)= '0' and sw(3)= '0' and sw(4)= '0')
    or (sw(2)= '0' and sw(3)= '0' and sw(4)= '1')or (sw(2)= '0' and sw(3)= '1' and sw(4)= '1') ) then
        pulse <= '0';
    elsif clk'event and clk = '1' then
    --99999999
      if count >= 49999999 then
        count <= 0;
        pulse <= not pulse;
      elsif sw(1)= '0' or (count=49999998 ) then
        count <= count + 1;
      elsif sw(1)='1' and not(count=49999998) then
        count <= count+2;
      end if;
    end if;
  end process;
  led(4 downto 1)<= sw(4 downto 1);

  led(0) <= pulse;
end Behavioral;

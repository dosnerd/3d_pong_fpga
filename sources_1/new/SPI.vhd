----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 15:06:07
-- Design Name: 
-- Module Name: SPI - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI is
    Port ( 
           clk_in       : in STD_LOGIC;
           data_in      : in STD_LOGIC;
           clock_in     : in STD_LOGIC;
           SS           : in STD_LOGIC;
           data_ready   : out STD_LOGIC;
           data_out     : out STD_LOGIC_VECTOR(15 downto 0);
           led_out      : out STD_LOGIC_VECTOR(15 downto 0)
           );
end SPI;

architecture Behavioral of SPI is
begin

process(clock_in)
    variable t : boolean := true;
begin
if (rising_edge(clock_in)) then
    if (t) then
        t := false;
        led_out(0) <= '1';
    else
        t := true;
        led_out(0) <= '0';
        
    end if;
end if;
end process;

--process(clk_in)
--    variable buff : STD_LOGIC_VECTOR(15 downto 0);
--    variable counter : INTEGER;
--    variable last_ss, last_clock : STD_LOGIC;
--begin
--if rising_edge(clk_in) then
--    if (clock_in = '1' AND last_clock = '0') then
--        buff := data_in & buff(15 downto 1);
--        data_ready <= '0';
--    end if;
--    if (ss = '0' AND last_ss = '1') then
--       data_out <= buff;  
--       --led_out <= buff;
--       data_ready <= '1';
--    end if;
--last_clock := clock_in;              
--last_ss := ss;
--led_out(0) <= ss;
--led_out(1) <= clock_in;
--end if;

--end process;
end Behavioral;

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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SPI is
    Port ( data_in      : in STD_LOGIC;
           clock_in     : in STD_LOGIC;
           SS           : in STD_LOGIC;
           data_ready   : out STD_LOGIC;
           data_out     : out STD_LOGIC_VECTOR (15 downto 0)
           );
end SPI;

architecture Behavioral of SPI is

begin

process(clock_in, SS)
    variable buff : STD_LOGIC_VECTOR(15 downto 0);
begin

if rising_edge(clock_in) then
    buff := data_in & buff(15 downto 1);
    data_ready <= '0';
end if;

if rising_edge(SS) then
    data_out <= buff;           
    data_ready <= '1';
end if;

end process;
end Behavioral;

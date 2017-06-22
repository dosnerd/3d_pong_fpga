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
           data_in      : in STD_LOGIC;
           clock_in     : in STD_LOGIC;
           SS           : in STD_LOGIC;
           data_ready   : out STD_LOGIC;
           data_out     : out STD_LOGIC_VECTOR(15 downto 0)
           );
end SPI;

architecture Behavioral of SPI is
    signal buff : STD_LOGIC_VECTOR(15 downto 0);
begin

    data_out <= buff when SS = '1';
    data_ready <= ss; 

process(clock_in)
begin
if (rising_edge(clock_in)) then
    if (SS = '0') then
        buff <= buff(14 downto 0) & data_in;
    end if;
end if;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 13:18:46
-- Design Name: 
-- Module Name: PixelSelect - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PixelSelect is
    Port ( VGAx : in STD_LOGIC_VECTOR (9 downto 0);
           VGAy : in STD_LOGIC_VECTOR (9 downto 0);
           spriteColor : in STD_LOGIC_VECTOR (15 downto 0);
           clk100 : in STD_LOGIC;
           pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
           spriteAddr : out STD_LOGIC_VECTOR (2 downto 0));
end PixelSelect;

architecture Behavioral of PixelSelect is

begin

process (clk100)
    variable i : integer range 0 to 5 := 0;
    variable color : integer := 0;
begin
    if (rising_edge(clk100)) then
        if (i < 3) then
            spriteAddr <= std_logic_vector(to_unsigned(i, 3));
            i := i + 1;
        end if;
    end if;
end process;

end Behavioral;

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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PixelSelect is
    Port ( --VGAx : in STD_LOGIC_VECTOR (9 downto 0);
           --VGAy : in STD_LOGIC_VECTOR (9 downto 0);
           spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
           clk100 : in STD_LOGIC;
           reset : in STD_LOGIC;
           pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
           spriteAddr : out STD_LOGIC_VECTOR (2 downto 0));
end PixelSelect;

architecture Behavioral of PixelSelect is
    SIGNAl temp : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
begin

process (clk100)
    variable i : integer range 0 to 8 := 0;
    variable color : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
begin
    --temp(10 downto 0) <= spriteColor(10 downto 0);
    --temp(11) <= reset;
    if reset = '1' then
        i := 0;
    elsif (i < 7) then
        --when no sprite drawed, no division;
        if (color = 0 and spriteColor(12) = '0')then
            color := spriteColor(11 downto 0);
        else
            --devide to 2
            color := '0' & color(10 downto 0);
            color := color + ('0' & spriteColor(11 downto 1));
            --color := ('0' & spriteColor(11 downto 1));
        end if;
        
        --when solid sprite, exit
        if spriteColor(12) = '0' then
            i := 6;
        end if;
        
        i := i + 1;
        spriteAddr <= std_logic_vector(to_unsigned(i, 3));   
    elsif (i = 7) then
        pixelOut <= color;
        i := i + 1;
        spriteAddr <= (others => '0');
    end if;
    
        temp <= color;
end process;

end Behavioral;

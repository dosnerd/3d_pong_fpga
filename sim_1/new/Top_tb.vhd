----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.03.2017 11:26:24
-- Design Name: 
-- Module Name: Top_tb - Behavioral
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

use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_tb is
--  Port ( );
end Top_tb;

architecture Behavioral of Top_tb is
    component Top is
      Port ( 
        clk100 : in STD_LOGIC;
        Hsync : out STD_LOGIC;
        vSync : out STD_LOGIC;
        vgaRed : out STD_LOGIC_VECTOR(3 downto 0);
        vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
        vgaBlue : out STD_LOGIC_VECTOR(3 downto 0);
        
        
        Hsync2 : out STD_LOGIC;
        vSync2 : out STD_LOGIC;
        vgaRed2 : out STD_LOGIC_VECTOR(3 downto 0);
        vgaGreen2 : out STD_LOGIC_VECTOR(3 downto 0);
        vgaBlue2 : out STD_LOGIC_VECTOR(3 downto 0)
        
        --debug
--        spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
--        pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
--        reset : in STD_LOGIC;
--        spriteAddr : out STD_LOGIC_VECTOR (2 downto 0)
      );
    end component;
    
    SIGNAL clock : STD_LOGIC := '0';    
begin

test: top port map(
    clk100 => clock
--    spriteColor => spriteColor,
--    reset => reset
);

clock_gen: process
begin
    wait for 10ns;
    clock <= '1';
    wait for 10ns;
    clock <= '0';
end process;

debug: process(clock)
begin        
end process;
end Behavioral;
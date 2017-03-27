----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/16/2017 03:46:04 PM
-- Design Name: 
-- Module Name: VGA_controller - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_controller is
    Port ( 
    
           clk_in : in STD_LOGIC;
           sprite_color : in STD_LOGIC_VECTOR (11 downto 0);
           set_rgb : out STD_LOGIC_VECTOR (11 downto 0);
           vsync : out STD_LOGIC;
           hsync : out STD_LOGIC;
           position_y : out STD_LOGIC_VECTOR (9 downto 0);
           position_x : out STD_LOGIC_VECTOR (9 downto 0));
end VGA_controller;

architecture Behavioral of VGA_controller is
      signal hcount: STD_LOGIC_VECTOR(9 downto 0);
      signal vcount: STD_LOGIC_VECTOR(9 downto 0);

begin

process (clk_in)
    
begin
    if rising_edge(clk_in) then
	   if (hcount >= 144) and (hcount < 784) and (vcount >= 31) and (vcount < 511) then
	   
        set_rgb(0) <= sprite_color(0);
        set_rgb(1) <= sprite_color(1);
        set_rgb(2) <= sprite_color(2);
      else

      
        set_rgb(0) <= '0';
        set_rgb(1) <= '0';
        set_rgb(2) <= '0';
      end if;
      
      --calculate x,y of visible screen
      position_y <= vcount - 31;
      position_x <= hcount - 143;
      
      
	 -- While on screen area,
     -- hsync = 1 (low active)
      if hcount < 97 then
        hsync <= '0';
      else
        hsync <= '1';
      end if;

      -- While on screen area,
      -- Vsync = 1 (low active)
      if vcount < 3 then
        vsync <= '0';
      else
        vsync <= '1';
      end if;
	 
      hcount <= hcount + 1;
	 
	 -- Reset teller
      if hcount = 800 then
        vcount <= vcount + 1;
        hcount <= (others => '0');
      end if;
	 
	 -- Reset teller
      if vcount = 521 then		    
        vcount <= (others => '0');
      end if;
      
--      if (vcount - 31 < 0) then
--        position_y <= (others => '0'); 
--      else
--        position_y <= vcount - 31;
--      end if;
      
--      if (hcount - 144 < 0) then
--        position_x <= (others => '0'); 
--      else
--        position_x <= hcount - 144;
--      end if;
      
	 end if;
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 13:19:11
-- Design Name: 
-- Module Name: Top - Behavioral
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

entity Top is
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
--    reset : in STD_LOGIC;
--    spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
--    pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
--    spriteAddr : out STD_LOGIC_VECTOR (2 downto 0)
    
  );
end Top;

architecture Behavioral of Top is
    component VGA_controller is
        Port ( 
               clk_in : in STD_LOGIC;
               sprite_color : in STD_LOGIC_VECTOR (11 downto 0);
               set_rgb : out STD_LOGIC_VECTOR (11 downto 0);
               vsync : out STD_LOGIC;
               hsync : out STD_LOGIC;
               position_y : out STD_LOGIC_VECTOR (9 downto 0);
               position_x : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    component clk100_to_25 is
        Port (
               clk_out1 : out STD_LOGIC;
               clk_out2 : out STD_LOGIC;
               clk_in1 : in STD_LOGIC
        );
    end component;
    
    component RAM_controller is
      Port (
            clk25, clk200 : in STD_LOGIC;
            X_left, Y_left, X_right, Y_right : in STD_LOGIC_VECTOR (9 downto 0);
            pixel_left, pixel_right : out STD_LOGIC_VECTOR (11 downto 0)
      );
    end component;

    SIGNAL clk25 : STD_LOGIC;
    SIGNAL clk200 : STD_LOGIC;
    SIGNAL X_left, Y_left, X_right, Y_right : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL pixel_left, pixel_right : STD_LOGIC_VECTOR (11 downto 0);
begin

clk_div1: clk100_to_25 PORT MAP (
    clk_in1 => clk100,
    clk_out1 => clk25,
    clk_out2 => clk200
);

ram: RAM_controller PORT MAP(
    clk25 => clk25,
    clk200 => clk200,
    X_left => X_left,
    X_right => X_right,
    Y_left => Y_left,
    Y_right => Y_right,
    pixel_left => pixel_left,
    pixel_right => pixel_right
);

end Behavioral;

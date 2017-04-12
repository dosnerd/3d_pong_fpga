----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2017 19:17:26
-- Design Name: 
-- Module Name: top2 - Behavioral
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

entity top2 is
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
    );
end top2;

architecture Behavioral of top2 is
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
    
    component background is
        Port ( 
            clk25 : in STD_LOGIC;
            X, Y : in STD_LOGIC_VECTOR (9 downto 0);
            output : out STD_LOGIC_VECTOR (11 downto 0);
            empty: out STD_LOGIC
        );
    end component;
    
    SIGNAL clk25 : STD_LOGIC;
    SIGNAL clk200 : STD_LOGIC;
    SIGNAL X, Y : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL pixel_left : STD_LOGIC_VECTOR (11 downto 0);
begin

clk_div1: clk100_to_25 PORT MAP (
    clk_in1 => clk100,
    clk_out1 => clk25,
    clk_out2 => clk200
);

VGAleft: VGA_controller PORT MAP (    
    clk_in => clk25,
    sprite_color => pixel_left,
    set_rgb(3 downto 0) => vgaRed, 
    set_rgb(7 downto 4) => vgaGreen, 
    set_rgb(11 downto 8) => vgaBlue, 
    hsync => Hsync,
    vsync => vSync,
    position_x => X,
    position_y => Y
);

backgr: background PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    output => pixel_left
);

end Behavioral;

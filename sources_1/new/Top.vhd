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
    vgaBlue2 : out STD_LOGIC_VECTOR(3 downto 0);
    
    --debug
    reset : in STD_LOGIC;
    spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
    pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
    spriteAddr : out STD_LOGIC_VECTOR (2 downto 0)
    
  );
end Top;

architecture Behavioral of Top is

    component PixelSelect is
        Port ( --VGAx : in STD_LOGIC_VECTOR (9 downto 0);
           --VGAy : in STD_LOGIC_VECTOR (9 downto 0);
           spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
           clk100 : in STD_LOGIC;
           reset : in STD_LOGIC;
           pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
           spriteAddr : out STD_LOGIC_VECTOR (2 downto 0));
    end component;
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
               clk_in1 : in STD_LOGIC
        );
    end component;
    component ram_controller is
        Port ( VGAleft : in STD_LOGIC_VECTOR (19 downto 0);
               VGAright : in STD_LOGIC_VECTOR (19 downto 0);
               addr_left : in STD_LOGIC_VECTOR (2 downto 0);
               addr_right : in STD_LOGIC_VECTOR (2 downto 0);
               addr_spi : in STD_LOGIC_VECTOR (19 downto 0);
               data_spi : in STD_LOGIC_VECTOR (15 downto 0);
               data_left : out STD_LOGIC_VECTOR (12 downto 0);
               data_right : out STD_LOGIC_VECTOR (12 downto 0));
    end component;

    SIGNAL clk25 : STD_LOGIC;
    
    SIGNAL VGAaddressLeft : STD_LOGIC_VECTOR(19 downto 0);
    SIGNAL VGApixelLeft : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAl spriteColorLeft : STD_LOGIC_VECTOR (12 downto 0);
    SIGNAL spriteAddressLeft : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL resetPixelLeft : STD_LOGIC := '1';

    SIGNAL VGAaddressRight : STD_LOGIC_VECTOR(19 downto 0);
    SIGNAL VGApixelRight : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAl spriteColorRight : STD_LOGIC_VECTOR (12 downto 0);
    SIGNAL spriteAddressRight : STD_LOGIC_VECTOR (2 downto 0);
    SIGNAL resetPixelRight : STD_LOGIC := '1';
begin
clk_div1: clk100_to_25 PORT MAP (
    clk_in1 => clk100,
    clk_out1 => clk25
);

ram: ram_controller PORT MAP (
    VGAleft => VGAaddressLeft,
    VGAright => VGAaddressRight,
    addr_left => spriteAddressLeft,
    addr_right => spriteAddressRight,
    addr_spi => (others => '0'),
    data_spi => (others => '0'),
    
    data_left => spriteColorLeft,
    data_right => spriteColorRight
);

PSleft: PixelSelect PORT MAP (
    --VGAx => VGAaddressLeft(9 downto 0),
    --VGAy => VGAaddressLeft(19 downto 10),
--    spriteColor => spriteColorLeft,
    clk100 => clk100,
--    pixelOut => VGApixelLeft,
--    spriteAddr => spriteAddressLeft

--debug
    spriteColor => spriteColor,
    pixelOut => pixelOut,
    reset => reset,
    spriteAddr => spriteAddr
);

VGAleft: VGA_controller PORT MAP (    
    clk_in => clk25,
    sprite_color => VGApixelLeft,
    set_rgb(3 downto 0) => vgaRed, 
    set_rgb(7 downto 4) => vgaGreen, 
    set_rgb(11 downto 8) => vgaBlue, 
    hsync => Hsync,
    vsync => Vsync,
    position_x => VGAaddressLeft(9 downto 0),
    position_y => VGAaddressLeft(19 downto 10)
);

PSright: PixelSelect PORT MAP (
    --VGAx => VGAaddressRight(9 downto 0),
    --VGAy => VGAaddressRight(19 downto 10),
    spriteColor => spriteColorRight,
    clk100 => clk100,
    reset => resetPixelRight,
    pixelOut => VGApixelRight,
    spriteAddr => spriteAddressRight
);

VGAright: VGA_controller PORT MAP (    
    clk_in => clk25,
    sprite_color => VGApixelRight,
    set_rgb(3 downto 0) => vgaRed2, 
    set_rgb(7 downto 4) => vgaGreen2, 
    set_rgb(11 downto 8) => vgaBlue2, 
    hsync => Hsync2,
    vsync => Vsync2,
    position_x => VGAaddressRight(9 downto 0),
    position_y => VGAaddressRight(19 downto 10)
);

end Behavioral;

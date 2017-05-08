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
    SPI_data    : in STD_LOGIC;
    SPI_clock   : in STD_LOGIC;
    SPI_ss      : in STD_LOGIC;
  
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
    
    sw : in STD_LOGIC_VECTOR(15 downto 0);
    led : out STD_LOGIC_VECTOR(15 downto 0)
    --debug
--    reset : in STD_LOGIC;
--    spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
--    pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
--    spriteAddr : out STD_LOGIC_VECTOR (2 downto 0)
    
  );
end Top;

architecture Behavioral of Top is
    component SPI is
        Port ( 
                data_in      : in STD_LOGIC;
                clock_in     : in STD_LOGIC;
                SS           : in STD_LOGIC;
                data_ready   : out STD_LOGIC;
                data_out     : out STD_LOGIC_VECTOR(15 downto 0));
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
               clk_out2 : out STD_LOGIC;
               clk_in1 : in STD_LOGIC
        );
    end component;
    
    component RAM_controller is
      Port (
          clk25, clk200 : in STD_LOGIC;
          X, Y: in STD_LOGIC_VECTOR (9 downto 0);
          SPI : in STD_LOGIC_VECTOR(15 downto 0);
          SPI_E : in STD_LOGIC;
          test_mode : in STD_LOGIC;
          infrared_ball : in STD_LOGIC;
          pixel_left, pixel_right : out STD_LOGIC_VECTOR (11 downto 0);
          led_out      : out STD_LOGIC_VECTOR(15 downto 0)
      );
    end component;

    SIGNAL clk25 : STD_LOGIC;
    SIGNAL clk200 : STD_LOGIC;
    SIGNAL X, Y : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL pixel_left, pixel_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL SPI_databus : STD_LOGIC_VECTOR(15 downto 0);
    SIGNAL SPI_CLOCK_TEMP, SPI_TEMP_SS, SPI_READY : STD_LOGIC;
    
begin

communication: SPI port map(
    data_in => SPI_data,
    clock_in => SPI_CLOCK_TEMP,
    SS => SPI_TEMP_SS,
    data_ready => SPI_READY,
    data_out => SPI_databus
);

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

VGAright: VGA_controller PORT MAP (    
    clk_in => clk25,
    sprite_color => pixel_right,
    set_rgb(3 downto 0) => vgaRed2, 
    set_rgb(7 downto 4) => vgaGreen2, 
    set_rgb(11 downto 8) => vgaBlue2, 
    hsync => Hsync2,
    vsync => vSync2
);

ram: RAM_controller PORT MAP(
    clk25 => clk25,
    clk200 => clk200,
    SPI => spi_databus,
    SPI_E => SPI_ready,
    X => X,
    Y => Y,
    test_mode => sw(0),
    infrared_ball => sw(1),
    pixel_left => pixel_left,
    pixel_right => pixel_right,
    led_out => led
);

process(clk100) 
    variable temp_clk, temp_ss: STD_LOGIC_VECTOR(2 downto 0);
begin
    if rising_edge(clk100) then
        temp_clk(2 downto 0) := temp_clk(1 downto 0) & spi_clock;
        if(temp_clk(2) = temp_clk(1) AND temp_clk(1) = temp_clk(0)) then
            SPI_CLOCK_TEMP <= temp_clk(0);
        end if; 
        temp_ss(2 downto 0) := temp_ss(1 downto 0) & spi_ss;
        if(temp_ss(2) = temp_ss(1) AND temp_ss(1) = temp_ss(0)) then
            SPI_TEMP_SS <= temp_ss(0);
        end if;
    end if;
end process;

end Behavioral;

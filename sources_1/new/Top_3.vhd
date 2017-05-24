----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2017 02:18:55 PM
-- Design Name: 
-- Module Name: Top_3 - Behavioral
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

entity Top_3 is
    Port (
       clk100 : in STD_LOGIC;
     Hsync : out STD_LOGIC;
     vSync : out STD_LOGIC;
     vgaRed : out STD_LOGIC_VECTOR(3 downto 0);
     vgaGreen : out STD_LOGIC_VECTOR(3 downto 0);
     vgaBlue : out STD_LOGIC_VECTOR(3 downto 0) 
    );
end Top_3;

architecture Behavioral of Top_3 is

    component clk100_to_25 is
    Port (
           clk_out1 : out STD_LOGIC;
           clk_out2 : out STD_LOGIC;
           clk_in1 : in STD_LOGIC
    );
    end component;

    component VGA_controller is
    Port ( 
           clk_in : in STD_LOGIC;
           sprite_color : in STD_LOGIC_VECTOR (11 downto 0);
           set_rgb : out STD_LOGIC_VECTOR (11 downto 0);
           vsync : out STD_LOGIC;
           hsync : out STD_LOGIC;
           position_y : out STD_LOGIC_VECTOR (9 downto 0);
           position_x : out STD_LOGIC_VECTOR (9 downto 0)
    );
    end component;

    component font_rom is
    Port(
       clk: in std_logic;
       addr: in std_logic_vector(10 downto 0);
       data: out std_logic_vector(7 downto 0)
    );
    end component;
    
    component char_mem is
       port(
          clk: in std_logic;
          char_read_addr : in std_logic_vector(11 downto 0);
          char_write_addr: in std_logic_vector(11 downto 0);
          char_we : in std_logic;
          char_write_value : in std_logic_vector(7 downto 0);
          char_read_value : out std_logic_vector(7 downto 0)
       );
    end component;
    
    SIGNAL clk25, clk200 : STD_LOGIC;
    SIGNAL X, Y : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL pixel_left, pixel_right : STD_LOGIC_VECTOR (11 downto 0);
    
    SIGNAL addr_temp1 : STD_LOGIC_VECTOR(10 downto 0);
    SIGNAL addr_temp2 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL addr_r_temp, addr_w_temp : STD_LOGIC_VECTOR(11 downto 0);
    SIGNAL data_temp, char_w_temp, char_r_temp : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL char_e_temp : STD_LOGIC;
    
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

font_rom_test: font_rom PORT MAP (
    clk => clk25, 
    addr => addr_temp1,
    data => data_temp
);

char_mem_test: char_mem PORT MAP (
    clk => clk25,
    char_read_addr => addr_r_temp, 
    char_write_addr => addr_w_temp,
    char_we => char_e_temp,
    char_write_value => char_w_temp,
    char_read_value => addr_temp2
);

process(clk25) --loop
    variable bitInChar, column, bitInRow, row : integer := 0;
begin
    if (rising_edge(clk25)) then
        row := to_integer(unsigned(Y(9 downto 4)));
        column := to_integer(unsigned(X(9 downto 3)));
        addr_r_temp <= std_logic_vector(to_unsigned(row * 128 + column, 12));
    end if;
    if (falling_edge(clk25)) then
        addr_temp1 <= addr_temp2(6 downto 0) & Y(3 downto 0);
        if (data_temp(to_integer(unsigned(X(2 downto 0)))) = '1') then
            pixel_left <= "000011110000";
        else 
            pixel_left <= "000000000000";
        end if;
    end if;
end process;

end Behavioral;

--        if (bitInChar = 8) then
--            bitInChar := 0;
--            column := column + 1;
--            if (column = 128) then
--                column := 0;
--                bitInRow := bitInRow + 1;
--                if (bitInRow = 16) then
--                    row := row + 1;
--                    bitInRow := 0;
--                    if (row = 31) then
--                        row := 0;
--                    end if;
--                end if;
--            end if;
--        end if;

--        bitInChar := bitInChar + 1;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2017 15:08:35
-- Design Name: 
-- Module Name: RAM_controller - Behavioral
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

entity RAM_controller is
  Port (
        clk25, clk200 : in STD_LOGIC;
        X, Y: in STD_LOGIC_VECTOR (9 downto 0);
        pixel_left, pixel_right : out STD_LOGIC_VECTOR (11 downto 0)
  );
end RAM_controller;

architecture Behavioral of RAM_controller is
    component ball is
        Port ( 
            clk25 : in STD_LOGIC;
            X, Y : in STD_LOGIC_VECTOR (9 downto 0);
            x_index, y_index, z_index : in INTEGER;
            out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
            empty_left, empty_right : out STD_LOGIC
        );
    end component;
    
    component bat1 is
        Port ( 
            clk25 : in STD_LOGIC;
            X, Y : in STD_LOGIC_VECTOR (9 downto 0);
            x_index, y_index, z_index : in INTEGER;
            out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
            empty_left, empty_right, opacity_left, opacity_right : out STD_LOGIC
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
    
    SIGNAL color : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL x_index_con, y_index_con, z_index_con : INTEGER;
    
    SIGNAL ball_left, ball_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL ball_emtpy_left, ball_emtpy_right : STD_LOGIC;
    
    SIGNAL bat1_left, bat1_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat1_emtpy_left, bat1_emtpy_right : STD_LOGIC;
    SIGNAL bat1_opacity_left, bat1_opacity_right : STD_LOGIC;
    
    SIGNAL bat2_left, bat2_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat2_emtpy_left, bat2_emtpy_right : STD_LOGIC;
    SIGNAL bat2_opacity_left, bat2_opacity_right : STD_LOGIC;
    
    SIGNAL background_pixel : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL background_empty : STD_LOGIC;
    
begin

ball_module: ball PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_con,
    y_index => y_index_con,
    z_index => z_index_con,
    out_left => ball_left,
    out_right => ball_right,
    empty_left => ball_emtpy_left,
    empty_right => ball_emtpy_right
);

bat1_module: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_con,
    y_index => y_index_con,
    z_index => -1,
    out_left => bat1_left,
    out_right => bat1_right,
    empty_left => bat1_emtpy_left,
    empty_right => bat1_emtpy_right,
    opacity_left => bat1_opacity_right, 
    opacity_right => bat1_opacity_right
);

bat2_module: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_con,
    y_index => y_index_con,
    z_index => -9,
    out_left => bat2_left,
    out_right => bat2_right,
    empty_left => bat2_emtpy_left,
    empty_right => bat2_emtpy_right,
    opacity_left => bat2_opacity_right, 
    opacity_right => bat2_opacity_right
);

backgr: background PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    output => background_pixel,
    empty => background_empty
);

mover: process(clk25)
    variable prescaler : integer := -1000;
    variable dir_x, dir_y, dir_z : boolean := true;
begin
    if (rising_edge(clk25)) then
        prescaler := prescaler + 1;
                
        if (prescaler >= 3000000) then
            prescaler := 0;
            
            if (x_index_con >= 320) then
                dir_x := false;
            elsif (x_index_con <= -320) then
                dir_x := true;
            end if;
        
            if (dir_x = true) then
                x_index_con <= x_index_con + 20;
            else
                x_index_con <= x_index_con - 20;
            end if;
            
            if (y_index_con >= 240) then
                dir_y := false;
            elsif (y_index_con <= -240) then
                dir_y := true;
            end if;
        
            if (dir_y = true) then
                y_index_con <= y_index_con + 40;
            else
                y_index_con <= y_index_con - 40;
            end if;
            
            if (z_index_con >= -1) then
                dir_z := false;
            elsif (z_index_con <= -9) then
                dir_z := true;
            end if;
        
            if (dir_z = true) then
                z_index_con <= z_index_con + 1;
            else
                z_index_con <= z_index_con - 1;
            end if;
        end if;
    end if;
end process;

left: process(clk25)
    variable left_color : STD_LOGIC_VECTOR (11 downto 0);
begin
    if (falling_edge(clk25)) then
        if (bat1_emtpy_left = '0') then
            left_color := bat1_left;
        elsif (ball_emtpy_left = '0') then
            left_color := ball_left;
        elsif (bat2_emtpy_left = '0') then
            left_color := bat2_left;
        else
            left_color := background_pixel;
        end if;
        
        pixel_left <= left_color; 
    end if;
end process;

right: process(clk25)
    variable right_color : STD_LOGIC_VECTOR (11 downto 0);
begin
    if (falling_edge(clk25)) then
        if (bat2_emtpy_right = '0') then
            right_color := bat2_right;
        elsif (ball_emtpy_right = '0') then
            right_color := ball_right;
        elsif (bat1_emtpy_right = '0') then
            right_color := bat1_right;
        else
            right_color := background_pixel;
        end if;
        
        pixel_right <= right_color;
    end if;
end process;

end Behavioral;



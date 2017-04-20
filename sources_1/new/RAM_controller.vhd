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
use IEEE.STD_LOGIC_SIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_controller is
  Port (
        clk25, clk200 : in STD_LOGIC;
        X, Y: in STD_LOGIC_VECTOR (9 downto 0);
        test_mode : in STD_LOGIC;
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
            color : STD_LOGIC_VECTOR (11 downto 0);
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
    
--    component ligths is
--      Port ( 
--            clk25 : in STD_LOGIC;
--            X, Y : in STD_LOGIC_VECTOR (9 downto 0);
--            X_ball, Y_ball, Z_left_ball : in integer;
--            output_left, output_right : out STD_LOGIC_VECTOR (11 downto 0);
--            empty_left, empty_right : out STD_LOGIC);
--    end component;
    
    SIGNAL color : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL x_index_con, y_index_con, z_index_con : INTEGER;
--    SIGNAL x_index_bal, y_index_bal, z_index_bal : INTEGER; --update them if
--    SIGNAL x_index_con2, y_index_con2, z_index_con2 : INTEGER; --update them if
    
    SIGNAL ball_left, ball_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL ball_emtpy_left, ball_emtpy_right : STD_LOGIC;
    
    SIGNAL bat1_left, bat1_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat1_emtpy_left, bat1_emtpy_right : STD_LOGIC;
    SIGNAL bat1_opacity_left, bat1_opacity_right : STD_LOGIC;
    
    SIGNAL bat2_left, bat2_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat2_emtpy_left, bat2_emtpy_right : STD_LOGIC;
    SIGNAL bat2_opacity_left, bat2_opacity_right : STD_LOGIC;
    
    SIGNAL background_pixel, ligth_pixel : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL background_empty, ligth_empty : STD_LOGIC;
    
    SIGNAL player1_color : STD_LOGIC_VECTOR(11 downto 0) := b"1111_1111_0000";
    SIGNAL player2_color : STD_LOGIC_VECTOR(11 downto 0) := b"0000_1111_1111";
    
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
    color => player1_color,
    out_left => bat1_left,
    out_right => bat1_right,
    empty_left => bat1_emtpy_left,
    empty_right => bat1_emtpy_right,
    opacity_left => bat1_opacity_left, 
    opacity_right => bat1_opacity_right
);

bat2_module: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_con,
    y_index => y_index_con,
    z_index => -9,
    color => player2_color,
    out_left => bat2_left,
    out_right => bat2_right,
    empty_left => bat2_emtpy_left,
    empty_right => bat2_emtpy_right,
    opacity_left => bat2_opacity_left, 
    opacity_right => bat2_opacity_right
);

--ligth: ligths PORT MAP(
--    clk25 => clk25,
--    X => X,
--    Y => Y,
--    X_ball => x_index_con,
--    Y_ball => y_index_con,
--    Z_left_ball  => z_index_con,
--    output_left => ligth_pixel,
--    empty_left => ligth_empty
--);

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
        if test_mode = '1' then
            prescaler := prescaler + 1;
                    
            if (prescaler >= 3000000) then
                prescaler := 0;
                
                if (x_index_con + 80 >= 320) then
                    dir_x := false;
                elsif (x_index_con - 80 <= -320) then
                    dir_x := true;
                end if;
            
                if (dir_x = true) then
                    x_index_con <= x_index_con + 60;
                else
                    x_index_con <= x_index_con - 60;
                end if;
                
                if (y_index_con + 70 >= 240) then
                    dir_y := false;
                elsif (y_index_con - 70 <= -240) then
                    dir_y := true;
                end if;
            
                if (dir_y = true) then
                    y_index_con <= y_index_con + 40;
                else
                    y_index_con <= y_index_con - 40;
                end if;
                
                if (z_index_con >= -8) then
                    dir_z := false;
                elsif (z_index_con <= -72) then
                    dir_z := true;
                end if;
            
                if (dir_z = true) then
                    z_index_con <= z_index_con + 2;
                else
                    z_index_con <= z_index_con - 2;
                end if;
            end if;
        end if;
    end if;
end process;

left: process(clk25)
    variable left_color, temp_color : STD_LOGIC_VECTOR (11 downto 0);
    variable stop, merge : BOOLEAN;
begin
    if (falling_edge(clk25)) then
        stop := false;
        merge := false;
        left_color := (others => '0');
        if (bat1_emtpy_left = '0' and not stop) then
            if (bat1_opacity_left = '1') then
                merge := true;
            else
                stop := true;
            end if;
            left_color := bat1_left;
        end if;
        if (ball_emtpy_left = '0' and not stop) then
            if(merge = true) then
                temp_color := ball_left;
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0));
            else
                left_color := ball_left;
            end if;   
             stop := true;
        end if;
        if (bat2_emtpy_left = '0' and not stop) then
            if(merge = true) then
                temp_color := bat2_left; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                left_color := bat2_left;
            end if;
            if (bat2_opacity_left = '1') then
                merge := true;
            else
                stop := true;
            end if;
        end if;
        if (background_empty = '0' and not stop) then
            if(merge = true) then
                temp_color := background_pixel; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                left_color := background_pixel;
            end if;
            stop := true;
        end if;
--        elsif (ligth_empty = '0') then
--            left_color := ligth_pixel;
        pixel_left <= left_color; 
    end if;
end process;

right: process(clk25)
    variable right_color, temp_color : STD_LOGIC_VECTOR (11 downto 0);
    variable stop, merge : BOOLEAN;
begin
    if (falling_edge(clk25)) then
        stop := false;
        merge := false;
        right_color := (others => '0');
        if (bat2_emtpy_right = '0' and not stop) then
            if (bat2_opacity_right = '1') then
                merge := true;
            else
                stop := true;
            end if;
            right_color := bat2_right;
        end if;
        if (ball_emtpy_right = '0' and not stop) then
            if(merge = true) then
                temp_color := ball_right;
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0));
            else
                right_color := ball_right;
            end if;   
             stop := true;
        end if;
        if (bat1_emtpy_right = '0' and not stop) then
            if(merge = true) then
                temp_color := bat1_right; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := bat1_right;
            end if;
            if (bat1_opacity_right = '1') then
                merge := true;
            else
                stop := true;
            end if;
        end if;
        if (background_empty = '0' and not stop) then
            if(merge = true) then
                temp_color := background_pixel; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := background_pixel;
            end if;
            stop := true;
        end if;
--        elsif (ligth_empty = '0') then
--            right_color := ligth_pixel;
        pixel_right <= right_color; 
    end if;
end process;

end Behavioral;



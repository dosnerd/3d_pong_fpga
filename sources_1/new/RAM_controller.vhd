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
        SPI : in STD_LOGIC_VECTOR(15 downto 0);
        SPI_E : in STD_LOGIC;
        test_mode : in STD_LOGIC_VECTOR(15 downto 0);
        pixel_left, pixel_right : out STD_LOGIC_VECTOR (11 downto 0);
        led_out      : out STD_LOGIC_VECTOR(15 downto 0)
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
    
    component TextController is
          Port ( 
          clk25 : in STD_LOGIC;
          X, Y : in STD_LOGIC_VECTOR (9 downto 0);
          writeEnable : in std_logic;
          writeEnable2 : in std_logic;
          writeAddress : in std_logic_vector(11 downto 0);
          writeValue : in std_logic_vector(7 downto 0);
          writeValue2 : in std_logic_vector(11 downto 0);
          output : out STD_LOGIC_VECTOR (11 downto 0);
          empty : out std_logic; 
          menu : in std_logic
        );
    end component;

    SIGNAL address : STD_LOGIC_VECTOR(3 downto 0);
    SIGNAL data : STD_LOGIC_VECTOR(11 downto 0);
 
    SIGNAL x_index_bat1, y_index_bat1, z_index_bat1 : INTEGER;
    SIGNAL x_index_ball, y_index_ball, z_index_ball : INTEGER; 
    SIGNAL x_index_bat2, y_index_bat2, z_index_bat2 : INTEGER; 
    
    SIGNAL ball_left, ball_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL ball_emtpy_left, ball_emtpy_right : STD_LOGIC;
    
    SIGNAL bat1_left, bat1_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat1_emtpy_left, bat1_emtpy_right : STD_LOGIC;
    SIGNAL bat1_opacity_left, bat1_opacity_right : STD_LOGIC;
    
    SIGNAL bat1_left2, bat1_right2 : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat1_emtpy_left2, bat1_emtpy_right2 : STD_LOGIC;
    SIGNAL bat1_opacity_left2, bat1_opacity_right2 : STD_LOGIC;
    
    SIGNAL bat2_left, bat2_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat2_emtpy_left, bat2_emtpy_right : STD_LOGIC;
    SIGNAL bat2_opacity_left, bat2_opacity_right : STD_LOGIC;
    
    SIGNAL bat2_left2, bat2_right2 : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL bat2_emtpy_left2, bat2_emtpy_right2 : STD_LOGIC;
    SIGNAL bat2_opacity_left2, bat2_opacity_right2 : STD_LOGIC;
    
    SIGNAL background_pixel : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL background_empty : STD_LOGIC;
    
    SIGNAL player1_color : STD_LOGIC_VECTOR(11 downto 0) := b"1111_1111_0000";
    SIGNAL player2_color : STD_LOGIC_VECTOR(11 downto 0) := b"0000_1111_1111";
    
    SIGNAL state_reg : STD_LOGIC_VECTOR(11 downto 0);
    
    SIGNAL text_pixel : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL text_empty: STD_LOGIC;
    SIGNAL textWriteEnable, textWriteEnable2 : std_logic;
    SIGNAL TextWriteAddress : std_logic_vector(11 downto 0);
    SIGNAL textWriteValue : std_logic_vector(7 downto 0);
    SIGNAL textWriteValue2 : std_logic_vector(11 downto 0);
    
begin

ball_module: ball PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_ball,
    y_index => y_index_ball,
    z_index => z_index_ball,
    out_left => ball_left,
    out_right => ball_right,
    empty_left => ball_emtpy_left,
    empty_right => ball_emtpy_right
);

bat1_module: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_bat1,
    y_index => y_index_bat1,
    z_index => -1,
    color => player1_color,
    out_left => bat1_left,
    out_right => bat1_right,
    empty_left => bat1_emtpy_left,
    empty_right => bat1_emtpy_right,
    opacity_left => bat1_opacity_left, 
    opacity_right => bat1_opacity_right
);

bat1_module2: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_bat1,
    y_index => y_index_bat1,
    z_index => -4,
    color => player1_color,
    out_left => bat1_left2,
    out_right => bat1_right2,
    empty_left => bat1_emtpy_left2,
    empty_right => bat1_emtpy_right2,
    opacity_left => bat1_opacity_left2, 
    opacity_right => bat1_opacity_right2
);

bat2_module: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_bat2,
    y_index => y_index_bat2,
    z_index => -9,
    color => player2_color,
    out_left => bat2_left,
    out_right => bat2_right,
    empty_left => bat2_emtpy_left,
    empty_right => bat2_emtpy_right,
    opacity_left => bat2_opacity_left, 
    opacity_right => bat2_opacity_right
);

bat2_module2: bat1 PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    x_index => x_index_bat2,
    y_index => y_index_bat2,
    z_index => -6,
    color => player2_color,
    out_left => bat2_left2,
    out_right => bat2_right2,
    empty_left => bat2_emtpy_left2,
    empty_right => bat2_emtpy_right2,
    opacity_left => bat2_opacity_left2, 
    opacity_right => bat2_opacity_right2
);

backgr: background PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    output => background_pixel,
    empty => background_empty
);

text_viewer: TextController PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    writeEnable => textWriteEnable,
    writeEnable2 => textWriteEnable2,
    writeAddress => textWriteAddress,
    writeValue => textWriteValue,
    writeValue2 => textWriteValue2,
    output => text_pixel,
    empty => text_empty,
    menu => state_reg(3)
);

text_write: process(clk25)
begin
    if rising_edge(clk25) then
        textWriteEnable <= '0';
        if(SPI_E = '1') then
            if (address = "1000") then
                textWriteAddress <= data;
            elsif (address = "1001") then
                textWriteValue <= data(7 downto 0);
                textWriteEnable <= '1';
            elsif (address = "1010") then
                textWriteValue2 <= data(11 downto 0);
                textWriteEnable2 <= '1';
            end if;
        end if;
    end if;
end process;

spi_decode: process(clk25)
    variable prescaler : integer := -1000;
variable dir_x, dir_y, dir_z : boolean := true;
begin
    if (rising_edge(clk25)) then
        if(SPI_E = '1') then
            address <= SPI(15 downto 12);
            data <= SPI(11 downto 0);
            --led_out <= SPI;
            if(test_mode(0) = '0') then
                if (address = "0001") then -- ball:x
                   x_index_ball <= to_integer(signed(data)); 
                elsif (address = "0010") then -- ball:y
                   y_index_ball <= to_integer(signed(data));  
                elsif (address = "0011") then -- ball:z
                   z_index_ball <= to_integer(signed(data));           
                elsif (address = "0100") then -- player:1:x
                   x_index_bat1 <= to_integer(signed(data));  
                elsif (address = "0101") then -- player:1:y
                   y_index_bat1 <= to_integer(signed(data));
                elsif (address = "0110") then -- player:2:x
                   x_index_bat2 <= to_integer(signed(data));
                elsif (address = "0111") then -- player:2:y
                   y_index_bat2 <= to_integer(signed(data));
                elsif (address = "1101") then -- player:1:color
                   player1_color <= data;
                elsif (address = "1110") then -- player:2:color
                   player2_color <= data;                           
                end if;
            end if;
           if (address = "1111") then --State Reg
               state_reg <= data;
            end if;
        end if;
        
        if(test_mode(0) = '1' OR state_reg(0) = '1') then
            prescaler := prescaler + 1;
                    
            if (prescaler >= 4000000) then
                prescaler := 0;
                
                if (x_index_ball + 80 >= 320) then
                    dir_x := false;
                elsif (x_index_ball - 80 <= -320) then
                    dir_x := true;
                end if;
            
                if (dir_x = true) then
                    x_index_ball <= x_index_ball + 60;
                    x_index_bat1 <= x_index_bat1 + 60;
                    x_index_bat2 <= x_index_bat2 + 60;
                else
                    x_index_ball <= x_index_ball - 60;
                    x_index_bat1 <= x_index_bat1 - 60;
                    x_index_bat2 <= x_index_bat2 - 60;
                end if;
                
                if (y_index_ball + 70 >= 240) then
                    dir_y := false;
                elsif (y_index_ball - 70 <= -240) then
                    dir_y := true;
                end if;
            
                if (dir_y = true) then
                    y_index_ball <= y_index_ball + 40;
                    y_index_bat1 <= y_index_bat1 + 40;
                    y_index_bat2 <= y_index_bat2 + 40;
                else
                    y_index_ball <= y_index_ball - 40;
                    y_index_bat1 <= y_index_bat1 - 40;
                    y_index_bat2 <= y_index_bat2 - 40;
                end if;
                
                if (z_index_ball >= -8) then
                    dir_z := false;
                elsif (z_index_ball <= -72) then
                    dir_z := true;
                end if;
            
                if (dir_z = true) then
                    z_index_ball <= z_index_ball + 2;
                else
                    z_index_ball <= z_index_ball - 2;
                end if;
            end if;
        end if;
    end if;

end process;

left: process(clk25)
    variable left_color, temp_color : STD_LOGIC_VECTOR (11 downto 0);
begin
    if (falling_edge(clk25)) then
        left_color := (others => '0');
        
        if (background_empty = '0') then
            left_color := background_pixel;
        end if;
        if (bat2_emtpy_left = '0' AND (state_reg(5) = '0' AND test_mode(5) = '0')) then
            if (bat2_opacity_left = '1') then
                temp_color := bat2_left; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                left_color := bat2_left;
            end if;
        end if;

        if (ball_emtpy_left = '0' AND z_index_ball <= -56) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat1_emtpy_left = '0') then 
                left_color := ball_left;
            end if;
        end if;    
        
        if (bat2_emtpy_left2 = '0' AND (state_reg(6) = '1' or test_mode(6) = '1') AND (state_reg(5) = '0' AND test_mode(5) = '0')) then
            if (bat2_opacity_left2 = '1') then
                temp_color := bat2_left2; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                left_color := bat2_left2;
            end if;
       end if; 
       
        if (ball_emtpy_left = '0' AND z_index_ball <= -36 AND z_index_ball >= -56) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat1_emtpy_left = '0') then 
                left_color := ball_left;
            end if;
        end if;  
        
        if (bat1_emtpy_left2 = '0' AND (state_reg(6) = '1' or test_mode(6) = '1')) then
            if (bat1_opacity_left2 = '1') then
                temp_color := bat1_left2; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0));
            else
                left_color := bat1_left2;
            end if;
        end if; 
        
       if (ball_emtpy_left = '0' AND z_index_ball >= -36) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat1_emtpy_left = '0') then 
                left_color := ball_left;
            end if;
        end if;   
            
       if (bat1_emtpy_left = '0') then
            if (bat1_opacity_left = '1') then
                temp_color := bat1_left; --merge
                left_color(11 downto 8) := ('0' & left_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                left_color(7 downto 4) := ('0' & left_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                left_color(3 downto 0) := ('0' & left_color(2 downto 0)) + ('0' & temp_color(2 downto 0));
            else
                left_color := bat1_left;
            end if;
        end if;
        
        if (text_empty = '0') then
            left_color := text_pixel;
        end if;
        pixel_left <= left_color; 
    end if;
end process;

right: process(clk25)
    variable right_color, temp_color : STD_LOGIC_VECTOR (11 downto 0);
begin
    if (falling_edge(clk25)) then
        right_color := (others => '0');
        
        if (background_empty = '0') then
                right_color := background_pixel;
        end if;
        if (bat1_emtpy_right = '0' AND (state_reg(5) = '0' AND test_mode(5) = '0')) then
            if(bat1_opacity_right = '1') then
                temp_color := bat1_right; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := bat1_right;
            end if;
        end if;
        if (ball_emtpy_right = '0' AND z_index_ball >= -36) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat2_emtpy_right = '0') then
                right_color := ball_right;
            end if;
        end if;
        if (bat1_emtpy_right2 = '0' AND (state_reg(6) = '1' or test_mode(6) = '1') AND (state_reg(5) = '0' AND test_mode(5) = '0')) then
            if(bat1_opacity_right2 = '1') then
                temp_color := bat1_right2; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := bat1_right2;
            end if;
        end if;
        if (ball_emtpy_right = '0' AND z_index_ball <= -36 AND z_index_ball >= -56) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat2_emtpy_right = '0') then
                right_color := ball_right;
            end if;
        end if;
        if (bat2_emtpy_right2 = '0' AND (state_reg(6) = '1' or test_mode(6) = '1')) then
            if(bat2_opacity_right2 = '1') then
                temp_color := bat2_right2; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := bat2_right2;
            end if;
        end if;
        if (ball_emtpy_right = '0' AND z_index_ball <= -56) then
            if ((test_mode(1) = '0' AND state_reg(1) = '0') or bat2_emtpy_right = '0') then
                right_color := ball_right;
            end if;
        end if;
        if (bat2_emtpy_right = '0') then
            if(bat2_opacity_right = '1') then
                temp_color := bat2_right; --merge
                right_color(11 downto 8) := ('0' & right_color(10 downto 8)) + ('0' & temp_color(10 downto 8)); 
                right_color(7 downto 4) := ('0' & right_color(6 downto 4)) + ('0' & temp_color(6 downto 4)); 
                right_color(3 downto 0) := ('0' & right_color(2 downto 0)) + ('0' & temp_color(2 downto 0)); 
            else
                right_color := bat2_right;
            end if;
        end if;
        
        if (text_empty = '0') then
            right_color := text_pixel;
        end if;
        pixel_right <= right_color; 
    end if;
end process;

end Behavioral;



----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2017 15:11:32
-- Design Name: 
-- Module Name: ball - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bat1 is
    Port ( 
        clk25 : in STD_LOGIC;
        X, Y : in STD_LOGIC_VECTOR (9 downto 0);
        x_index, y_index, z_index : in INTEGER;
        color : STD_LOGIC_VECTOR (11 downto 0);
        out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
        empty_left, empty_right, opacity_left, opacity_right : out STD_LOGIC
    );
end bat1;

architecture Behavioral of bat1 is
    CONSTANT width : INTEGER := 120; -- "0001100011";
    CONSTANT height : INTEGER := 80; -- "0001100011";

begin

main: process(clk25)
    variable x_center : INTEGER;
    variable y_center : INTEGER;
    
    variable xMem_left, yMem_left : integer;
    variable xMem_right, yMem_right : integer;
    
    variable  x_index_temp, y_index_temp, z_index_temp : INTEGER;
    
begin
    if (rising_edge(clk25)) then
        x_center := to_integer(signed(X - 320));
        y_center := to_integer(signed(Y- 240));
        
        x_index_temp := x_index;
        y_index_temp := y_index;
        z_index_temp := z_index;
        
        if(abs(x_index_temp) + width >= 320) then
            if (x_index_temp >= 0) then
                x_index_temp := 320 - width;
            else
                x_index_temp := -320 + width;
            end if;
        end if;
        if(abs(y_index_temp) + height >= 240) then
            if (y_index_temp >= 0) then
                y_index_temp := 240 - height;
            else
                y_index_temp := - 240 + height;
            end if;
        end if;
            
        xMem_left := X_center * z_index_temp;
        yMem_left := Y_center * z_index_temp;
        
        xMem_right := X_center * (10 + z_index_temp);
        yMem_right := Y_center * (-10 - z_index_temp);
        
        
        if(xMem_left >= x_index_temp - width AND xMem_left < x_index_temp + width AND yMem_left >= y_index_temp - height AND yMem_left < y_index_temp + height) then
             if(xMem_left - 5 >= x_index_temp - width AND xMem_left + 5 < x_index_temp + width AND yMem_left - 5 >= y_index_temp - height AND yMem_left + 5 < y_index_temp + height) then
                out_left  <= color;
                opacity_left <= '1';
            else
                out_left <= color;
--                out_left(11 downto 8) <= "1111";
--                out_left(7 downto 4) <= "1111";
--                out_left(3 downto 0) <= "0000";
                opacity_left <= '0';
            end if;
            empty_left <= '0';   
        else
            empty_left <= '1';   
        end if;
        
        if(xMem_right >= x_index_temp - width AND xMem_right < x_index_temp + width AND yMem_right >= y_index_temp - height AND yMem_right < y_index_temp + height) then
             if(xMem_right - 5 >= x_index_temp - width AND xMem_right + 5 < x_index_temp + width AND yMem_right - 5 >= y_index_temp - height AND yMem_right + 5 < y_index_temp + height) then
                out_right <= color;               
                opacity_right <= '1';
            else
                out_left <= color;
--                out_right(11 downto 8) <= "0000";
--                out_right(7 downto 4) <= "1111";
--                out_right(3 downto 0) <= "1111";
                opacity_right <= '0';
            end if;   
            empty_right <= '0'; 
        else   
            empty_right <= '1';   
        end if;
    end if;    

end process;

end Behavioral;

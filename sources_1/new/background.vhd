----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2017 19:21:50
-- Design Name: 
-- Module Name: background - Behavioral
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

entity background is
    Port ( 
        clk25 : in STD_LOGIC;
        X, Y : in STD_LOGIC_VECTOR (9 downto 0);
        output : out STD_LOGIC_VECTOR (11 downto 0);
        empty : out STD_LOGIC
    );
end background;

architecture Behavioral of background is
    constant size : integer := 6;
begin

process(clk25)
    variable x_center : INTEGER;
    variable y_center : INTEGER;
    
    variable i : integer;
    variable z_index : INTEGER;
    variable xMem, yMem : integer;
    variable zx, zy : integer;
    
--    variable xMem_x, yMem_x : integer;
--    variable xMem_y, yMem_y : integer;
    
--    variable xLine: integer;
--    variable i : integer;
--    variable z_index_x : integer := -1;
--    variable z_index_y : integer := -1;
begin
    if (rising_edge(clk25)) then
--        xMem := to_integer(signed(X - 320));
--        yMem := to_integer(signed(Y - 240));
        
        x_center := to_integer(signed(X - 320));
        y_center := to_integer(signed(Y- 240));
        
        zx := 2560 /  abs(x_center);
        zy := 1840 /  abs(y_center);        
        
        output <= (others => '0');
        for i in 0 to 4 loop
            z_index := -i * 16 - 8;
            xMem := X_center * z_index;
            yMem := Y_center * z_index;
            
            xMem := xMem / 8;
            yMem := yMem / 8;
            
            if (abs(xMem) <= 320 AND abs(xMem) >= 320-size AND abs(yMem) <= 230) then
                output(7 downto 4) <= (others => '1');
                empty <= '0';
            end if;
            if (abs(yMem) <= 240 AND abs(yMem) >= 240-size AND abs(xMem) <= 320) then
                output(7 downto 4) <= (others => '1');
                empty <= '0';
            end if;            
        end loop;
        
        --if  zx >= 1 AND zx <= 9 and zy >= 1 AND zy <= 9 AND zx = zy then
        if  zx >= 8 AND zx <= 72 AND zx = zy then
            output(7 downto 4) <= (others => '1');
            empty <= '0';
        end if;
--        for i in -223 to -32 loop
--            xMem := X_center * i;
--            yMem := Y_center * i;
            
--            xMem := xMem / 32;
--            yMem := yMem / 32;
            
--            if abs(xMem) <= 320 AND abs(xMem) >= 320-size AND abs(yMem) <= 240 AND abs(yMem) >= 230-size then
--                output(7 downto 4) <= (others => '1');
--                empty <= '0';
--            end if;
--        end loop;
        
        
--        x_center := to_integer(signed(X - 320));
--        y_center := to_integer(signed(Y- 240));
        
--        z_index_x := x_center / 15;
--        z_index_y := y_center / 11;
        
--        z_index_x := -23 + z_index_x;
--        z_index_y := -23 + z_index_y;
            
--        xMem_x := X_center * z_index_x;
--        yMem_x := Y_center * z_index_x;
        
--        xMem_y := X_center * z_index_y;
--        yMem_y := Y_center * z_index_y;
        
----        yMem_x := yMem_y;
----        xMem_y := xMem_x;
            
--        empty <= '1';
--        output <= (others => '0');
          
--        for i in 0 to 4 loop
          
--        --4 rectangles
--            if  abs(yMem_y)+(i*20) <= 240 AND abs(yMem_y)+(i*20) >= 240 - size AND abs(xMem_y)+(i*20) <= 320 then
--                output(7 downto 4) <= (others => '1');
--                empty <= '0';
--            elsif abs(xMem_x)+(i*20) <= 320 AND abs(xMem_x)+(i*20) >= 320 - size AND abs(yMem_x)+(i*20) <= 240 then
--                output(7 downto 4) <= (others => '1');
--                empty <= '0';
--            end if;
       
--        end loop;
        
--        if abs(yMem_y) > 74 then
--            xLine := abs(yMem_y) + 80;
--            if xLine >= abs(xMem_x) - 2 AND xLine <= abs(xMem_x) + 2 then
--                output(7 downto 4) <= (others => '1');
--                empty <= '0';
--            end if;
--        end if;
        
    end if;
end process;

end Behavioral;

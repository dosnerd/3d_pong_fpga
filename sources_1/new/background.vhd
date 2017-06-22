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
    SIGNAL buff : STD_LOGIC_VECTOR (11 downto 0);
begin

output <= buff;

process(clk25)
    variable x_center : INTEGER;
    variable y_center : INTEGER;
    
--    variable painted : boolean;
    variable i : integer;
    variable z_index : INTEGER;
    variable xMem, yMem : integer;
    variable zx, zy : integer;
begin
    if (rising_edge(clk25)) then
      
        x_center := to_integer(signed(X - 320));
        y_center := to_integer(signed(Y- 240));
        
        --320*8=2560, 
        --230*8=1840 240*8=1920
        zx := 10240 /  abs(x_center);
        zy := 7680 /  abs(y_center);        
        
        buff(11 downto 8) <= "0111";
        buff(7 downto 4) <= "0011";
        buff(3 downto 0) <= "0101";

        --buff <= (others => '1');
        for i in 0 to 4 loop
            z_index := -i * 16 - 8;
            xMem := X_center * z_index;
            yMem := Y_center * z_index;
            
            xMem := xMem / 8;
            yMem := yMem / 8;
            
            if (abs(xMem) <= 320 AND abs(xMem) >= 320-size AND abs(yMem) <= 240) then
                buff(11 downto 8) <= "1111";
                buff(7 downto 4) <= "0000";
                buff(3 downto 0) <= "0000";
                empty <= '0';
            end if;
            if (abs(yMem) <= 240 AND abs(yMem) >= 240-size AND abs(xMem) <= 320) then
                buff(11 downto 8) <= "1111";
                buff(7 downto 4) <= "0000";
                buff(3 downto 0) <= "0000";
                empty <= '0';
            end if;            
        end loop;        
        
        --if  zx >= 1 AND zx <= 9 and zy >= 1 AND zy <= 9 AND zx = zy then
        if  zx >= 32 AND zx <= 288 AND zx = zy then
            buff(11 downto 8) <= "0000";
            buff(7 downto 4) <= "0000";
            buff(3 downto 0) <= "1111";
            empty <= '0';
        end if;
        
        xMem := -72 * X_center;
        yMem := -72 * Y_center;
        
        xMem := xMem / 8;
        yMem := yMem / 8;
        
        if (abs(yMem) <= 240-size AND abs(xMem) <= 320-size) then
            buff(11 downto 8) <= "0000";
            buff(7 downto 4) <= "0111";
            buff(3 downto 0) <= "0000";
            empty <= '0';
        end if;
    end if;
    
end process;

end Behavioral;

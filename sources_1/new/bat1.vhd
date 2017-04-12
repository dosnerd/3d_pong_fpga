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
        out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
        empty_left, empty_right, opacity_left, opacity_right : out STD_LOGIC
    );
end bat1;

architecture Behavioral of bat1 is
--    SIGNAL X_bat, Y_bat : STD_LOGIC_VECTOR(9 downto 0) := std_logic_vector(to_signed(200, 10)); --"0100101100";
--    SIGNAL width : STD_LOGIC_VECTOR(9 downto 0) := std_logic_vector(to_signed(60, 10)); -- "0001100011";
--    SIGNAL height : STD_LOGIC_VECTOR(9 downto 0) := std_logic_vector(to_signed(30, 10)); -- "0001100011";
    SIGNAL X_bat, Y_bat : INTEGER := 200; --"0100101100";
    SIGNAL width : INTEGER := 120; -- "0001100011";
    SIGNAL height : INTEGER := 80; -- "0001100011";
    SIGNAL z_index : integer := -2;

begin

main: process(clk25)
    variable x_center : INTEGER;
    variable y_center : INTEGER;
        
    variable xMem_left, yMem_left : integer;
    variable xMem_right, yMem_right : integer;
begin
    if (rising_edge(clk25)) then
        x_center := to_integer(signed(X - 320));
        y_center := to_integer(signed(Y- 240));
            
        xMem_left := X_center * z_index;
        yMem_left := Y_center * z_index;
        
        xMem_right := X_center * (21 + z_index);
        yMem_right := Y_center * (-21 - z_index);
        
        
        if(xMem_left >= X_bat - width AND xMem_left < X_bat + width AND yMem_left >= Y_bat - height AND yMem_left < Y_bat + height) then
             if(xMem_left - 5 >= X_bat - width AND xMem_left + 5 < X_bat + width AND yMem_left - 5 >= Y_bat - height AND yMem_left + 5 < Y_bat + height) then
                out_left(11 downto 8)  <= "0000";
                out_left(7 downto 4) <= "0000";
                out_left(3 downto 0) <= "1111";
                opacity_left <= '1';
            else
                out_left(11 downto 8) <= "1111";
                out_left(7 downto 4) <= "1111";
                out_left(3 downto 0) <= "0000";
                opacity_left <= '0';
            end if;
            empty_left <= '0';   
        else
            empty_left <= '1';   
        end if;
        
        if(xMem_right >= X_bat - width AND xMem_right < X_bat + width AND yMem_right >= Y_bat - height AND yMem_right < Y_bat + height) then
             if(xMem_right - 5 >= X_bat - width AND xMem_right + 5 < X_bat + width AND yMem_right - 5 >= Y_bat - height AND yMem_right + 5 < Y_bat + height) then
                out_right(11 downto 8) <= "1111";
                out_right(7 downto 4) <= "0000";
                out_right(3 downto 0) <= "0000";                
                opacity_right <= '1';
            else
                out_right(11 downto 8) <= "0000";
                out_right(7 downto 4) <= "1111";
                out_right(3 downto 0) <= "1111";
                opacity_right <= '0';
            end if;   
            empty_right <= '0'; 
        else   
            empty_right <= '1';   
        end if;
    end if;    

end process;

end Behavioral;

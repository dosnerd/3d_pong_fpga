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

entity ball is
    Port ( 
        clk25 : in STD_LOGIC;
        X, Y : in STD_LOGIC_VECTOR (9 downto 0);
        out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
        empty_left, empty_right : out STD_LOGIC
    );
end ball;

architecture Behavioral of ball is
    SIGNAL X_bal, Y_bal : STD_LOGIC_VECTOR(9 downto 0) := std_logic_vector(to_signed(300, 10)); --"0100101100";
    SIGNAL size_bal : integer := 80; -- "0001100011";
    SIGNAL z_index : integer := 5;
begin

mover: process(clk25)
    variable prescaler : integer := 0;
    variable dir : boolean := true;
begin
    if (rising_edge(clk25)) then
        prescaler := prescaler + 1;
                
        if (prescaler >= 25000000) then
            prescaler := 0;
            
            if (z_index > 300) then
                dir := false;
            elsif (z_index < -300) then
                dir := true;
            end if;
        
            if (dir = true) then
                z_index <= z_index + 1;
            else
                z_index <= z_index - 1;
            end if;
        end if;
    end if;
end process;


main: process(clk25)
    variable a2, b2, c2 : integer;
    variable xMem, yMem : integer;
    variable X_center, Y_center : integer;
begin  
    if (rising_edge(clk25)) then
        X_center := to_integer(signed(X + 320));
        Y_center := to_integer(signed(Y + 240));
    
        xMem := X_center * z_index;
        yMem := Y_center * z_index;
        
--        a2 := to_integer(signed(X_bal)) - xMem;
--        b2 := to_integer(signed(Y_bal)) - yMem;

        a2 := to_integer(signed(X_bal - xMem));
        b2 := to_integer(signed(Y_bal - yMem));
        a2 := a2**2;
        b2 := b2**2;
        c2 := a2 + b2;
        
        if(c2 <= size_bal) then
                out_left(11 downto 8) <= "0000";
                out_left(7 downto 4) <= "0000";
                out_left(3 downto 0) <= "1111";
                out_right(11 downto 8) <= "0000";
                out_right(7 downto 4) <= "1111";
                out_right(3 downto 0) <= "0000";
                empty_left <= '0';   
                empty_right <= '0'; 
        else
                empty_left <= '1';   
                empty_right <= '1';   
        end if;
    end if;    

end process;

end Behavioral;

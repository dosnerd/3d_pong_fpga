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
    SIGNAL size_bal : STD_LOGIC_VECTOR(9 downto 0) := std_logic_vector(to_signed(255, 10)); -- "0001100011";
begin

main: process(clk25)
    variable a, b : STD_LOGIC_VECTOR(9 downto 0);
    variable a_2, b_2, c_2 : STD_LOGIC_VECTOR(19 downto 0);
    
begin
  
    if (rising_edge(clk25)) then

        b := X_bal - X;
        a := Y_bal - Y;
        a_2 := a*a;
        b_2 := b*b;
        c_2 := a_2 + b_2;
        
        if(c_2 <= size_bal) then
                out_left(11 downto 8) <= "0000";
                out_left(7 downto 4) <= "0000";
                out_left(3 downto 0) <= "1111";
                out_right(11 downto 8) <= "0000";
                out_right(7 downto 4) <= "0000";
                out_right(3 downto 0) <= "1111";
                empty_left <= '0';   
                empty_right <= '0'; 
        else
                empty_left <= '1';   
                empty_right <= '1';   
        end if;
    end if;    

end process;

end Behavioral;

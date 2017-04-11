----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2017 10:15:40
-- Design Name: 
-- Module Name: ram_module - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_module2 is
    Port ( clk : in STD_LOGIC;               --on both edges
           ss : in STD_LOGIC;                --high active
           write : in STD_LOGIC;             --low active!!
           screen_left : in STD_LOGIC;       --low, data for left screen, high data for right screen
           position : in STD_LOGIC_VECTOR (19 downto 0);        --VGA position (0,0) => already visible
           pixel : out STD_LOGIC_VECTOR (12 downto 0));         --Color on the current location
end ram_module2;

architecture Behavioral of ram_module2 is
    SIGNAL color : STD_LOGIC_VECTOR (12 downto 0) := (others => '0');
    SIGNAL X : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL Y : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL clk_old : STD_LOGIC := '1';
begin

X <= position(9 downto 0);
Y <= position(19 downto 10);

pixel <=    color WHEN ss = '1' ELSE
            (others => 'Z');

--enable: process (ss)
--begin
--    if (rising_edge(ss)) then
--        pixel <= color;
--    end if;
--    if (falling_edge(ss)) then
--        pixel <= (others => 'Z');
--    end if;
--end process;

main: process(clk)
begin
    if (rising_edge(clk)) then        
        color(12) <= '0';
    --    color(3 downto 0) <= "1111";
        
        if (X > 20 and X < 50) then
            if (Y > 0 and Y < 80) then
                color(11 downto 8) <= "1111";
                color(7 downto 4) <= "1111";
                color(3 downto 0) <= "1111";
            else
                color(11 downto 8) <= "1111";
                color(7 downto 4) <= "0000";
                color(3 downto 0) <= "1111";
            end if;
        else
            color(11 downto 8) <= "0000";
            color(7 downto 4) <= "0000";
            color(3 downto 0) <= "0000";
        end if;    
    end if;
    
    
    ------------------------------------------here come your code------------------------------------------
    --
    --
    -------------------------------------------------------------------------------------------------------
    
end process;

end Behavioral;
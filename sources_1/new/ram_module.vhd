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

entity ram_module is
    Port ( clk : in STD_LOGIC;               --on both edges
           ss : in STD_LOGIC;                --high active
           write : in STD_LOGIC;             --low active!!
           screen_left : in STD_LOGIC;       --low, data for left screen, high data for right screen
           position : in STD_LOGIC_VECTOR (19 downto 0);        --VGA position (0,0) => already visible
           pixel : out STD_LOGIC_VECTOR (12 downto 0));         --Color on the current location
end ram_module;

architecture Behavioral of ram_module is
    SIGNAL color_left : STD_LOGIC_VECTOR (12 downto 0) := (others => '0');
    SIGNAL color_right : STD_LOGIC_VECTOR (12 downto 0) := (others => '0');
    SIGNAL X : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL Y : STD_LOGIC_VECTOR (9 downto 0);
    SIGNAL clk_old : STD_LOGIC := '1';
begin

X <= position(9 downto 0);
Y <= position(19 downto 10);

pixel <=    color_left WHEN ss = '1' AND screen_left = '0' ELSE
            color_right WHEN ss = '1' AND screen_left = '1' ELSE
            (others => 'Z');

--enable: process (ss)
--begin
--    --DO NOT USE THE FOLOW LINE
--    --if (rising_edge(clk)) then end if;
--    --without the above line, the process will excecute on both edges, not only the rising/falling edge.
----    color(3 downto 0) <= "1111";
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

--    if clk_old = ss then
--        clk_old <= not ss;
        
        if (Y(4) = screen_left) then
            if (X(4)= screen_left) then
                color_left(12) <= '1';
                color_left(11 downto 0) <= b"1111_0000_0000";
            else
                color_left(12) <= '1';                           
                color_left(11 downto 0) <= b"0000_1111_0000";
            end if;
        else
            color_left(12) <= '1';
            color_left(11 downto 0) <= b"0000_0000_0000";
        end if;
        
        if (X(4) /= screen_left) then
            if (Y(4)/= screen_left) then
                color_right(12) <= '0';
                color_right(11 downto 0) <= b"0000_0000_1111";
            else
                color_right(12) <= '1';                          
                color_right(11 downto 0) <= b"0000_1111_0000";
            end if;
        else
            color_right(12) <= '1';
            color_right(11 downto 0) <= b"0000_0000_0000";
        end if;
        
--        if (X > 0 and X < 10) then
--            color(12) <= '0';
--            if (Y > 0 and Y < 50) then
--                color(11 downto 8) <= "0000";
--                color(7 downto 4) <= "0000";
--                color(3 downto 0) <= "1111";
--            else
--                color(11 downto 8) <= "1111";
--                color(7 downto 4) <= "0000";
--                color(3 downto 0) <= "0000";
--            end if;
--        else
--            color(12) <= '1';
--            color(11 downto 8) <= "0000";
--            color(7 downto 4) <= "0000";
--            color(3 downto 0) <= "0000";
--        end if;
        
--        if ss = '1' then
--            pixel <= color;
--        else
--            pixel <= (others => 'Z');
--        end if;
    end if;    
    ------------------------------------------here come your code------------------------------------------
    --
    --
    -------------------------------------------------------------------------------------------------------
    
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 13:18:46
-- Design Name: 
-- Module Name: PixelSelect - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PixelSelect is
    Port ( --VGAx : in STD_LOGIC_VECTOR (9 downto 0);
           --VGAy : in STD_LOGIC_VECTOR (9 downto 0);
           spriteColor : in STD_LOGIC_VECTOR (12 downto 0);
           clk200 : in STD_LOGIC;
           reset : in STD_LOGIC;
           pixelOut : out STD_LOGIC_VECTOR (11 downto 0);
           spriteAddr : out STD_LOGIC_VECTOR (2 downto 0));
end PixelSelect;

architecture Behavioral of PixelSelect is
    --SIGNAL debug1 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    --SIGNAL debug2 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    --SIGNAL reset_c : STD_LOGIC := '0';
    --SIGNAL clk : STD_LOGIC := '1';
begin

process (clk200)
    variable i : integer range -1 to 8 := 0;
    variable color : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
begin
    if rising_edge(clk200) then    
        if (i < 7 and i >= 0) then
            --when no sprite drawed, no division;
            if (color = 0 and spriteColor(12) = '0')then
                color := spriteColor(11 downto 0);
            elsif (spriteColor(11 downto 0) > 0) then
                --devide every color by 2
                color(11 downto 8) := '0' & color(11 downto 9);
                color(7 downto 4) := '0' & color(7 downto 5);
                color(3 downto 0) := '0' & color(3 downto 1);
                
                color(11 downto 8) := color(11 downto 8) + ('0' & spriteColor(11 downto 9));
                color(7 downto 4) := color(7 downto 4) + ('0' & spriteColor(7 downto 5));
                color(3 downto 0) := color(3 downto 0) + ('0' & spriteColor(3 downto 1));
                
                --color := color + ('0' & spriteColor(11 downto 1));
                --color := ('0' & spriteColor(11 downto 1));
            end if;
    
    --                color := (others => '1');
            
            --when solid sprite, exit
            if spriteColor(12) = '0' then
                i := 6;
            end if;
            i := i + 1;
            spriteAddr <= std_logic_vector(to_unsigned(i, 3));
        end if;
        
        if (i = 7 and reset = '0') then
            pixelOut <= color;
            i := i + 1;
            spriteAddr <= (others => '0');
        end if;
        
        if (reset = '1' and i = 8) then
            i := 0;
            color := (others => '0');
        end if;
        
    end if;
    
--    if i <= 7 then 
--        spriteAddr <= std_logic_vector(to_unsigned(i, 3));
--    else
--        spriteAddr <= (others => '0');
--    end if;


--    debug1 <= color;
--    if clk = clk100 then
--        clk <= not clk100;
        
--        if rising_edge(reset) then
----        if reset = '1' and reset_c = '0' then
--            i := 0;
--            color := (others => '0');
--            reset_c <= '1';
--        else
        
--            if reset = '0' and reset_c = '1' then
--                reset_c <= '0';
--            end if;
       
    --   pixelOut <= (others=>'1');
        
    --    if rising_edge(reset) then
    --        i := 0;
    --        color := (others => '0');
    --    elsif (falling_edge(reset)) then
    --        --ignore falling edge reset
    --    else
            
--                if (i < 7) then
--                    --when no sprite drawed, no division;
--                    if (color = 0 and spriteColor(12) = '0')then
--                        color := spriteColor(11 downto 0);
--                    elsif (spriteColor(11 downto 0) > 0) then
--                        --devide every color by 2
--                        color(11 downto 8) := '0' & color(11 downto 9);
--                        color(7 downto 4) := '0' & color(7 downto 5);
--                        color(3 downto 0) := '0' & color(3 downto 1);
                        
--                        color(11 downto 8) := color(11 downto 8) + ('0' & spriteColor(11 downto 9));
--                        color(7 downto 4) := color(7 downto 4) + ('0' & spriteColor(7 downto 5));
--                        color(3 downto 0) := color(3 downto 0) + ('0' & spriteColor(3 downto 1));
                        
--                        --color := color + ('0' & spriteColor(11 downto 1));
--                        --color := ('0' & spriteColor(11 downto 1));
--                    end if;
    
--    --                color := (others => '1');
                    
--                    --when solid sprite, exit
--                    if spriteColor(12) = '0' then
--                        i := 6;
--                    end if;
--                    i := i + 1;
--                elsif (i = 7) then
--                    pixelOut <= color;
--                    i := i + 1;
--                    spriteAddr <= (others => '0');
--                end if;            
--            end if;
--        spriteAddr <= std_logic_vector(to_unsigned(i, 3));
--    end if;
    --debug2 <= color;
end process;

end Behavioral;

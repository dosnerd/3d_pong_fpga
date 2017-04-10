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

process (ss)
begin
    --DO NOT USE THE FOLOW LINE
    --if (rising_edge(clk)) then end if;
    --without the above line, the process will excecute on both edges, not only the rising/falling edge.
    
    if clk_old = ss then
        clk_old <= not ss;
        
        color(12) <= '0';
        
        
            
        if ss = '1' then
            pixel <= color;
        else
            pixel <= (others => 'Z');
        end if;
    end if;
end process;

end Behavioral;
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

begin

process (clk)
begin
    --DO NOT USE THE FOLOW LINE
    --if (rising_edge(clk)) then end if;
    --without the above line, the process will excecute on both edges, not only the rising/falling edge.
    
    
    ------------------------------------------here come your code------------------------------------------
    --
    --
    -------------------------------------------------------------------------------------------------------
    
end process;

end Behavioral;

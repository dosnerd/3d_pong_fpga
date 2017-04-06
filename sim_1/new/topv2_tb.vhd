----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 15:29:37
-- Design Name: 
-- Module Name: topv2_tb - Behavioral
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

entity topv2_tb is
--  Port ( );
end topv2_tb;

architecture Behavioral of topv2_tb is
    component topv2 is
        Port ( 
            SPI_data    : in STD_LOGIC;
            SPI_clock   : in STD_LOGIC;
            SPI_ss      : in STD_LOGIC;
            
            --debug
            debug : out STD_LOGIC_VECTOR (15 downto 0)
        );
    end component;
    
    SIGNAL      SPI_data    : STD_LOGIC := '0';
    SIGNAL      SPI_clock   : STD_LOGIC := '0';
    SIGNAL      SPI_ss      : STD_LOGIC;
    
    SIGNAL      DEBUG       : STD_LOGIC_VECTOR (15 downto 0);
    SIGNAL      counter     : integer;
    SIGNAL      DEBUG_CMD       : STD_LOGIC_VECTOR (15 downto 0) := x"00A5";
begin

test: topv2 port map(
    SPI_data => SPI_data,
    SPI_clock => SPI_clock,
    SPI_ss => SPI_ss,
    data_ready => DEBUG(0)
);

process
    variable i : integer := 0;
begin
    if i < 16 then
        SPI_clock <= '1';
        wait for 1ns;
        SPI_clock <= '0';
    end if;
    
    if i = 17 then
        SPI_ss <= '0';
    end if;
    
    if i = 19 then
        SPI_ss <= '1';
    end if;
    
    i := i + 1;
    if i >= 20 then
        i := 0;
    end if;
    
    counter <= i;
    wait for 1ns;
end process;

process(SPI_clock, counter)
begin

    if counter = 19 then
        SPI_data <= DEBUG_CMD(0);
    end if;

    if falling_edge(SPI_clock) and counter < 16 then
        SPI_data <= DEBUG_CMD(counter);
    end if;

end process;
end Behavioral;

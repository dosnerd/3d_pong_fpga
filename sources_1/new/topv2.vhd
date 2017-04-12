----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.03.2017 15:03:17
-- Design Name: 
-- Module Name: topv2 - Behavioral
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

entity topv2 is
  Port ( 
        SPI_data    : in STD_LOGIC;
        SPI_clock   : in STD_LOGIC;
        SPI_ss      : in STD_LOGIC;
        
        --debub
        debug : out STD_LOGIC_VECTOR (15 downto 0)
  );
end topv2;

architecture Behavioral of topv2 is
    component SPI is
        Port ( data_in  : in STD_LOGIC;
               clock_in : in STD_LOGIC;
               SS       : in STD_LOGIC;
               data_out : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    
    SIGNAL      SPI_databus     : STD_LOGIC_VECTOR(15 downto 0);
begin

debug <= SPI_databus;

communication: SPI port map(
    data_in => SPI_data,
    clock_in => SPI_clock,
    SS => SPI_ss,
    data_out => SPI_databus
);

end Behavioral;

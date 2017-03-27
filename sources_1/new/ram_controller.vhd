----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2017 14:11:55
-- Design Name: 
-- Module Name: ram_controller - Behavioral
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

entity ram_controller is
    Port ( 
           VGAleft : in STD_LOGIC_VECTOR (19 downto 0);
           VGAright : in STD_LOGIC_VECTOR (19 downto 0);
           addr_left : in STD_LOGIC_VECTOR (2 downto 0);
           addr_right : in STD_LOGIC_VECTOR (2 downto 0);
           addr_spi : in STD_LOGIC_VECTOR (19 downto 0);
           data_spi : in STD_LOGIC_VECTOR (15 downto 0);
           data_left : out STD_LOGIC_VECTOR (15 downto 0);
           data_right : out STD_LOGIC_VECTOR (15 downto 0));
end ram_controller;

architecture Behavioral of ram_controller is

begin


end Behavioral;

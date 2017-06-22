----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2017 15:44:02
-- Design Name: 
-- Module Name: TextController - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TextController is
  Port ( 
    clk25 : in STD_LOGIC;
    X, Y : in STD_LOGIC_VECTOR (9 downto 0);
    writeEnable : in std_logic;
    writeEnable2 : in std_logic;
    writeAddress : in std_logic_vector(11 downto 0);
    writeValue : in std_logic_vector(7 downto 0);
    writeValue2 : in std_logic_vector(11 downto 0);
    output : out STD_LOGIC_VECTOR (11 downto 0);
    empty : out std_logic; 
    menu : in std_logic
);
end TextController;
architecture Behavioral of TextController is

    component font_rom is
    Port(
       clk: in std_logic;
       addr: in std_logic_vector(10 downto 0);
       data: out std_logic_vector(7 downto 0)
    );
    end component;
    
    component char_mem is
       port(
          clk: in std_logic;
          char_read_addr : in std_logic_vector(11 downto 0);
          char_write_addr: in std_logic_vector(11 downto 0);
          char_we : in std_logic;
          char_write_value : in std_logic_vector(7 downto 0);
          char_read_value : out std_logic_vector(7 downto 0)
       );
    end component;
    
    component color_mem is
        Port ( 
            clk: in std_logic;
            char_read_addr : in std_logic_vector(11 downto 0);
            char_write_addr: in std_logic_vector(11 downto 0);
            char_we : in std_logic;
            char_write_value : in std_logic_vector(11 downto 0);
            char_read_value : out std_logic_vector(11 downto 0)
           );
    end component;
    
    SIGNAL addr_temp1 : STD_LOGIC_VECTOR(10 downto 0);
    SIGNAL addr_temp2 : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL addr_temp3 : STD_LOGIC_VECTOR(11 downto 0);
    SIGNAL addr_r_temp : STD_LOGIC_VECTOR(11 downto 0);
    SIGNAL data_temp : STD_LOGIC_VECTOR(0 to 7);
    SIGNAL char_r_temp : STD_LOGIC_VECTOR(7 downto 0);
    CONSTANT width : INTEGER := 80; -- "0001100011";
    CONSTANT height : INTEGER := 120; -- "0001100011";
    
begin

font_rom_test: font_rom PORT MAP (
    clk => clk25, 
    addr => addr_temp1,
    data => data_temp
);

char_mem_test: char_mem PORT MAP (
    clk => clk25,
    char_read_addr => addr_r_temp, 
    char_write_addr => writeAddress,
    char_we => writeEnable,
    char_write_value => writeValue,
    char_read_value => addr_temp2
);

color_mem_test: color_mem PORT MAP (
    clk => clk25,
    char_read_addr => addr_r_temp, 
    char_write_addr => writeAddress,
    char_we => writeEnable2,
    char_write_value => writeValue2,
    char_read_value => addr_temp3
);

process(clk25) --loop
    variable bitInChar, column, bitInRow, row : integer := 0;
    variable oldX : std_logic_vector(9 downto 0);
begin
    oldX := X - 3;
    
    if (rising_edge(clk25)) then     
        if (data_temp(to_integer(unsigned(oldX(2 downto 0)))) = '1') then
           output <= addr_temp3;
           empty <= '0';
        elsif(X >= 320 - width AND X < 320 + width AND Y >= 160 - height AND Y < 160 + height AND menu = '1') then
            output <= "000000000000";
            empty <= '0';
        else 
           output <= "111100000000";
           empty <= '1';
        end if;
    
        row := to_integer(unsigned(Y(9 downto 4)));
        column := to_integer(unsigned(X(9 downto 3)));
        addr_r_temp <= std_logic_vector(to_unsigned(row * 128 + column, 12));
    end if;
    if (falling_edge(clk25)) then
        addr_temp1 <= addr_temp2(6 downto 0) & Y(3 downto 0);
    end if;
end process;

end Behavioral;
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_controller is
    Port (
           clk200       : in STD_LOGIC;
           clk25        : in STD_LOGIC;
           VGAleft      : in STD_LOGIC_VECTOR (19 downto 0);
           VGAright     : in STD_LOGIC_VECTOR (19 downto 0);
           addr_left    : in STD_LOGIC_VECTOR (2 downto 0);
           addr_right   : in STD_LOGIC_VECTOR (2 downto 0);
           addr_spi     : in STD_LOGIC_VECTOR (19 downto 0);
           data_spi     : in STD_LOGIC_VECTOR (15 downto 0);
           data_left    : out STD_LOGIC_VECTOR (12 downto 0);
           data_right   : out STD_LOGIC_VECTOR (12 downto 0));
end ram_controller;

architecture Behavioral of ram_controller is
    --example
    component ram_module is
        Port ( clk : in STD_LOGIC;               --on rising edge, give color of current position. (USE ONLY 1 TICK, NOT MORE)
               ss : in STD_LOGIC;                --high active
               write : in STD_LOGIC;             --low active!!
               screen_left : in STD_LOGIC;       --low, data for left screen, high data for right screen
               position : in STD_LOGIC_VECTOR (19 downto 0);        --VGA position (0,0) => already visible
               pixel : out STD_LOGIC_VECTOR (12 downto 0));         --Color on the current location
    end component;
    
     component ram_module2 is
           Port ( clk : in STD_LOGIC;               --on rising edge, give color of current position. (USE ONLY 1 TICK, NOT MORE)
                  ss : in STD_LOGIC;                --high active
                  write : in STD_LOGIC;             --low active!!
                  screen_left : in STD_LOGIC;       --low, data for left screen, high data for right screen
                  position : in STD_LOGIC_VECTOR (19 downto 0);        --VGA position (0,0) => already visible
                  pixel : out STD_LOGIC_VECTOR (12 downto 0));         --Color on the current location
       end component;
    
    --SIGNAL clk_mod : STD_LOGIC := '0';
    SIGNAL select_mod : STD_LOGIC_vector(7 downto 0) := (others => '0');
    SIGNAL pos_mod : STD_LOGIC_vector(19 downto 0) := (others => '0');
    --SIGNAL mod_address: STD_LOGIC_vector(19 downto 0);
    SIGNAL color_mod : STD_LOGIC_vector(12 downto 0) := (others => '0');
begin

left: ram_module PORT MAP(
    clk => clk25,
    ss => select_mod(0),
    write => '1',
    screen_left => clk200,
    position => pos_mod,
    pixel => color_mod
);

--right: ram_module PORT MAP(
--    clk => clk25,
--    ss => select_mod(2),
--    write => '1',
--    screen_left => clk200,
--    position => pos_mod,
--    pixel => color_mod
--);

background: ram_module2 PORT MAP( 
    clk => clk25,
    ss => select_mod(1),
    write => '1',
    screen_left => clk200,
    position => pos_mod,
    pixel => color_mod
);

pos_mod <= VGAleft WHEN clk200 = '0' ELSE
           VGAright;
           
data_left   <=    color_mod WHEN clk200 = '0';
data_right  <=    color_mod WHEN clk200 = '1';
           
--mod_address <=  addr_left WHEN clk = '0' ELSE
--                addr_right;
                
select_mod <=   "00000001" WHEN  addr_left = "000" AND clk200 = '0' ELSE
                --"00000100" WHEN  addr_left = "001" AND clk200 = '0' ELSE
                --"00000100" WHEN  addr_right = "000" AND clk200 = '1' ELSE
                "00000001" WHEN  addr_right = "001" AND clk200 = '1' ELSE
                "00000010";


--                "00000001" WHEN  addr_left = "000" AND clk = '0' ELSE
--                "00000010" WHEN  addr_left = "001" AND clk = '0' ELSE
--                "00000100" WHEN  addr_left = "010" AND clk = '0' ELSE
--                "00001000" WHEN  addr_left = "011" AND clk = '0' ELSE
--                "00010000" WHEN  addr_left = "100" AND clk = '0' ELSE
--                "00100000" WHEN  addr_left = "101" AND clk = '0' ELSE
--                "01000000" WHEN  addr_left = "110" AND clk = '0' ELSE
--                "01000000" WHEN  addr_right = "000" AND clk = '1' ELSE
--                "00100000" WHEN  addr_right = "001" AND clk = '1' ELSE
--                "00010000" WHEN  addr_right = "010" AND clk = '1' ELSE
--                "00001000" WHEN  addr_right = "011" AND clk = '1' ELSE
--                "00000100" WHEN  addr_right = "100" AND clk = '1' ELSE
--                "00000010" WHEN  addr_right = "101" AND clk = '1' ELSE
--                "00000001" WHEN  addr_right = "110" AND clk = '1' ELSE                
--                "10000000";

--process(clk)
--begin
--    clk_mod <= '0';
--    if falling_edge(clk) then
--        case mod_address is
--            when "000" => select_mod <= "0000000";
--            when "001" => select_mod <= "0000001";
--            when "010" => select_mod <= "0000010";
--            when "011" => select_mod <= "0000100";
--            when "100" => select_mod <= "0001000";
--            when "101" => select_mod <= "0010000";
--            when "110" => select_mod <= "0100000";
--            when others => select_mod <= "1000000";
--         end case;
--    else
--        case mod_address is
--            when "000" => select_mod <= "0100000";
--            when "001" => select_mod <= "0010000";
--            when "010" => select_mod <= "0001000";
--            when "011" => select_mod <= "0000100";
--            when "100" => select_mod <= "0000010";
--            when "101" => select_mod <= "0000001";
--            when "110" => select_mod <= "0000000";
--            when others => select_mod <= "1000000";
--         end case;
--    end if;
--    clk_mod <= '1';
--end process;


end Behavioral;

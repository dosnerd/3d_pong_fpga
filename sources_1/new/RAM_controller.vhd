----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2017 15:08:35
-- Design Name: 
-- Module Name: RAM_controller - Behavioral
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

entity RAM_controller is
  Port (
        clk25, clk200 : in STD_LOGIC;
        X, Y: in STD_LOGIC_VECTOR (9 downto 0);
        pixel_left, pixel_right : out STD_LOGIC_VECTOR (11 downto 0)
  );
end RAM_controller;

architecture Behavioral of RAM_controller is
    component ball is
        Port ( 
            clk25 : in STD_LOGIC;
            X, Y : in STD_LOGIC_VECTOR (9 downto 0);
            out_left, out_right : out STD_LOGIC_VECTOR (11 downto 0);
            empty_left, empty_right : out STD_LOGIC
        );
    end component;
    
    SIGNAL left_color, right_color : STD_LOGIC_VECTOR (11 downto 0);
    
    SIGNAL color : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL ball_left, ball_right : STD_LOGIC_VECTOR (11 downto 0);
    SIGNAL ball_emtpy_left, ball_emtpy_right : STD_LOGIC;
begin

ball_module: ball PORT MAP(
    clk25 => clk25,
    X => X,
    Y => Y,
    out_left => ball_left,
    out_right => ball_right,
    empty_left => ball_emtpy_left,
    empty_right => ball_emtpy_right
);

left: process(clk25)
begin
    if (falling_edge(clk25)) then
        if (ball_emtpy_left = '0') then
            left_color <= ball_left;
        end if;
        
        pixel_left <= ball_left; 
    end if;
end process;

right: process(clk25)
begin
    if (falling_edge(clk25)) then
        if (ball_emtpy_right = '0') then
            right_color <= ball_right;
        end if;
        
        pixel_right <= ball_right; 
    end if;
end process;

end Behavioral;

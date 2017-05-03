------------------------------------------------------------------------------------
---- Company: 
---- Engineer: 
---- 
---- Create Date: 13.04.2017 08:45:39
---- Design Name: 
---- Module Name: ligths - Behavioral
---- Project Name: 
---- Target Devices: 
---- Tool Versions: 
---- Description: 
---- 
---- Dependencies: 
---- 
---- Revision:
---- Revision 0.01 - File Created
---- Additional Comments:
---- 
------------------------------------------------------------------------------------


--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_SIGNED.ALL;

---- Uncomment the following library declaration if using
---- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx leaf cells in this code.
----library UNISIM;
----use UNISIM.VComponents.all;

--entity ligths is
--  Port ( 
--        clk25 : in STD_LOGIC;
--        X, Y : in STD_LOGIC_VECTOR (9 downto 0);
--        X_ball, Y_ball, Z_left_ball : in integer;
--        output_left, output_right : out STD_LOGIC_VECTOR (11 downto 0);
--        empty_left, empty_right : out STD_LOGIC);
--end ligths;

--architecture Behavioral of ligths is
--    SIGNAL Z_right_ball : integer;
--begin
    
--Z_right_ball <= -9 - Z_left_ball;
    
--process(clk25)
--    variable x_center : INTEGER;
--    variable y_center : INTEGER;
    
--    --    variable painted : boolean;
--    variable i : integer;
--    variable z_index : INTEGER;
--    variable xMem, yMem : integer;
--    variable xMem2, yMem2, zMem2, distance : integer;
--    variable zx, zy : integer;
--begin
--   if (rising_edge(clk25)) then
     
--       x_center := to_integer(signed(X - 320));
--       y_center := to_integer(signed(Y- 240));
       
--       --320*8=2560, 
--       --230*8=1840 240*8=1920
--       zx := 10240 /  abs(x_center);
--       zy := 7680 /  abs(y_center);
       
--       X_ball := X_ball ** 2;
--       Y_ball;
--       Z_left_ball;
       
--       empty_left <= '1';
       
--        if  zx >= 32 AND zx <= 288 then
--            output_left(3 downto 0) <= "1111";
--            empty_left <= '0';
--        end if;    
--    end if;
--end process;

--end Behavioral;

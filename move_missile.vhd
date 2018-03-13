----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:24:01 12/25/2015 
-- Design Name: 
-- Module Name:    move_missile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes the movement of the missile
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY move_missile IS
    PORT (
		reset, ok : IN STD_LOGIC;
		direction : IN STD_LOGIC_VECTOR(1 downto 0);
		speedX_missile : IN STD_LOGIC_VECTOR(3 downto 0);
		speedY_missile : IN STD_LOGIC_VECTOR(3 downto 0);
		posXIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posYIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posXOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0);
		posYOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0));
END ENTITY;

ARCHITECTURE Behavioral OF move_missile IS

BEGIN

	posXOut_missile <= (others => '0') when reset = '1' 
		else std_logic_vector(signed(posXIn_missile) + signed(speedX_missile)) when ok = '1' and direction = "01" and posXIn_missile < "1001110000" 
			else std_logic_vector(signed(posXIn_missile) - signed(speedX_missile)) when ok = '1' and direction = "10" and posXIn_missile > "0000000000"
				else posXIn_missile;
					
	posYOut_missile <= (others => '0') when reset = '1'
		else std_logic_vector(signed(posYIn_missile) - signed(speedY_missile)) when ok = '1'
			else posYIn_missile;

END Behavioral;
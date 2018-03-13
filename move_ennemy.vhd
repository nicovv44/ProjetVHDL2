----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6 
-- 
-- Create Date:    17:25:52 12/25/2015 
-- Design Name: 
-- Module Name:    move_ennemy - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes the movement of the ennemy
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

ENTITY move_ennemy IS
    PORT (
		reset : IN STD_LOGIC;
		speedX_ennemy : IN STD_LOGIC_VECTOR(3 downto 0);
		speedY_ennemy : IN STD_LOGIC_VECTOR(3 downto 0);
		posXIn_ennemy : IN STD_LOGIC_VECTOR(9 downto 0);
		posYIn_ennemy : IN STD_LOGIC_VECTOR(9 downto 0);
		posXOut_ennemy : OUT STD_LOGIC_VECTOR(9 downto 0);
		posYOut_ennemy : OUT STD_LOGIC_VECTOR(9 downto 0));
END move_ennemy;

ARCHITECTURE Behavioral OF move_ennemy IS

BEGIN

	posXOut_ennemy <= (others => '0') when reset = '1' 
		else std_logic_vector(signed(posXIn_ennemy) + signed(speedX_ennemy));
				
	posYOut_ennemy <= (others => '0') when reset = '1'
		else std_logic_vector(signed(posYIn_ennemy) + signed(speedY_ennemy)); 
		
END Behavioral;
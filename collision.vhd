----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:25:03 12/25/2015 
-- Design Name: 
-- Module Name:    collision - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes all collision components
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

ENTITY collision IS
	PORT (
		clk : IN STD_LOGIC;
		posXEnnemy1 : IN STD_LOGIC_VECTOR(9 downto 0);
		posYEnnemy1 : IN STD_LOGIC_VECTOR(9 downto 0);
		posXEnnemy2 : IN STD_LOGIC_VECTOR(9 downto 0);
		posYEnnemy2 : IN STD_LOGIC_VECTOR(9 downto 0);
		posXEnnemy3 : IN STD_LOGIC_VECTOR(9 downto 0);
		posYEnnemy3 : IN STD_LOGIC_VECTOR(9 downto 0);
		posXMissile : IN STD_LOGIC_VECTOR(9 downto 0);
		posYMissile : IN STD_LOGIC_VECTOR(9 downto 0);
		turretHit : OUT STD_LOGIC;
		ennemy1Hit : OUT STD_LOGIC;
		ennemy2Hit : OUT STD_LOGIC;
		ennemy3Hit : OUT STD_LOGIC);
END collision;

ARCHITECTURE Behavioral OF collision IS

signal sposXEnnemy1 : std_logic_vector(9 downto 0);
signal sposYEnnemy1 : std_logic_vector(9 downto 0);
signal sposXEnnemy2 : std_logic_vector(9 downto 0);
signal sposYEnnemy2 : std_logic_vector(9 downto 0);
signal sposXEnnemy3 : std_logic_vector(9 downto 0);
signal sposYEnnemy3 : std_logic_vector(9 downto 0);
signal sposXMissile : std_logic_vector(9 downto 0);
signal sposYMissile : std_logic_vector(9 downto 0);

BEGIN

	sposXEnnemy1 <= posXEnnemy1;
	sposYEnnemy1 <= posYEnnemy1;
	sposXEnnemy2 <= posXEnnemy2;
	sposYEnnemy2 <= posYEnnemy2;
	sposXEnnemy3 <= posXEnnemy3;
	sposYEnnemy3 <= posYEnnemy3;
	sposXMissile <= posXMissile;
	sposYMissile <= posYMissile;

	turretHit <= '1' when
				(unsigned(sposYEnnemy1)>319
				or unsigned(sposYEnnemy2)>319
				or unsigned(sposYEnnemy3)>319)
				else '0';
		
	ennemy1Hit <= '1' when
				(( unsigned(sposYMissile) < unsigned(sposYEnnemy1)+ 55) and (unsigned(sposYMissile) > unsigned(sposYEnnemy1)) and (unsigned(sposXMissile)+8 < unsigned(sposXEnnemy1)+64) and (unsigned(sposXMissile)+8 > unsigned(sposXEnnemy1)))
				else '0';
	
	ennemy2Hit <= '1' when
				(( unsigned(sposYMissile) < unsigned(sposYEnnemy2)+ 64) and (unsigned(sposYMissile) > unsigned(sposYEnnemy2)) and (unsigned(sposXMissile)+8 < unsigned(sposXEnnemy2)+59) and (unsigned(sposXMissile)+8 > unsigned(sposXEnnemy2)))
				else '0';
	
	ennemy3Hit <= '1' when
				(( unsigned(sposYMissile) < unsigned(sposYEnnemy3)+ 64) and (unsigned(sposYMissile) > unsigned(sposYEnnemy3)) and (unsigned(sposXMissile)+8 < unsigned(sposXEnnemy3)+57) and (unsigned(sposXMissile)+8 > unsigned(sposXEnnemy3)))
				else '0';

END Behavioral;
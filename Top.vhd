----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:16:37 12/25/2015 
-- Design Name: 
-- Module Name:    Top - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

-- Uncomment the followINg library declaration if usINg
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the followINg library declaration if INstantiatINg
-- any XilINx primitives IN this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Top IS
	PORT (
		clk50 : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		shoot : IN STD_LOGIC;
		rotation_left : IN STD_LOGIC;
		rotation_right : IN STD_LOGIC;
		red : OUT STD_LOGIC;
		green : OUT STD_LOGIC;
		blue : OUT STD_LOGIC;
		hsync : OUT STD_LOGIC;
		vsync : OUT STD_LOGIC);
END Top;

ARCHITECTURE Behavioral OF Top IS

COMPONENT turret IS
    PORT ( 
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		posXIn_turret : IN STD_LOGIC_VECTOR (9 downto 0);
		posYIn_turret : IN STD_LOGIC_VECTOR (9 downto 0);
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		shoot : IN STD_LOGIC;
		rotation_left : IN STD_LOGIC;
		rotation_right : IN STD_LOGIC;
		redOut_turret : OUT STD_LOGIC;
		greenOut_turret : OUT STD_LOGIC;
		blueOut_turret : OUT STD_LOGIC;
		hit : IN STD_LOGIC;
		hit_ennemy : IN STD_LOGIC;
		posXMissile : OUT STD_LOGIC_VECTOR(9 downto 0); 
		posYMissile : OUT STD_LOGIC_VECTOR(9 downto 0));
END COMPONENT;

COMPONENT troll IS
    PORT ( 
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		posXIn_troll : IN STD_LOGIC_VECTOR (9 downto 0);
		posYIn_troll : IN STD_LOGIC_VECTOR (9 downto 0);
		posXOut_troll : OUT STD_LOGIC_VECTOR (9 downto 0);
		posYOut_troll : OUT STD_LOGIC_VECTOR (9 downto 0);
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		redOut_troll : OUT STD_LOGIC;
		greenOut_troll : OUT STD_LOGIC;
		blueOut_troll : OUT STD_LOGIC;
		hit : IN STD_LOGIC);
END COMPONENT;

COMPONENT spider IS
    PORT ( 
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		posXIn_spider : IN STD_LOGIC_VECTOR (9 downto 0);
		posYIn_spider : IN STD_LOGIC_VECTOR (9 downto 0);
		posXOut_spider : OUT STD_LOGIC_VECTOR (9 downto 0);
		posYOut_spider : OUT STD_LOGIC_VECTOR (9 downto 0);
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		redOut_spider : OUT STD_LOGIC;
		greenOut_spider : OUT STD_LOGIC;
		blueOut_spider : OUT STD_LOGIC;
		hit : IN STD_LOGIC);
END COMPONENT;

COMPONENT alien IS
    PORT ( 
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		posXIn_alien : IN STD_LOGIC_VECTOR (9 downto 0);
		posYIn_alien : IN STD_LOGIC_VECTOR (9 downto 0);
		posXOut_alien : OUT STD_LOGIC_VECTOR (9 downto 0);
		posYOut_alien : OUT STD_LOGIC_VECTOR (9 downto 0);
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		redOut_alien : OUT STD_LOGIC;
		greenOut_alien : OUT STD_LOGIC;
		blueOut_alien : OUT STD_LOGIC;
		hit : IN STD_LOGIC);
END COMPONENT;

COMPONENT collision is
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
END COMPONENT;

COMPONENT end_game is
	PORT(
		isTurretHit : IN STD_LOGIC;
		ennemy1Down : IN STD_LOGIC;
		ennemy2Down : IN STD_LOGIC;
		ennemy3Down : IN STD_LOGIC;
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		rOUT, gOUT, bOUT : OUT STD_LOGIC);
END COMPONENT;

COMPONENT controlVGA IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		rIN, gIN, bIN : IN STD_LOGIC;
		rOUT, gOUT, bOUT : OUT STD_LOGIC;
		beamX, beamY : OUT STD_LOGIC_VECTOR(9 downto 0);
		beamValid : OUT STD_LOGIC;
		blank : INOUT STD_LOGIC;
		vsync : OUT STD_LOGIC;
		hsync : OUT STD_LOGIC);
END COMPONENT; 

signal sred : std_logic;
signal sgreen : std_logic;
signal sblue : std_logic;
signal sbeamX : std_logic_vector(9 downto 0);
signal sbeamY : std_logic_vector(9 downto 0);
signal sbeamValid : std_logic;

signal sposXMissile : std_logic_vector(9 downto 0);
signal sposYMissile : std_logic_vector(9 downto 0);

--HIT Signals --

signal sturrethit : std_logic := '0';
signal sennemy1hit : std_logic;
signal sennemy2hit : std_logic;
signal sennemy3hit : std_logic;
signal sennemy1down : std_logic := '0';
signal sennemy2down : std_logic := '0';
signal sennemy3down : std_logic := '0';
signal shitennemy : std_logic;

signal sred_turret : std_logic;
signal sgreen_turret : std_logic;
signal sblue_turret : std_logic;
signal sposXIn_turret : std_logic_vector(9 downto 0) := "0010011010";
signal sposYIn_turret : std_logic_vector(9 downto 0) := "0110000001";

signal sred_ennemy_1 : std_logic;
signal sgreen_ennemy_1 : std_logic;
signal sblue_ennemy_1 : std_logic;
signal sposXIn_ennemy_1 : std_logic_vector(9 downto 0) := "0000000001";
signal sposYIn_ennemy_1 : std_logic_vector(9 downto 0) := "0000000010";
signal sposXOut_ennemy_1 : std_logic_vector(9 downto 0);
signal sposYOut_ennemy_1 : std_logic_vector(9 downto 0);

signal sred_ennemy_2 : std_logic;
signal sgreen_ennemy_2 : std_logic;
signal sblue_ennemy_2 : std_logic;
signal sposXIn_ennemy_2 : std_logic_vector(9 downto 0) := "0100100111";
signal sposYIn_ennemy_2 : std_logic_vector(9 downto 0) := "0000000010";
signal sposXOut_ennemy_2 : std_logic_vector(9 downto 0);
signal sposYOut_ennemy_2 : std_logic_vector(9 downto 0);

signal sred_ennemy_3 : std_logic;
signal sgreen_ennemy_3 : std_logic;
signal sblue_ennemy_3 : std_logic;
signal sval_ennemy_3 : std_logic_vector(31 downto 0);
signal sposXIn_ennemy_3 : std_logic_vector(9 downto 0) := "1001100010";
signal sposYIn_ennemy_3 : std_logic_vector(9 downto 0) := "0000000010";
signal sposXOut_ennemy_3 : std_logic_vector(9 downto 0);
signal sposYOut_ennemy_3 : std_logic_vector(9 downto 0);

signal endRedOut : std_logic;
signal endGreenOut : std_logic;
signal endBlueOut : std_logic;

BEGIN

	player : turret port map (
		clk => clk50,
		reset => reset,
		posXIn_turret => sposXIn_turret,
		posYIn_turret => sposYIn_turret,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		shoot => shoot,
		rotation_left => rotation_left,
		rotation_right => rotation_right,
		redOut_turret => sred_turret,
		greenOut_turret => sgreen_turret,
		blueOut_turret => sblue_turret,
		hit => sturrethit,
		hit_ennemy => shitennemy,
		posXMissile => sposXMissile,
		posYMissile => sposYMissile);

	ennemy1 : troll port map (
		clk => clk50,
		reset => reset,
		posXIn_troll => sposXIn_ennemy_1,
		posYIn_troll => sposYIn_ennemy_1,
		posXOut_troll => sposXOut_ennemy_1,
		posYOut_troll => sposYOut_ennemy_1,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		redOut_troll => sred_ennemy_1,
		greenOut_troll => sgreen_ennemy_1,
		blueOut_troll => sblue_ennemy_1,
		hit => sennemy1hit);
		
	ennemy2 : spider port map (
		clk => clk50,
		reset => reset,
		posXIn_spider => sposXIn_ennemy_2,
		posYIn_spider => sposYIn_ennemy_2,
		posXOut_spider => sposXOut_ennemy_2,
		posYOut_spider => sposYOut_ennemy_2,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		redOut_spider => sred_ennemy_2,
		greenOut_spider => sgreen_ennemy_2,
		blueOut_spider => sblue_ennemy_2,
		hit => sennemy2hit);
		
	ennemy3 : alien port map (
		clk => clk50,
		reset => reset,
		posXIn_alien => sposXIn_ennemy_3,
		posYIn_alien => sposYIn_ennemy_3,
		posXOut_alien => sposXOut_ennemy_3,
		posYOut_alien => sposYOut_ennemy_3,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		redOut_alien => sred_ennemy_3,
		greenOut_alien => sgreen_ennemy_3,
		blueOut_alien => sblue_ennemy_3,
		hit => sennemy3hit);
		
	collisionTest : collision port map (
		clk => clk50,
		posXEnnemy1 => sposXOut_ennemy_1,
		posYEnnemy1 => sposYOut_ennemy_1,
		posXEnnemy2 => sposXOut_ennemy_2,
		posYEnnemy2 => sposYOut_ennemy_2,
		posXEnnemy3 => sposXOut_ennemy_3,
		posYEnnemy3 => sposYOut_ennemy_3,
		posXMissile => sposXMissile,
		posYMissile => sposYMissile,
		turretHit => sturrethit,
		ennemy1Hit => sennemy1hit,
		ennemy2Hit => sennemy2hit,
		ennemy3Hit => sennemy3hit);
		
	endstate : end_game port map(
		isTurretHit => sturrethit,
		ennemy1Down => sennemy1down,
		ennemy2Down => sennemy2down,
		ennemy3Down => sennemy2down,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		rOUT => endRedOut,
		gOUT => endGreenOut,
		bOUT => endBlueOut);

	display : controlVGA port map (
		clk => clk50,
		reset => reset,
		rIN => sred,
		gIN => sgreen,
		bIN => sblue,
		rOUT => red, 
		gOUT => green,
		bOUT => blue,
		beamX => sbeamX,
		beamY => sbeamY,
		beamValid => sbeamValid,
		vsync => vsync,
		hsync => hsync);

	shitennemy <= sennemy1hit or sennemy2hit or sennemy3hit;
	sennemy1down <= sennemy1down or sennemy1hit when rising_edge(clk50);
	sennemy2down <= sennemy2down or sennemy2hit when rising_edge(clk50);
	sennemy3down <= sennemy3down or sennemy3hit when rising_edge(clk50);

	sred <= endRedOut or ((not endRedOut) and (sred_turret or sred_ennemy_1 or sred_ennemy_2 or sred_ennemy_3));
	sgreen <= endGreenOut or ((not endGreenOut) and (sgreen_turret or sgreen_ennemy_1 or sgreen_ennemy_2 or sgreen_ennemy_3));
	sblue <= endBlueOut or ((not endBlueOut) and (sblue_turret or sblue_ennemy_1 or sblue_ennemy_2 or sblue_ennemy_3));
	
END Behavioral;
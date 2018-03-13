----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:24:23 12/25/2015 
-- Design Name: 
-- Module Name:    troll - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes all troll components
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY troll IS
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
END troll;

ARCHITECTURE Behavioral OF troll IS

COMPONENT move_ennemy IS
	PORT (
		reset : IN STD_LOGIC;
		speedX_ennemy : IN STD_LOGIC_VECTOR(3 downto 0);
		speedY_ennemy : IN STD_LOGIC_VECTOR(3 downto 0);
		posXIn_ennemy : IN STD_LOGIC_VECTOR(9 downto 0);
		posYIn_ennemy : IN STD_LOGIC_VECTOR(9 downto 0);
		posXOut_ennemy : OUT STD_LOGIC_VECTOR(9 downto 0);
		posYOut_ennemy : OUT STD_LOGIC_VECTOR(9 downto 0));
	END COMPONENT;	
	
TYPE image is ARRAY (natural range <>,natural range <>) OF std_logic_vector(0 to 2);

CONSTANT troll : image :=(
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","111","111"),
("111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","111","111","111"),
("111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","111","111","111"),
("111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","111","111","111","111"),
("111","111","111","111","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111"),
("111","111","111","111","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111"),
("111","111","111","110","110","110","111","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111"),
("111","111","110","110","110","111","111","111","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111"),
("111","111","110","110","110","111","111","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111"),
("111","110","110","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111"),
("111","110","110","110","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111"),
("110","110","110","110","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111"),
("110","110","110","110","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111"),
("111","110","110","110","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111"),
("111","110","110","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111"),
("111","111","110","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111"),
("111","111","110","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111"),
("111","111","111","110","110","110","110","110","110","110","110","110","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111"),
("111","111","111","110","110","110","110","110","110","110","110","110","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111"),
("111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111"),
("111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","110","110","110","110","110","110","110","111","111","111"),
("111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","111","111"),
("111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","111","111"),
("111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","111"),
("111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","110","110","110","110","110","110","110","110","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","110","110","110","110","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
("111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111","111"),
);						

signal newPosX_ennemy : std_logic_vector(10 downto 0);
signal newPosY_ennemy : std_logic_vector(10 downto 0);
signal sigValid_ennemy, romSig_ennemy : std_logic;

signal destruction : std_logic := '0';
signal direction : std_logic;
signal tempdirection : std_logic;

signal sposXTemp_ennemy : std_logic_vector(9 downto 0);
signal sposYTemp_ennemy : std_logic_vector(9 downto 0);
signal sposXCurrent_ennemy : std_logic_vector(9 downto 0);
signal sposYCurrent_ennemy :  std_logic_vector(9 downto 0);
signal snewPosXCurrent_ennemy : std_logic_vector(9 downto 0);
signal snewPosYCurrent_ennemy : std_logic_vector(9 downto 0);

signal sspeedX_ennemy : std_logic_vector(3 downto 0) := "0001";
signal sspeedY_ennemy : std_logic_vector(3 downto 0);

signal red_ennemy : std_logic;
signal green_ennemy : std_logic;
signal blue_ennemy : std_logic;

signal reg1_ennemy : std_logic_vector(31 downto 0):= x"00000000";
signal mux1_ennemy : std_logic_vector(31 downto 0):= x"00000000";
signal comp_ennemy : std_logic;

BEGIN

	destruction <= hit or destruction when rising_edge(clk);

	--SYNCHRONISATION PART
		
	--reg1_ennemy is equal to mux1_ennemy when rising edge
	reg1_ennemy <= (others => '0') when reset ='1' 
		else mux1_ennemy when rising_edge(clk);

	--comp_ennemy is equal '1' when reg1_ennemy = defined value
	comp_ennemy <= '1' when reg1_ennemy = x"0004FF00" --reg1_ennemy = x"02FAF081" --50M = 1s
		else '0';		

	-- timer 	
	mux1_ennemy <= std_logic_vector(unsigned(reg1_ennemy) + 1) when  comp_ennemy = '0'
		else (others => '0');

	--

	--ENNEMY PART

	--Latch problem				
	sposXTemp_ennemy <= snewPosXCurrent_ennemy when comp_ennemy = '1'
		else sposXCurrent_ennemy;
				
	sposYTemp_ennemy <= snewPosYCurrent_ennemy when comp_ennemy = '1'
		else sposYCurrent_ennemy;
				
	sposXCurrent_ennemy <= (others => '0') when reset = '1'
		else posXIn_troll when (sposXCurrent_ennemy = "0000000000" and sposYCurrent_ennemy = "0000000000")	
			else sposXTemp_ennemy when rising_edge(clk);
			
	sposYCurrent_ennemy <= (others => '0') when reset = '1'
		else posYIn_troll when (sposXCurrent_ennemy = "0000000000" and sposYCurrent_ennemy = "0000000000")	
			else sposYTemp_ennemy when rising_edge(clk);

			
	posXOut_troll <= sposXCurrent_ennemy;
	posYOut_troll <= sposYCurrent_ennemy;

	--

	--MOVE ENNEMY PART

	move_ennemy_function : move_ennemy port map (
		reset => reset,
		speedX_ennemy => sspeedX_ennemy,
		speedY_ennemy => sspeedY_ennemy,
		posXIn_ennemy => sposXCurrent_ennemy,
		posYIn_ennemy => sposYCurrent_ennemy,
		posXOut_ennemy => snewPosXCurrent_ennemy,
		posYOut_ennemy => snewPosYCurrent_ennemy);
		

	tempdirection <= '1' when ((((unsigned(sposXCurrent_ennemy) = "1000111101") and (unsigned(sposXCurrent_ennemy) + "0001") = "1000111110") and comp_ennemy = '1'))
		else '0' when (((unsigned(sposXCurrent_ennemy) = "0000000001") and ((unsigned(sposXCurrent_ennemy) - "0001") = "0000000000"))and comp_ennemy = '1')
			else direction;
	direction <= tempdirection when rising_edge(clk);

	sspeedY_ennemy <= "0101" when (((((unsigned(sposXCurrent_ennemy) = "1000111101") and (unsigned(sposXCurrent_ennemy) + "0001") = "1000111110")))
						  or ((unsigned(sposXCurrent_ennemy) = "0000000001") and ((unsigned(sposXCurrent_ennemy) - "0001") = "0000000000")))
		else "0000";

	sspeedX_ennemy <= "0001" when (direction = '0') 
							else "1111"; 

	--
				 
	-- DISPLAY PART
				 
	newPosX_ennemy <= std_logic_vector(('0'&unsigned(beamX))-('0'&unsigned(sposXCurrent_ennemy)));
	newPosY_ennemy <= std_logic_vector(('0'&unsigned(beamY))-('0'&unsigned(sposYCurrent_ennemy)));

	sigValid_ennemy <= '0' when destruction = '1'
						else '1' when signed(newPosX_ennemy)<64 and signed(newPosX_ennemy)>=0 and signed(newPosY_ennemy)>=0 and signed(newPosY_ennemy)<52 and beamValid='1'
							else '0';
	romSig_ennemy <= '1' when ((red_ennemy = '1' or blue_ennemy = '1' or green_ennemy = '1') and sigValid_ennemy = '1') 
		else '0';

	red_ennemy <= '1' when (troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "100"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "110"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "101"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "111")
						else '0';
						
	green_ennemy <= '1' when (troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "010"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "110"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "011"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "111")
						else '0';
						
	blue_ennemy <= '1' when (troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "001"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "101"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "011"
						or troll((to_integer(unsigned(newPosY_ennemy(5 downto 0)))),(to_integer(unsigned(newPosX_ennemy(6 downto 0))))) = "111")
						else '0';

	redOut_troll <= '1' when red_ennemy = '1' and romSig_ennemy = '1' 
		else '0';

	greenOut_troll <= '1' when green_ennemy='1' and romSig_ennemy='1'
		else '0';

	blueOut_troll <= '1' when blue_ennemy='1' and romSig_ennemy='1'
		else '0';

	--			
				
END Behavioral;
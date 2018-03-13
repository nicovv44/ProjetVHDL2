----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:23:46 12/25/2015 
-- Design Name: 
-- Module Name:    missile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes all missile components
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

ENTITY missile IS
    PORT (
		clk, reset, actif, init_missile, rotation_event : IN STD_LOGIC;
		rotation: IN STD_LOGIC_VECTOR(1 downto 0);
		posXIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posYIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posXOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0);
		posYOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0);
		beamX : IN STD_LOGIC_VECTOR (9 downto 0);
		beamY : IN STD_LOGIC_VECTOR (9 downto 0);
		beamValid : IN STD_LOGIC;
		redOut_missile : OUT STD_LOGIC;
		greenOut_missile : OUT STD_LOGIC;
		blueOut_missile : OUT STD_LOGIC);
END missile;

ARCHITECTURE Behavioral OF missile IS

COMPONENT move_missile IS
	PORT (
		reset, ok : IN STD_LOGIC;
		direction : IN STD_LOGIC_VECTOR(1 downto 0);
		speedX_missile : IN STD_LOGIC_VECTOR(3 downto 0);
		speedY_missile : IN STD_LOGIC_VECTOR(3 downto 0);
		posXIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posYIn_missile : IN STD_LOGIC_VECTOR(9 downto 0);
		posXOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0);
		posYOut_missile : OUT STD_LOGIC_VECTOR(9 downto 0));
	END COMPONENT;	
	
TYPE image is ARRAY (natural range <>,natural range <>) OF std_logic_vector(0 to 2);

CONSTANT missile : image :=(
("000","000","000","000","000","000","000","000","000","000","000","000","000","000","000","000"),
("000","000","000","000","000","000","000","100","100","000","000","000","000","000","000","000"),
("000","000","000","000","000","000","000","100","100","000","000","000","000","000","000","000"),
("000","000","000","000","000","000","111","110","110","111","000","000","000","000","000","000"),
("000","000","000","000","000","000","111","110","110","111","000","000","000","000","000","000"),
("000","000","000","000","000","111","111","110","110","111","111","000","000","000","000","000"),
("000","000","000","000","000","111","111","110","110","111","111","000","000","000","000","000"),
("000","000","000","000","000","111","111","111","111","111","111","000","000","000","000","000"),
("000","000","000","111","000","111","000","000","000","000","111","000","111","000","000","000"),
("000","000","000","110","000","000","111","111","111","111","000","000","110","000","000","000"),
("000","000","111","110","000","111","000","000","000","000","111","000","110","111","000","000"),
("000","000","110","111","000","000","000","000","000","000","000","000","111","110","000","000"),
("000","000","111","000","000","000","000","110","110","000","000","000","000","111","000","000"),
("000","000","000","000","000","000","111","100","100","111","000","000","000","000","000","000"),
("000","000","000","000","000","000","100","100","100","100","000","000","000","000","000","000"),
("000","000","000","000","000","000","100","000","000","100","000","000","000","000","000","000")
);

signal newPosX_missile : std_logic_vector(10 downto 0);
signal newPosY_missile : std_logic_vector(10 downto 0);
signal sigValid_missile, romSig_missile : std_logic;

signal sposXTemp_missile : std_logic_vector(9 downto 0);
signal sposYTemp_missile : std_logic_vector(9 downto 0);
signal sposXCurrent_missile : std_logic_vector(9 downto 0);
signal sposYCurrent_missile :  std_logic_vector(9 downto 0);
signal snewPosXCurrent_missile : std_logic_vector(9 downto 0);
signal snewPosYCurrent_missile : std_logic_vector(9 downto 0);

--signal sdirection_missile : std_logic;
signal sspeedX_missile : std_logic_vector(3 downto 0);
signal sspeedY_missile : std_logic_vector(3 downto 0);

signal red_missile : std_logic;
signal green_missile : std_logic;
signal blue_missile : std_logic;

signal reg1_missile : std_logic_vector(31 downto 0):= x"00000000";
signal mux1_missile : std_logic_vector(31 downto 0):= x"00000000";
signal comp_missile : std_logic;

BEGIN

	--SYNCHRONISATION PART
		
	--reg1_missile is equal to mux1_missile ahen rising edge
	reg1_missile <= (others => '0') when reset ='1' 
		else mux1_missile when rising_edge(clk);

	--comp_missile is equal '1' when reg1_missile = defined value
	comp_missile <= '1' when reg1_missile = x"0003FF81" --reg1_missile = x"02FAF081" --50M = 1s
		else '0';		

	-- timer 	
	mux1_missile <= std_logic_vector(unsigned(reg1_missile) + 1) when  comp_missile = '0'
		else (others => '0');

	--

	--MISSILE PART
					
	--Latch problem				
	sposXTemp_missile <= snewPosXCurrent_missile when comp_missile = '1' and actif = '1'
		else sposXCurrent_missile when actif = '1'
			else posXin_missile;
				
	sposYTemp_missile <= snewPosYCurrent_missile when comp_missile = '1' and actif = '1'
		else sposYCurrent_missile when actif = '1'
			else posYin_missile;
				
	sposXCurrent_missile <= (others => '0') when reset = '1'
		else sposXTemp_missile when rising_edge(clk);
			
	sposYCurrent_missile <= (others => '0') when reset = '1'
		else sposYTemp_missile when rising_edge(clk);
			
	posXOut_missile <= sposXCurrent_missile;
	posYOut_missile <= sposYCurrent_missile;

	--		

	--MOVE MISSILE PART

	move_missile_function : move_missile port map (
		reset => reset,
		ok => comp_missile,
		direction => rotation,
		speedX_missile => sspeedX_missile,
		speedY_missile => sspeedY_missile,
		posXIn_missile => sposXCurrent_missile,
		posYIn_missile => sposYCurrent_missile,
		posXOut_missile => snewPosXCurrent_missile,
		posYOut_missile => snewPosYCurrent_missile);

	sspeedX_missile <= "0011" when rotation_event = '1'
		else "0000";
		
	sspeedY_missile <= "0001" when init_missile = '1'
		else "0000" when actif = '0';

	--sdirection_missile <= '0' when rotation = "01"
	--	else '1' when rotation = "10";
	--

	-- DISPLAY PART
				 
	newPosX_missile <= std_logic_vector(('0'&unsigned(beamX))-('0'&unsigned(sposXCurrent_missile)));
	newPosY_missile <= std_logic_vector(('0'&unsigned(beamY))-('0'&unsigned(sposYCurrent_missile)));

	sigValid_missile <= '1' when signed(newPosX_missile)<16 and signed(newPosX_missile)>=0 and signed(newPosY_missile)>=0 and signed(newPosY_missile)<16 and beamValid='1' and actif = '1' else '0';
	romSig_missile <= '1' when ((red_missile = '1' or blue_missile = '1' or green_missile = '1') and sigValid_missile='1') 
		else '0';

	red_missile <= '1' when (missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "100"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "110"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "101"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "111")
						else '0';
						
	green_missile <= '1' when (missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "010"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "110"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "011"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "111")
						else '0';
						
	blue_missile <= '1' when (missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "001"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "101"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "011"
						or missile((to_integer(unsigned(newPosY_missile(3 downto 0)))),(to_integer(unsigned(newPosX_missile(3 downto 0))))) = "111")
						else '0';

	redOut_missile <= '1' when red_missile = '1' and romSig_missile = '1' 
		else '0';

	greenOut_missile <= '1' when green_missile='1' and romSig_missile='1'
		else '0';

	blueOut_missile <= '1' when blue_missile='1' and romSig_missile='1'
		else '0';

	--			
		
END Behavioral;
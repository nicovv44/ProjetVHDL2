----------------------------------------------------------------------------------
-- Company: ECE Paris
-- Engineer: Boudier Antoine - Law Nicolas - SEI group 6
-- 
-- Create Date:    17:25:28 12/25/2015 
-- Design Name: 
-- Module Name:    controlVGA - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Module which includes all display VGA components
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

entity controlVGA is
port(
    clk : in std_logic;
    reset : in std_logic;
    rIn, gIn, bIn : in std_logic;
    rOut, gOut, bOut : out std_logic;
	 beamX, beamY : out std_logic_vector(9 downto 0);
	 beamValid : out std_logic;
    blank : inout std_logic;
    vsync : out std_logic;
    hsync : out std_logic
    );
end entity;

architecture rtl of controlVGA is
constant MAXCPTH: integer := 794;

--signal ckdiv2   : std_logic;
signal cpthmux  : std_logic_vector(9 downto 0);
signal cpth     : std_logic_vector(9 downto 0);
signal cptvmux  : std_logic_vector(9 downto 0);
signal cptv     : std_logic_vector(9 downto 0);

signal cpthsup95 : std_logic;
signal cpthsup138: std_logic;
signal cpthsup778: std_logic;
signal cpthsup794: std_logic;


signal cptvsup2 : std_logic;
signal cptvsup36 : std_logic;
signal cptvsup516 : std_logic;
signal cptvsup525: std_logic;

signal hblank : std_logic;
signal vblank : std_logic;

signal ckdiv2 : std_logic;

signal redComb, greenComb, blueComb : std_logic;

begin


redComb 		<= '0' when blank='0' else rIn;
greenComb 	<= '0' when blank='0' else gIn;
blueComb 	<= '0' when blank='0' else bIn;

rOut <= redComb when rising_edge(clk);
gOut <= greenComb when rising_edge(clk);
bOut <= blueComb when rising_edge(clk);

ckdiv2 <= '0' when reset='1'
           else not(ckdiv2) when rising_edge (clk);

cpthmux <= (others => '0') when cpthsup794='1'
           else std_logic_vector(unsigned(cpth)+1);

cpth <= (others => '0') when reset='1'
        else cpthmux when rising_edge(ckdiv2);

cpthsup95 <= '1' when unsigned(cpth)>=95 else '0';
cpthsup138 <= '1' when unsigned(cpth)>=138 else '0';
cpthsup778 <= '1' when unsigned(cpth)>=778 else '0';
cpthsup794 <= '1' when unsigned(cpth)>=794 else '0';

hsync <= cpthsup95;
hblank <= not(cpthsup138) or cpthsup778;

cptvmux <= (others => '0') when cptvsup525='1'
           else std_logic_vector(unsigned(cptv)+1) when cpthsup794='1'
           else cptv;

cptv <= (others => '0') when reset='1'
        else cptvmux when rising_edge(ckdiv2);

cptvsup2 <= '1' when unsigned (cptv)>=2 else '0';
cptvsup36 <= '1' when unsigned (cptv)>=36 else '0';
cptvsup516 <= '1' when unsigned (cptv)>=516 else '0';
cptvsup525 <= '1' when unsigned(cptv)>=525 else '0';

vsync <= cptvsup2;
vblank <= not(cptvsup36) or cptvsup516;

blank <= not (hblank or vblank);

beamValid <= blank when rising_edge (clk);


beamX <= std_logic_vector(unsigned(cpth)-138) when rising_edge (clk);
beamY <= std_logic_vector(unsigned(cptv)-36) when rising_edge (clk);

end architecture rtl;
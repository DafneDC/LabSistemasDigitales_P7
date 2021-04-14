----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 15:32:44
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
    Port ( CLK100MHZ: in std_logic;
           SF: in std_logic_vector(1 downto 0);
           MRF: in std_logic;
           dataInF: in std_logic_vector(7 downto 0);
           qF: out std_logic_vector(7 downto 0)
         );
end main;

architecture Behavioral of main is

component freq_divisor is
       Port (clk50mhz: 	in STD_LOGIC;
	           clk: out STD_LOGIC);
end component;

component FourBitSR74LS194 is
    Port (dataIn: in std_logic_vector(3 downto 0);
          MSBin: in std_logic; --SR
          LSBin: in std_logic; --SL
          clk: in std_logic;
          S: in std_logic_vector(1 downto 0);
          MR: in std_logic;
          q: inout std_logic_vector(3 downto 0) 
          );
end component;

signal auxq: std_logic_vector(7 downto 0);
signal SCLK: std_logic := '0';

begin

divis: freq_divisor port map (clk50mhz=>CLK100MHZ, clk=>SCLK);

F0SR194: FourBitSR74LS194 port map (dataIn=>dataInF(3 downto 0), MSBin=>auxq(7), LSBin=>auxq(4) ,clk=>SCLK, S=>SF, MR=>MRF, q=>auxq(3 downto 0));
F1SR194: FourBitSR74LS194 port map (dataIn=>dataInF(7 downto 4), MSBin=>auxq(3), LSBin=>auxq(0) ,clk=>SCLK, S=>SF, MR=>MRF, q=>auxq(7 downto 4));

qF <= auxq;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2021 15:19:42
-- Design Name: 
-- Module Name: FourBitSR74LS194 - Behavioral
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

entity FourBitSR74LS194 is
    Port (dataIn: in std_logic_vector(3 downto 0);
          MSBin: in std_logic; --SR
          LSBin: in std_logic; --SL
          clk: in std_logic;
          S: in std_logic_vector(1 downto 0);
          MR: in std_logic;
          q: inout std_logic_vector(3 downto 0) 
          );
end FourBitSR74LS194;

architecture Behavioral of FourBitSR74LS194 is
--signal aux: std_logic_vector(3 downto 0);
begin

process(clk, S, MR)
begin
    if MR='1' then q<="0000";
    elsif MR='0' then
        if (clk'event and clk='1') then
            case S is
                when"00" => q<=q;        
                when"01"=> q<=q(2 downto 0) & MSBin;            
                when"10" => q<=LSBin & q(3 downto 1);          
                when"11" => q<=dataIn;                     
                when others=>null;                          
            end case;
        end if; 
    end if;
end process;
end Behavioral;

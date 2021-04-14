library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity BCD74169 is
      Port (dataIn: in std_logic_vector(3 downto 0);
            clk: in std_logic;
            load: in std_logic;
            reset: in std_logic;
            upDown: in std_logic;
            dataOut: out std_logic_vector(3 downto 0);
            resetCount: out std_logic
            );
end BCD74169;

architecture Behavioral of BCD74169 is
signal aux: std_logic_vector(3 downto 0);
signal bandera: std_logic := '0';
begin
    process(clk, reset)
    begin
    if reset= '1' then
    aux<="0000";
    elsif (clk'event and clk='1') then
    if(load='1') then
    aux <= dataIn;
    
    
    elsif (load = '0' and upDown = '1') then
    aux <= aux + 1;
    
    if(aux="1001") then
    aux<="0000";
    bandera<='1';
    end if;
    
    elsif (load = '0' and upDown = '0') then
    aux <= aux - 1;
    if(aux="0000") then
    aux<="1001";
    bandera<= '1'; 
    end if;
    
   
         
    end if;
    end if;
    if(bandera = '1') then
    bandera <=not bandera;
    end if;
    end process;
    dataOut<= aux;
    resetCount <= bandera;
    


end Behavioral;


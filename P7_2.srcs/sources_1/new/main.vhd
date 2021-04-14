
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main is
  Port (data: in std_logic_vector(3 downto 0);
        clock: in std_logic;
        cargar: in std_logic;
        Rst: in std_logic;
        direccion: in std_logic;
        dataO: out std_logic_vector(7 downto 0);
        D7A : out STD_LOGIC_VECTOR (7 downto 0);
        D71 : out STD_LOGIC_VECTOR (7 downto 0)
        );
end main;

architecture Behavioral of main is
component BCD74169 is
      Port (dataIn: in std_logic_vector(3 downto 0);
            clk: in std_logic;
            load: in std_logic;
            reset: in std_logic;
            upDown: in std_logic;
            dataOut: out std_logic_vector(3 downto 0);
            resetCount: out std_logic
            );
end component;

component freq_divisor is
       Port (clk50mhz: 	in STD_LOGIC;
	           clk: out STD_LOGIC);
end component;

component Seg7 is
       Port(ck : in  std_logic;                          
			number : in  std_logic_vector (63 downto 0);
			seg : out  std_logic_vector (7 downto 0);
			an : out  std_logic_vector (7 downto 0));
end component;

signal aux1: std_logic;
signal SCLK: std_logic := '0';
signal d7s : STD_LOGIC_VECTOR (63 downto 0) := "1111111111111111111111111111111111111111111111110000000000000000";
signal auxC1, auxC2: std_logic_vector(3 downto 0);
begin

Segm7: Seg7 port map (ck=>clock, number=>d7s, seg=> D7A, an=>D71);
divis: freq_divisor port map (clk50mhz=>clock, clk=>SCLK);
cont1: BCD74169 port map(dataIn=>data,clk=> SCLK, load=> cargar, reset =>Rst, upDown=>direccion,dataOut(3 downto 0)=>auxC1,resetCount=>aux1);
cont2: BCD74169 port map(dataIn=>data,clk=>aux1, load=> cargar, reset =>Rst, upDown=>direccion,dataOut(3 downto 0)=>auxC2);

dataO (3 downto 0) <= auxC1;
dataO (7 downto 4) <= auxC2;

process(auxC1, auxC2)
begin
        case (auxC2) is
                        when "0000" => d7s(15 downto 8) <= "11000000";
                        when "0001" => d7s(15 downto 8) <= "11111001";
                        when "0010" => d7s(15 downto 8) <= "10100100";
                        when "0011" => d7s(15 downto 8) <= "10110000";
                        when "0100" => d7s(15 downto 8) <= "10011001";
                        when "0101" => d7s(15 downto 8) <= "10010010";
                        when "0110" => d7s(15 downto 8) <= "10000010";
                        when "0111" => d7s(15 downto 8) <= "11111000";
                        when "1000" => d7s(15 downto 8) <= "10000000";
                        when "1001" => d7s(15 downto 8) <= "10010000";
                        when others => d7s(15 downto 8) <= "11111111";
                        end case;
    
        case (auxC1) is
                        when "0000" => d7s(7 downto 0) <= "11000000";
                        when "0001" => d7s(7 downto 0) <= "11111001";
                        when "0010" => d7s(7 downto 0) <= "10100100";
                        when "0011" => d7s(7 downto 0) <= "10110000";
                        when "0100" => d7s(7 downto 0) <= "10011001";
                        when "0101" => d7s(7 downto 0) <= "10010010";
                        when "0110" => d7s(7 downto 0) <= "10000010";
                        when "0111" => d7s(7 downto 0) <= "11111000";
                        when "1000" => d7s(7 downto 0) <= "10000000";
                        when "1001" => d7s(7 downto 0) <= "10010000";
                        when others => d7s(7 downto 0) <= "11111111";
                        end case;
end process;
end Behavioral;
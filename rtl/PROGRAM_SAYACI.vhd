-- Manta C211 Islemcisi - Program Sayaci
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MANTA.ALL;

entity PROGRAM_SAYACI is
	port(	saat, reset		: in std_logic;
			ps_say			: in std_logic;
			ps_atla			: in std_logic;
			ps_giris 		: in std_logic_vector(adres_genisligi-1 downto 0);
			ps_cikis 		: out std_logic_vector(adres_genisligi-1 downto 0)); 
			
end PROGRAM_SAYACI;

architecture Behavioral of PROGRAM_SAYACI is
	signal sayac : std_logic_vector(adres_genisligi-1 downto 0) := (others => '0');
begin

ps_cikis <= sayac;

	process(saat,reset)
	begin
		if reset = '1' then
			sayac <= (others => '0');
		elsif rising_edge(saat) then
			if ps_say = '1' then
				sayac <= sayac + 1;
			elsif ps_atla = '1' then
				sayac <= ps_giris;
			end if;
		end if;
	end process;

end Behavioral;

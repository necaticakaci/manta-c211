-- Manta C211 Islemcisi - Benzetim (Testbench)
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MANTA.ALL;

entity BENZETIM is
end BENZETIM;
 
architecture behavior of BENZETIM is 
	signal saat, reset : std_logic := '0';
	signal giris: std_logic_vector(giris_port_genisligi-1 downto 0); 
	signal cikis: std_logic_vector(cikis_port_genisligi-1 downto 0);
begin

	k1 : entity WORK.KABUK port map (saat, reset, giris, cikis);
	reset <= '1'after 1 ns, '0' after 2 ns;
	saat <= not saat after 10 ns;
	giris <= x"2F";

end;

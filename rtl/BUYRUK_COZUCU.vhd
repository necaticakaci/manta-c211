-- Manta C211 Islemcisi - Buyruk Cozucu
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MANTA.ALL;

entity BUYRUK_COZUCU is
	port(	saat, reset		: in std_logic;
			bc_oku			: in std_logic;
			bc_giris		: in std_logic_vector(buyruk_genisligi-1 downto 0);
			bc_sabit_cikis 	: out std_logic_vector(veri_genisligi-1 downto 0);
			bc_adres_cikis	: out std_logic_vector(adres_genisligi-1 downto 0);
			bc_kd0_cikis	: out std_logic_vector(3 downto 0);
			bc_kd1_cikis	: out std_logic_vector(3 downto 0);
			bc_buyruk		: out buyruk);
			
end BUYRUK_COZUCU;

architecture Behavioral of BUYRUK_COZUCU is
	signal buyruk_kaydedicisi : std_logic_vector(buyruk_genisligi-1 downto 0) := (others => '0');
begin

bc_sabit_cikis 	<= buyruk_kaydedicisi(veri_genisligi-1 downto 0); -- Buyruktaki sabit deger aktariliyor.
bc_adres_cikis	<= buyruk_kaydedicisi(11 downto 2); -- Buyruktaki adres kismi aktariliyor.
bc_kd0_cikis	<= buyruk_kaydedicisi(11 downto 8); -- Buyruktaki birinci kaydedici numarasi aktariliyor.
bc_kd1_cikis	<= buyruk_kaydedicisi(7 downto 4); -- Buyruktaki ikinci kaydedici numarai aktariliyor.
bc_buyruk 		<= coz(buyruk_kaydedicisi); -- Buyruk kodu cozuluyor.

	process(saat, reset)
	begin
		if reset = '1' then
			buyruk_kaydedicisi <= (others => '0');
		elsif rising_edge(saat) then
			if bc_oku = '1' then
				buyruk_kaydedicisi <= bc_giris;
			end if;
		end if;
	end process;
	
end Behavioral;

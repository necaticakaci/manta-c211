-- Manta C211 Islemcisi - Giris Cikis Birimi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MANTA.ALL;

entity GIRIS_CIKIS_BIRIMI is
	port(	saat				: in std_logic;
			gcb_oku				: in std_logic;
			gcb_yaz				: in std_logic;
			gcb_ivedi			: in std_logic;
			gcb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			gcb_sabit_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			gcb_port_giris		: in std_logic_vector(giris_port_genisligi-1 downto 0); 
			gcb_veri_cikis		: out std_logic_vector(veri_genisligi-1 downto 0); 
			gcb_port_cikis		: out std_logic_vector(cikis_port_genisligi-1 downto 0)); 

end GIRIS_CIKIS_BIRIMI;

architecture Behavioral of GIRIS_CIKIS_BIRIMI is
	signal giris_kaydedicisi : std_logic_vector(giris_port_genisligi-1 downto 0);
	signal cikis_kaydedicisi : std_logic_vector(cikis_port_genisligi-1 downto 0) := (others => '0');
begin
	
giris_kaydedicisi <= gcb_port_giris;
gcb_port_cikis 	<= cikis_kaydedicisi;

	process(saat)
	begin
		if rising_edge(saat) then
			if gcb_oku = '1' then
				gcb_veri_cikis <= giris_kaydedicisi; 
			elsif gcb_yaz = '1' then
				if gcb_ivedi = '0' then
					cikis_kaydedicisi <= gcb_veri_giris;
				else
					cikis_kaydedicisi <= gcb_sabit_giris;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

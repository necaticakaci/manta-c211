-- Manta C211 Islemcisi - Kaydedici Dosyasi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MANTA.ALL;

entity KAYDEDICI_DOSYASI is
	port(	saat, reset			: in std_logic;
		kd_sabit_oku			: in std_logic;
		kd_sonuc_oku			: in std_logic;
		kd_port_oku			: in std_logic;
		kd_bellek_oku			: in std_logic;	
		kd_yaz				: in std_logic;
		kd_ivedi			: in std_logic;
		kd_buyruk_sabit_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		kd_amb_sonuc_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		kd_gcb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		kd_vb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		kd_kd0_giris			: in std_logic_vector(3 downto 0);
		kd_kd1_giris			: in std_logic_vector(3 downto 0);
		kd_kd0_cikis			: out std_logic_vector(veri_genisligi-1 downto 0);
		kd_kd1_cikis			: out std_logic_vector(veri_genisligi-1 downto 0));

end KAYDEDICI_DOSYASI;

architecture Behavioral of KAYDEDICI_DOSYASI is
	signal kd0_kaydedicisi : std_logic_vector(veri_genisligi-1 downto 0) := (others => '0');
	signal kd1_kaydedicisi : std_logic_vector(veri_genisligi-1 downto 0) := (others => '0');
	type kaydedici_tipi is array(kaydedici_sayisi-1 downto 0) of std_logic_vector(veri_genisligi-1 downto 0);
	signal kaydediciler : kaydedici_tipi := (others => (others => '0'));
begin

kd_kd0_cikis <= kd0_kaydedicisi;
kd_kd1_cikis <= kd1_kaydedicisi;

	process(saat, reset)
	begin
		if reset = '1' then
			kd0_kaydedicisi <= (others => '0');
			kd1_kaydedicisi <= (others => '0');
		elsif rising_edge(saat) then
			if kd_sabit_oku = '1' then
				if kd_ivedi = '0' then
					kd0_kaydedicisi <= kaydediciler(conv_integer(kd_kd0_giris));
					kd1_kaydedicisi <= kaydediciler(conv_integer(kd_kd1_giris));
				elsif kd_ivedi = '1' then
					kd1_kaydedicisi <= kd_buyruk_sabit_giris;
				end if;
			elsif kd_sonuc_oku = '1' then
				kd1_kaydedicisi <= kd_amb_sonuc_giris;
			elsif kd_port_oku = '1' then
				kd1_kaydedicisi <= kd_gcb_veri_giris;
			elsif kd_bellek_oku = '1' then
				kd1_kaydedicisi <= kd_vb_veri_giris;
			elsif kd_yaz = '1' then
				kaydediciler(conv_integer(kd_kd0_giris)) <= kd1_kaydedicisi;
			end if;
		end if;
	end process;

end Behavioral;

-- Manta C211 Islemcisi - Aritmetik Mantik Birimi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.MANTA.ALL;

entity ARITMETIK_MANTIK_BIRIMI is
	port(	saat, reset		: in std_logic;
		amb_oku			: in std_logic;
		amb_ivedi		: in std_logic;
		amb_isle		: in std_logic;
		amb_islem_tip		: in std_logic_vector(3 downto 0);
		amb_kd0_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		amb_kd1_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		amb_sabit_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		amb_bayrak_sifir	: out std_logic;
		amb_bayrak_elde		: out std_logic;
		amb_sonuc_cikis		: out std_logic_vector(veri_genisligi-1 downto 0));
			
end ARITMETIK_MANTIK_BIRIMI;

architecture Behavioral of ARITMETIK_MANTIK_BIRIMI is
	constant sifir 		: unsigned(veri_genisligi downto 0) := (others => '0');
	signal x_kaydedicisi	: unsigned(veri_genisligi downto 0);
	signal y_kaydedicisi	: unsigned(veri_genisligi-1 downto 0);
begin

amb_bayrak_sifir	<= '1' when x_kaydedicisi = sifir else '0';
amb_bayrak_elde 	<= '1' when x_kaydedicisi(veri_genisligi) = '1' else '0';
amb_sonuc_cikis 	<= std_logic_vector(x_kaydedicisi(veri_genisligi-1 downto 0));

	process(saat, reset)
	begin
		if reset = '1' then
			x_kaydedicisi <= (others => '0');
			y_kaydedicisi <= (others => '0');
		elsif rising_edge(saat) then
			if amb_oku = '1' then
				x_kaydedicisi(veri_genisligi) <= '0'; -- Onceki islemden kalan bayrak temizleniyor.
				x_kaydedicisi(veri_genisligi-1 downto 0) <= unsigned(amb_kd0_giris);
				if amb_ivedi = '0' then
					y_kaydedicisi <= unsigned(amb_kd1_giris);
				else
					y_kaydedicisi <= unsigned(amb_sabit_giris);
				end if;
			elsif amb_isle = '1' then
				if amb_islem_tip = x"0" then -- Topla
					x_kaydedicisi <= x_kaydedicisi + y_kaydedicisi;
				elsif amb_islem_tip = x"1" then -- Cikar
					x_kaydedicisi <= x_kaydedicisi - y_kaydedicisi;
				elsif amb_islem_tip = x"2" then -- VE
					x_kaydedicisi(veri_genisligi-1 downto 0) <= x_kaydedicisi(veri_genisligi-1 downto 0) and y_kaydedicisi;
				elsif amb_islem_tip = x"3" then -- VEYA
					x_kaydedicisi(veri_genisligi-1 downto 0) <= x_kaydedicisi(veri_genisligi-1 downto 0) or y_kaydedicisi;
				elsif amb_islem_tip = x"4" then -- XOR
					x_kaydedicisi(veri_genisligi-1 downto 0) <= x_kaydedicisi(veri_genisligi-1 downto 0) xor y_kaydedicisi;
				elsif amb_islem_tip = x"5" then -- Saga kaydirma
					x_kaydedicisi(veri_genisligi-1 downto 0) <= shift_right(x_kaydedicisi(veri_genisligi-1 downto 0), to_integer(y_kaydedicisi));
				elsif amb_islem_tip = x"6" then -- Sola kaydirma
					x_kaydedicisi(veri_genisligi-1 downto 0) <= shift_left(x_kaydedicisi(veri_genisligi-1 downto 0), to_integer(y_kaydedicisi));
				elsif amb_islem_tip = x"7" then -- Kiyasla
					if x_kaydedicisi(veri_genisligi-1 downto 0) = y_kaydedicisi then
						x_kaydedicisi <= (others => '0'); -- Sifir bayragi cekiliyor.
					elsif x_kaydedicisi < y_kaydedicisi then
						x_kaydedicisi(veri_genisligi) <= '1'; -- Elde bayragi cekiliyor.
					end if;
				end if;
			end if;
		end if;
	end process;

end Behavioral;

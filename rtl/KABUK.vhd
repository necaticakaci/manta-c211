-- Manta C211 Islemcisi - Ust Modul
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MANTA.ALL;

entity KABUK is
	port(	saat, reset		: in std_logic;
			giris			: in std_logic_vector(giris_port_genisligi-1 downto 0);
			cikis			: out std_logic_vector(cikis_port_genisligi-1 downto 0));
			
end KABUK;

architecture Behavioral of KABUK is

component PROGRAM_BELLEGI is
	port(	saat			: in std_logic;
			pb_oku			: in std_logic;
			pb_giris		: in std_logic_vector(adres_genisligi-1 downto 0);
			pb_cikis		: out std_logic_vector(buyruk_genisligi-1 downto 0));
end component;

component PROGRAM_SAYACI is
	port(	saat, reset		: in std_logic;
			ps_say			: in std_logic;
			ps_atla			: in std_logic;
			ps_giris 		: in std_logic_vector(adres_genisligi-1 downto 0);
			ps_cikis 		: out std_logic_vector(adres_genisligi-1 downto 0));
end component;

component BUYRUK_COZUCU is
	port(	saat, reset			: in std_logic;
			bc_oku				: in std_logic;
			bc_giris			: in std_logic_vector(buyruk_genisligi-1 downto 0);
			bc_sabit_cikis 		: out std_logic_vector(veri_genisligi-1 downto 0);
			bc_adres_cikis		: out std_logic_vector(adres_genisligi-1 downto 0);
			bc_kd0_cikis		: out std_logic_vector(3 downto 0);
			bc_kd1_cikis		: out std_logic_vector(3 downto 0);
			bc_buyruk			: out buyruk);
end component;

component KAYDEDICI_DOSYASI is
	port(	saat, reset				: in std_logic;
			kd_sabit_oku			: in std_logic;
			kd_sonuc_oku			: in std_logic;
			kd_port_oku				: in std_logic;
			kd_bellek_oku			: in std_logic;
			kd_yaz					: in std_logic;
			kd_ivedi				: in std_logic;
			kd_buyruk_sabit_giris	: in std_logic_vector(veri_genisligi-1 downto 0);
			kd_amb_sonuc_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			kd_gcb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			kd_vb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			kd_kd0_giris			: in std_logic_vector(3 downto 0);
			kd_kd1_giris			: in std_logic_vector(3 downto 0);
			kd_kd0_cikis			: out std_logic_vector(veri_genisligi-1 downto 0);
			kd_kd1_cikis			: out std_logic_vector(veri_genisligi-1 downto 0));
end component;

component ARITMETIK_MANTIK_BIRIMI is
	port(	saat, reset			: in std_logic;
			amb_oku				: in std_logic;
			amb_ivedi			: in std_logic;
			amb_isle			: in std_logic;
			amb_islem_tip		: in std_logic_vector(3 downto 0);
			amb_kd0_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			amb_kd1_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			amb_sabit_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			amb_bayrak_sifir	: out std_logic;
			amb_bayrak_elde		: out std_logic;
			amb_sonuc_cikis		: out std_logic_vector(veri_genisligi-1 downto 0));
end component;

component GIRIS_CIKIS_BIRIMI is
	port(	saat				: in std_logic;
			gcb_oku				: in std_logic;
			gcb_yaz				: in std_logic;
			gcb_ivedi			: in std_logic;
			gcb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			gcb_sabit_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			gcb_port_giris		: in std_logic_vector(giris_port_genisligi-1 downto 0); 
			gcb_veri_cikis		: out std_logic_vector(veri_genisligi-1 downto 0); 
			gcb_port_cikis		: out std_logic_vector(cikis_port_genisligi-1 downto 0));
end component;

component VERI_BELLEGI is
	port( 	saat 				: in std_logic;
			vb_oku				: in std_logic;
			vb_yaz				: in std_logic;
			vb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
			vb_adres_giris		: in std_logic_vector(vb_adres_genisligi-1 downto 0);
			vb_veri_cikis		: out std_logic_vector(veri_genisligi-1 downto 0));
end component;

component DENETIM_BIRIMI is
	port(	saat, reset			: in std_logic;
			db_bayrak_sifir		: in std_logic;
			db_bayrak_elde		: in std_logic;
			db_buyruk 			: in buyruk;
			db_pb_oku 			: out std_logic;
			db_bc_oku			: out std_logic;
			db_ps_say			: out std_logic;
			db_ps_atla			: out std_logic;
			db_kd_sabit_oku		: out std_logic;
			db_kd_sonuc_oku		: out std_logic;
			db_kd_port_oku		: out std_logic;
			db_kd_bellek_oku	: out std_logic;
			db_kd_yaz			: out std_logic;
			db_kd_ivedi			: out std_logic;
			db_amb_oku			: out std_logic;
			db_amb_ivedi		: out std_logic;
			db_amb_isle			: out std_logic;
			db_amb_islem_tip	: out std_logic_vector(3 downto 0);
			db_gcb_oku			: out std_logic;
			db_gcb_yaz			: out std_logic;
			db_gcb_ivedi		: out std_logic;
			db_vb_oku			: out std_logic;
			db_vb_yaz			: out std_logic);
end component;

-- Yollar

signal buyruk_adres_yolu		: std_logic_vector(adres_genisligi-1 downto 0);
signal buyruk_yolu				: std_logic_vector(buyruk_genisligi-1 downto 0);
signal adres_atlama_yolu		: std_logic_vector(adres_genisligi-1 downto 0);
signal buyruk_sabit_yolu		: std_logic_vector(veri_genisligi-1 downto 0);
signal amb_sonuc_yolu			: std_logic_vector(veri_genisligi-1 downto 0);
signal bc_kd0_yolu				: std_logic_vector(3 downto 0);
signal bc_kd1_yolu				: std_logic_vector(3 downto 0);
signal kd0_cikis_yolu			: std_logic_vector(veri_genisligi-1 downto 0);
signal kd1_cikis_yolu			: std_logic_vector(veri_genisligi-1 downto 0);
signal gcb_kd_yolu				: std_logic_vector(veri_genisligi-1 downto 0);
signal vb_kd_yolu				: std_logic_vector(veri_genisligi-1 downto 0);

signal denetim_pb_oku			: std_logic;
signal denetim_ps_say			: std_logic;
signal denetim_ps_atla			: std_logic;
signal denetim_bc_oku			: std_logic;
signal denetim_kd_sabit_oku		: std_logic;
signal denetim_kd_sonuc_oku		: std_logic;
signal denetim_kd_port_oku		: std_logic;
signal denetim_kd_bellek_oku	: std_logic;
signal denetim_kd_yaz			: std_logic;
signal denetim_kd_ivedi			: std_logic;
signal denetim_amb_oku			: std_logic;
signal denetim_amb_ivedi		: std_logic;
signal denetim_amb_isle			: std_logic;
signal denetim_amb_islem_tip	: std_logic_vector(3 downto 0);
signal denetim_gcb_oku			: std_logic;
signal denetim_gcb_yaz			: std_logic;
signal denetim_gcb_ivedi		: std_logic;
signal denetim_vb_oku			: std_logic;
signal denetim_vb_yaz			: std_logic;
signal denetim_bayrak_sifir		: std_logic;
signal denetim_bayrak_elde		: std_logic;
signal denetim_buyruk			: buyruk;

begin

pb1 : PROGRAM_BELLEGI
port map(	saat 			=> saat,
			pb_oku 			=> denetim_pb_oku,
			pb_giris 		=> buyruk_adres_yolu,
			pb_cikis 		=> buyruk_yolu);

ps1 : PROGRAM_SAYACI
port map(	saat			=> saat,
			reset 			=> reset,
			ps_say 			=> denetim_ps_say,
			ps_atla			=> denetim_ps_atla,
			ps_giris 		=> adres_atlama_yolu,
			ps_cikis 		=> buyruk_adres_yolu);

bc1 : BUYRUK_COZUCU
port map(	saat			=> saat,
			reset			=> reset,
			bc_oku 			=> denetim_bc_oku,
			bc_giris		=> buyruk_yolu,
			bc_sabit_cikis 	=> buyruk_sabit_yolu,
			bc_adres_cikis 	=> adres_atlama_yolu,
			bc_kd0_cikis 	=> bc_kd0_yolu, 
			bc_kd1_cikis 	=> bc_kd1_yolu, 
			bc_buyruk 		=> denetim_buyruk);

kd1 : KAYDEDICI_DOSYASI
port map(	saat					=> saat,	
			reset					=> reset,			
			kd_sabit_oku			=> denetim_kd_sabit_oku,
			kd_sonuc_oku			=> denetim_kd_sonuc_oku,
			kd_port_oku				=> denetim_kd_port_oku,
			kd_bellek_oku			=> denetim_kd_bellek_oku,
			kd_yaz					=> denetim_kd_yaz,
			kd_ivedi				=> denetim_kd_ivedi,
			kd_buyruk_sabit_giris	=> buyruk_sabit_yolu,
			kd_amb_sonuc_giris		=> amb_sonuc_yolu,
			kd_gcb_veri_giris		=> gcb_kd_yolu,
			kd_vb_veri_giris		=> vb_kd_yolu,
			kd_kd0_giris			=> bc_kd0_yolu,
			kd_kd1_giris			=> bc_kd1_yolu,
			kd_kd0_cikis			=> kd0_cikis_yolu,
			kd_kd1_cikis			=> kd1_cikis_yolu);

amb1 : ARITMETIK_MANTIK_BIRIMI
port map(	saat				=> saat,
			reset				=> reset,
			amb_oku				=> denetim_amb_oku,
			amb_ivedi			=> denetim_amb_ivedi,
			amb_isle			=> denetim_amb_isle,
			amb_islem_tip		=> denetim_amb_islem_tip,
			amb_kd0_giris		=> kd0_cikis_yolu,
			amb_kd1_giris		=> kd1_cikis_yolu,
			amb_sabit_giris		=> buyruk_sabit_yolu,
			amb_bayrak_sifir	=> denetim_bayrak_sifir,
			amb_bayrak_elde		=> denetim_bayrak_elde,
			amb_sonuc_cikis		=> amb_sonuc_yolu);
				
gcb1 : GIRIS_CIKIS_BIRIMI
port map(	saat				=> saat,
			gcb_oku				=> denetim_gcb_oku,
			gcb_yaz				=> denetim_gcb_yaz,
			gcb_ivedi			=> denetim_gcb_ivedi,
			gcb_veri_giris 		=> kd0_cikis_yolu,
			gcb_sabit_giris		=> buyruk_sabit_yolu,
			gcb_port_giris		=> giris,
			gcb_veri_cikis		=> gcb_kd_yolu,
			gcb_port_cikis		=> cikis);

vb1 : VERI_BELLEGI
port map(	saat				=> saat,
			vb_oku				=> denetim_vb_oku,
			vb_yaz				=> denetim_vb_yaz,
			vb_veri_giris		=> kd0_cikis_yolu,
			vb_adres_giris		=> kd1_cikis_yolu,
			vb_veri_cikis		=> vb_kd_yolu);
				
db1 : DENETIM_BIRIMI
port map(	saat				=> saat,
			reset 				=> reset,
			db_bayrak_sifir		=> denetim_bayrak_sifir,
			db_bayrak_elde		=> denetim_bayrak_elde,
			db_buyruk 			=> denetim_buyruk,
			db_pb_oku 			=> denetim_pb_oku,
			db_bc_oku 			=> denetim_bc_oku,
			db_ps_say			=> denetim_ps_say,
			db_ps_atla			=> denetim_ps_atla,
			db_kd_sabit_oku		=> denetim_kd_sabit_oku,
			db_kd_sonuc_oku		=> denetim_kd_sonuc_oku,
			db_kd_port_oku		=> denetim_kd_port_oku,
			db_kd_bellek_oku	=> denetim_kd_bellek_oku,
			db_kd_yaz			=> denetim_kd_yaz,
            db_kd_ivedi 		=> denetim_kd_ivedi,
			db_amb_oku			=> denetim_amb_oku,
			db_amb_ivedi		=> denetim_amb_ivedi,
			db_amb_isle			=> denetim_amb_isle,
			db_amb_islem_tip	=> denetim_amb_islem_tip,
			db_gcb_oku			=> denetim_gcb_oku,
			db_gcb_yaz			=> denetim_gcb_yaz,
			db_gcb_ivedi		=> denetim_gcb_ivedi,
			db_vb_oku			=> denetim_vb_oku,
			db_vb_yaz			=> denetim_vb_yaz);
				
end Behavioral;

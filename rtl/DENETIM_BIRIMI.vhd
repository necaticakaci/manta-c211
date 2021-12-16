-- Manta C211 Islemcisi - Denetim Birimi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MANTA.ALL;

entity DENETIM_BIRIMI is
	port(	saat, reset		: in std_logic;
		db_bayrak_sifir		: in std_logic;
		db_bayrak_elde		: in std_logic;
		db_buyruk 		: in buyruk;
		db_pb_oku 		: out std_logic;
		db_bc_oku		: out std_logic;
		db_ps_say		: out std_logic;
		db_ps_atla		: out std_logic;
		db_kd_sabit_oku		: out std_logic;
		db_kd_sonuc_oku		: out std_logic;
		db_kd_port_oku		: out std_logic;
		db_kd_bellek_oku	: out std_logic;
		db_kd_yaz		: out std_logic;
		db_kd_ivedi		: out std_logic;
		db_amb_oku		: out std_logic;
		db_amb_ivedi		: out std_logic;
		db_amb_isle		: out std_logic;
		db_amb_islem_tip	: out std_logic_vector(3 downto 0);
		db_gcb_oku		: out std_logic;
		db_gcb_yaz		: out std_logic;
		db_gcb_ivedi		: out std_logic;
		db_vb_oku		: out std_logic;
		db_vb_yaz		: out std_logic);
			
end DENETIM_BIRIMI;

architecture Behavioral of DENETIM_BIRIMI is
	type durum is (	S0, S01, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, 
			S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, 
			S23, S24, S25, S26, S27, S28, S29, S30, S31, S32, S33, 
			S34, S35, S36, S37, S38, S39, S40, S41, S42, S43, S44, 
			S45, S46, S47, S48, S49, S50);
	signal simdiki_durum, sonraki_durum : durum;
begin

	ana_dongu : process(saat, reset) begin
		if reset = '1' then
			simdiki_durum <= S0;
		elsif rising_edge(saat) then
			simdiki_durum <= sonraki_durum;
		end if;
	end process ana_dongu;
	
	islem_dongusu : process(simdiki_durum, db_buyruk, db_bayrak_sifir, db_bayrak_elde) is begin
		db_pb_oku 		<= '0';
		db_bc_oku 		<= '0';
		db_ps_say		<= '0';
		db_ps_atla		<= '0';
		db_kd_sabit_oku		<= '0';	
		db_kd_sonuc_oku		<= '0';
		db_kd_port_oku		<= '0';
		db_kd_bellek_oku	<= '0';
		db_kd_yaz		<= '0';	
		db_kd_ivedi		<= '0';
		db_amb_oku		<= '0';
		db_amb_ivedi		<= '0';
		db_amb_isle		<= '0';
		db_amb_islem_tip	<= x"0";
		db_gcb_oku		<= '0';
		db_gcb_yaz		<= '0';
		db_gcb_ivedi		<= '0';
		db_vb_oku		<= '0';
		db_vb_yaz		<= '0';
		
		case simdiki_durum is
			when S0 =>
				db_pb_oku <= '1';
				sonraki_durum <= S01;
				
			when S01 =>
				db_bc_oku <= '1';
				db_ps_say <= '1';
				sonraki_durum <= S1;
				
			when S1 =>
				if db_buyruk = YUKLE then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S2;
				elsif db_buyruk = IYUKLE then
					db_kd_sabit_oku <= '1';
					db_kd_ivedi <= '1';
					sonraki_durum <= S2;
				elsif db_buyruk = TOPLA then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S3;
				elsif db_buyruk = ITOPLA then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S7;
				elsif db_buyruk = CIKIS then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S11;
				elsif db_buyruk = GIRIS then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S12;
				elsif db_buyruk = CIKAR then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S15;
				elsif db_buyruk = ICIKAR then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S19;
				elsif db_buyruk = ICIKIS then
					db_gcb_ivedi <= '1'; -- ICIKIS
					db_gcb_yaz <= '1';
					sonraki_durum <= S0;
				elsif db_buyruk = VE then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S23;
				elsif db_buyruk = VEYA then
					db_kd_sabit_oku <= '1'; 
					sonraki_durum <= S27;
				elsif db_buyruk = ZOR then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S31;
				elsif db_buyruk = SAGKAYDIR then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S35;
				elsif db_buyruk = SOLKAYDIR then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S39;
				elsif db_buyruk = KIYASLA then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S43;
				elsif db_buyruk = IKIYASLA then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S45;
				elsif db_buyruk = ATLA then
					db_ps_atla <= '1'; -- ATLA
					sonraki_durum <= S0;
				elsif db_buyruk = ATLAS then
					if db_bayrak_sifir = '1' then -- ATLAS
						db_ps_atla <= '1';
						sonraki_durum <= S0;
					else
						sonraki_durum <= S0;
					end if;
				elsif db_buyruk = ATLAE then
					if db_bayrak_elde = '1' then -- ATLAE
						db_ps_atla <= '1';
						sonraki_durum <= S0;
					else
						sonraki_durum <= S0;
					end if;
				elsif db_buyruk = YAZ then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S47;
				elsif db_buyruk = OKU then
					db_kd_sabit_oku <= '1';
					sonraki_durum <= S48;
				else 
					sonraki_durum <= S0;
				end if;
			
			when S2 => -- YUKLE, IYUKLE
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S3 => 
				db_amb_oku <= '1'; 
				sonraki_durum <= S4;
			when S4 => 
				db_amb_islem_tip <= x"0";
				db_amb_isle <= '1';
				sonraki_durum <= S5;
			when S5 => 
				db_kd_sonuc_oku <= '1'; 
				sonraki_durum <= S6;
			when S6 => -- TOPLA
				db_kd_yaz <= '1';
				sonraki_Durum <= S0;
				
			when S7 =>
				db_amb_ivedi <= '1';
				db_amb_oku <= '1';
				sonraki_durum <= S8;
			when S8 =>
				db_amb_islem_tip <= x"0";
				db_amb_isle <= '1';
				sonraki_durum <= S9;
			when S9 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S10;
			when S10 => -- ITOPLA
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S11 => -- CIKIS
				db_gcb_yaz <= '1';
				sonraki_durum <= S0;
				
			when S12 =>
				db_gcb_oku <= '1';
				sonraki_durum <= S13;
			when S13 =>
				db_kd_port_oku <= '1';
				sonraki_durum <= S14;
			when S14 => -- GIRIS
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S15 =>
				db_amb_oku <= '1';
				sonraki_durum <= S16;
			when S16 =>
				db_amb_islem_tip <= x"1";
				db_amb_isle <= '1';
				sonraki_durum <= S17;
			when S17 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S18;
			when S18 => -- CIKAR
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S19 =>
				db_amb_ivedi <= '1';
				db_amb_oku <= '1';
				sonraki_durum <= S20;
			when S20 =>
				db_amb_islem_tip <= x"1";
				db_amb_isle <= '1';
				sonraki_durum <= S21;
			when S21 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S22;
			when S22 => -- ICIKAR
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S23 =>
				db_amb_oku <= '1';
				sonraki_durum <= S24;
			when S24 =>
				db_amb_islem_tip <= x"2";
				db_amb_isle <= '1';
				sonraki_durum <= S25;
			when S25 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S26;
			when S26 => -- VE
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S27 =>
				db_amb_oku <= '1';
				sonraki_durum <= S28;
			when S28 =>
				db_amb_islem_tip <= x"3";
				db_amb_isle <= '1';
				sonraki_durum <= S29;
			when S29 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S30;
			when S30 => -- VEYA
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S31 =>
				db_amb_oku <= '1';
				sonraki_durum <= S32;
			when S32 =>
				db_amb_islem_tip <= x"4";
				db_amb_isle <= '1';
				sonraki_durum <= S33;
			when S33 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S34;
			when S34 => -- XOR
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S35 =>
				db_amb_oku <= '1';
				sonraki_durum <= S36;
			when S36 =>
				db_amb_islem_tip <= x"5";
				db_amb_isle <= '1';
				sonraki_durum <= S37;
			when S37 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S38;
			when S38 => -- SAGKAYDIR
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S39 =>
				db_amb_oku <= '1';
				sonraki_durum <= S40;
			when S40 =>
				db_amb_islem_tip <= x"6";
				db_amb_isle <= '1';
				sonraki_durum <= S41;
			when S41 =>
				db_kd_sonuc_oku <= '1';
				sonraki_durum <= S42;
			when S42 => -- SOLKAYDIR
				db_kd_yaz <= '1';
				sonraki_durum <= S0;
				
			when S43 =>
				db_amb_oku <= '1';
				sonraki_durum <= S44;
			when S44 => -- KIYASLA
				db_amb_islem_tip <= x"7";
				db_amb_isle <= '1';
				sonraki_durum <= S0;
				
			when S45 =>
				db_amb_ivedi <= '1';
				db_amb_oku <= '1';
				sonraki_durum <= S46;
			when S46 => -- IKIYASLA
				db_amb_islem_tip <= x"7";
				db_amb_isle <= '1';
				sonraki_durum <= S0;
				
			when S47 => -- YAZ
				db_vb_yaz <= '1';
				sonraki_durum <= S0;
				
			when S48 =>
				db_vb_oku <= '1';
				sonraki_durum <= S49;
			when S49 =>
				db_kd_bellek_oku <= '1';
				sonraki_durum <= S50;
			when S50 => -- OKU
				db_kd_yaz <= '1';
				sonraki_durum <= S0;

		end case;
	end process islem_dongusu;

end Behavioral;

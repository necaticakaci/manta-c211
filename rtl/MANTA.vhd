-- Manta C211 Islemcisi - Tanimlar ve Sabitler
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package MANTA is

constant veri_genisligi				: integer := 8;
constant adres_genisligi			: integer := 10;
constant vb_adres_genisligi			: integer := 8;
constant buyruk_genisligi			: integer := 18;
constant kaydedici_sayisi			: integer := 16;
constant program_bellegi_genisligi		: integer := 1024;
constant veri_bellegi_genisligi			: integer := 256;
constant giris_port_genisligi			: integer := 8;
constant cikis_port_genisligi			: integer := 8;

type buyruk is (YUKLE, IYUKLE, TOPLA, ITOPLA, ICIKIS, CIKIS, CIKAR,
		ICIKAR, KIYASLA, IKIYASLA, ATLA, ATLAS, VE, VEYA, 
		ZOR, GIRIS, YAZ, OKU, ATLAE, SAGKAYDIR, SOLKAYDIR);
function coz(kod : std_logic_vector) return buyruk;

end MANTA;

package body MANTA is
	function coz(kod : std_logic_vector) return buyruk is
		variable cozulen_buyruk : buyruk;
	begin
		case kod(buyruk_genisligi-1 downto 12) is
			when	"000001" 	=> cozulen_buyruk := YUKLE; 
			when	"000010" 	=> cozulen_buyruk := IYUKLE; 
			when	"000011"	=> cozulen_buyruk := TOPLA; 
			when 	"000100"	=> cozulen_buyruk := ITOPLA; 
			when	"000101"	=> cozulen_buyruk := ICIKIS;
			when	"000110"	=> cozulen_buyruk := CIKIS;
			when	"000111"	=> cozulen_buyruk := CIKAR;
			when	"001000"	=> cozulen_buyruk := ICIKAR; 
			when	"001001"	=> cozulen_buyruk := KIYASLA; 
			when	"001010"	=> cozulen_buyruk := IKIYASLA; 
			when	"001011"	=> cozulen_buyruk := ATLA; 
			when	"001100"	=> cozulen_buyruk := ATLAS; 
			when	"001101"	=> cozulen_buyruk := VE; 
			when	"001110"	=> cozulen_buyruk := VEYA; 
			when	"001111"	=> cozulen_buyruk := ZOR; 
			when	"010000"	=> cozulen_buyruk := GIRIS; 
			when	"010001"	=> cozulen_buyruk := YAZ; 
			when	"010010"	=> cozulen_buyruk := OKU; 
			when	"010011"	=> cozulen_buyruk := ATLAE; 
			when	"010100"	=> cozulen_buyruk := SAGKAYDIR;
			when	"010101"	=> cozulen_buyruk := SOLKAYDIR;
			when	others => null;
		end case;
		return cozulen_buyruk;
	end function coz;
end MANTA;

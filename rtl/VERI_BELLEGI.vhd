-- Manta C211 Islemcisi - Veri Bellegi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MANTA.ALL;

entity VERI_BELLEGI is
	port( 	saat 			: in std_logic;
		vb_oku			: in std_logic;
		vb_yaz			: in std_logic;
		vb_veri_giris		: in std_logic_vector(veri_genisligi-1 downto 0);
		vb_adres_giris		: in std_logic_vector(vb_adres_genisligi-1 downto 0);
		vb_veri_cikis		: out std_logic_vector(veri_genisligi-1 downto 0));
			
end VERI_BELLEGI;

architecture Behavioral of VERI_BELLEGI is
	type bellek_tipi is array (0 to veri_bellegi_genisligi-1) of std_logic_vector(veri_genisligi-1 downto 0);
	signal bellek : bellek_tipi := (others => (others => '0'));
begin

	process(saat)
	begin
		if rising_edge(saat) then
			if vb_yaz = '1' then
				bellek(conv_integer(vb_adres_giris)) <= vb_veri_giris;
			elsif vb_oku = '1' then
				vb_veri_cikis <= bellek(conv_integer(vb_adres_giris));
			end if;
		end if;
	end process;

end Behavioral;

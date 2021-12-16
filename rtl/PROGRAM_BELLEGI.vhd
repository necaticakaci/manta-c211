-- Manta C211 Islemcisi - Program Bellegi
-- 2021
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use WORK.MANTA.ALL;

entity PROGRAM_BELLEGI is
	port(	saat			: in std_logic;
		pb_oku			: in std_logic;
		pb_giris		: in std_logic_vector(adres_genisligi-1 downto 0);
		pb_cikis		: out std_logic_vector(buyruk_genisligi-1 downto 0));

end PROGRAM_BELLEGI;

architecture Behavioral of PROGRAM_BELLEGI is
	signal veri_kaydedicisi : std_logic_vector(buyruk_genisligi-1 downto 0) := (others => '0');
	type bellek_tipi is array (0 to program_bellegi_genisligi-1) of std_logic_vector(buyruk_genisligi-1 downto 0);
	signal bellek : bellek_tipi := (
		0 	=> "000010000011111111",
		1 	=> "010000001000000000",
		2 	=> "001111001000000000",
		3	=> "000110001000000000",
		4	=> "001011000000000100",
		others => (others => '0'));
begin

pb_cikis <= veri_kaydedicisi; --!!

	process(saat)
	begin
		if rising_edge(saat) then
			if pb_oku = '1' then
				veri_kaydedicisi <= bellek(conv_integer(pb_giris));
			end if;
		end if;
	end process;

end Behavioral;

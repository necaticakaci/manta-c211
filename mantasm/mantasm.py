# MANTASM - Manta Assembler Sürüm 0.7.2
# 2021
import sys
from pathlib import Path

buyrukListesi = ["YÜKLE", "İYÜKLE", "TOPLA", "İTOPLA", "İÇIKIŞ", "ÇIKIŞ",
                 "ÇIKAR", "İÇIKAR", "KIYASLA", "İKIYASLA", "ATLA", "ATLAS",
                 "VE", "VEYA", "XOR", "GİRİŞ", "YAZ", "OKU", 
                 "ATLAE", "SAĞKAYDIR", "SOLKAYDIR", "TEMİZLE", "ARTIR", "AZALT",
                 "GEÇ", "SONLANDIR"]

# 0: ZX ZY      BBBBBBXXXXYYYYOOOO
# 1: ZX 0x00    BBBBBBXXXXIIIIIIII
# 2: 0x000      BBBBBBIIIIIIIIIIOO
# 3: ZX         BBBBBBXXXXOOOOOOOO
# 4: 0x00       BBBBBBOOOOIIIIIIII
# 5: Temizle, 6: Artır - Azalt, 7: Geç, 8: Sonlandır

# B: Buyruk Kodu, X: ZX Kaydedicisi, Y: ZY Kaydedicisi, O: Önemsiz, I: Sabit

buyruktipListesi = [0, 1, 0, 1, 4, 3, 0, 1, 0, 1, 2, 2,
                    0, 0, 0, 3, 0, 0, 2, 0, 0, 5, 6, 6,
                    7, 8]

buyrukDeğer = ["000001", "000010", "000011", "000100", "000101", "000110",
               "000111", "001000", "001001", "001010", "001011", "001100",
               "001101", "001110", "001111", "010000", "010001", "010010",
               "010011", "010100", "010101", "000010", "000100", "001000",
               "000001", "001011"]

kaydediciListesi = ["Z0", "Z1", "Z2", "Z3", "Z4", "Z5",
                    "Z6", "Z7", "Z8", "Z9", "ZA", "ZB", 
                    "ZC", "ZD", "ZE", "ZF"]

kaydediciDeğer = ["0000", "0001", "0010", "0011", "0100", "0101",
                  "0110", "0111", "1000", "1001", "1010", "1011",
                  "1100", "1101", "1110", "1111"]

satırNumarası = 1 # Okunan dosyanın geçerli satır numarasını tutan değişken tanımlanıyor.
buyrukTipi = 0 # 0 kaydedici buyruk tipi, 1 ivedi buyruk tipi, 2 adres buyruk tipi, 3 tek kaydedicili buyruk tipi, 4 tek sabitli buyruk tipi. 
buyrukSayısı = 0x000 # Progamda bulunan buyruk sayısını sayan değişken. 
hata = False

def buyrukÇevir(buyruk):
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    indeks = buyrukListesi.index(buyruk) # Buyruğun listedeki kaçıncı eleman olduğu öğreniliyor.
    dosyaÇıkış.write(buyrukDeğer[indeks]) # Değer tablosuna göre çevriliyor.
    dosyaÇıkış.close()

def kaydediciÇevir(kaydedici):
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    indeks = kaydediciListesi.index(kaydedici)
    dosyaÇıkış.write(kaydediciDeğer[indeks])
    dosyaÇıkış.close()

def değerÇevir(değer):
    global hata
    çevrilenDeğer = int(değer,16)
    if (çevrilenDeğer > 255): # !
        print("Çevirici bir hatayla karşılaştı. (120)\nSatır {0}, Sabit {1} değeri 0xFF sayısndan büyük olamaz.".format(int(satırNumarası), satır[2])) 
        hata = True
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    dosyaÇıkış.write(str('{0:08b}'.format(çevrilenDeğer)))
    dosyaÇıkış.close()

def adresÇevir(adres):
    global hata
    çevrilenAdres = int(adres, 16)
    if (çevrilenAdres > 1023): # !
        print("Çevirici bir hatayla karşılaştı. (130)\nSatır {0}, Program belleği adresi {1}, 0x3FF sayısından büyük olamaz.".format(int(satırNumarası), satır[1]))     
        hata = True
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    dosyaÇıkış.write(str('{0:010b}'.format(çevrilenAdres)))
    dosyaÇıkış.close()

def sıfırEkle(çarpan):
    sıfırlar = "0" * çarpan
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    dosyaÇıkış.write(sıfırlar)
    dosyaÇıkış.close()

def satırSonlandır():
    global buyrukSayısı
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8')
    dosyaÇıkış.write("\n")
    buyrukSayısı += 1

def tipBul(buyruk):
    indeks = buyrukListesi.index(buyruk)
    return buyruktipListesi[indeks]

def kaydediciHatası(satır, kaydedici):
    print("Çevirici bir hatayla karşılaştı. (110)\nSatır {0}, Geçersiz kaydedici ismi: {1}".format(int(satır), kaydedici))

if len(sys.argv) != 2: 
    print ("Kullanım: MANTASM [dosya yolu]dosya ismi") 
    sys.exit()

print("\n   __  ______   _  ___________   ______  ___\n  /  |/  / _ | / |/ /_  __/ _ | / __/  |/  /\n / /|_/ / __ |/    / / / / __ |_\ \/ /|_/ / \n/_/  /_/_/ |_/_/|_/ /_/ /_/ |_/___/_/  /_/  \n")
print("MANTA ASSEMBLER Sürüm 0.7.2\nİşlem başlatılıyor...")

try:
    dosyaGiriş = open(sys.argv[1], 'r', encoding = 'utf8') # Manta Assembly dosyası
    okunan = dosyaGiriş.read()
except:
    print("Çevirici bir hatayla karşılaştı. (80)\n{0} dosyası okunamadı.\nİşlem başarısız.".format(sys.argv[1]))
    sys.exit()

dosyaİsmi = sys.argv[1]
yenidosya = Path(dosyaİsmi).stem + ".mpd"

try:
    dosyaÇıkış = open(yenidosya, 'a', encoding = 'utf8') # Manta program dosyası
    dosyaÇıkış.close()
except:
    print("Çevirici bir hatayla karşılaştı. (90)\n{0} dosyası oluşturulamadı.\nİşlem başarısız.".format(yenidosya))
    sys.exit()

bölünmüş = okunan.split("\n") # Satırlar ayrılıyor.

for i in range(0, len(bölünmüş)):
    satır = bölünmüş[i].split() # \n'e kadar çalışacak. 
    if len(satır) > 0:
        if satır[0] in buyrukListesi: # Buyruk bulundu.
            #print("-Rastlanan buyruk: %s" %(satır[0]))
            buyrukÇevir(satır[0])
            buyrukTipi = tipBul(satır[0])
            if buyrukTipi == 0: # ZX, ZY
                if satır[1] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[1]))
                    kaydediciÇevir(satır[1])
                else:
                    kaydediciHatası(satırNumarası, satır[1])
                    hata = True
                    break
                if satır[2] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[2]))
                    kaydediciÇevir(satır[2])
                    sıfırEkle(4)
                    satırSonlandır()
                else:
                    kaydediciHatası(satırNumarası, satır[2])
                    hata = True
                    break
                
            elif buyrukTipi == 1: # ZX, 0x00
                if satır[1] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[1]))
                    kaydediciÇevir(satır[1])
                else:
                    kaydediciHatası(satırNumarası, satır[1])
                    hata = True
                    break
                #print("-Rastlanan değer: %s" %(satır[2]))
                değerÇevir(satır[2])
                if hata == True:
                    break
                satırSonlandır()
                
            elif buyrukTipi == 2: # 0x000
                #print("-Rastlanan adres: %s"%(satır[1]))
                adresÇevir(satır[1])
                if hata == True:
                    break
                sıfırEkle(2)
                satırSonlandır()
                
            elif buyrukTipi == 3: # 0xZX
                if satır[1] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[1]))
                    kaydediciÇevir(satır[1])
                    sıfırEkle(8)
                    satırSonlandır()
                else:
                    kaydediciHatası(satırNumarası, satır[1])
                    hata = True
                    break
                
            elif buyrukTipi == 4: # 0x00
                sıfırEkle(4)
                değerÇevir(satır[1])
                if hata == True:
                    break
                satırSonlandır()

            elif buyrukTipi == 5: # Temizle sözde buyruğu
                if satır[1] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[1]))
                    kaydediciÇevir(satır[1])
                    değerÇevir("0x00")
                    if hata == True:
                        break
                    satırSonlandır()
                else:
                    kaydediciHatası(satırNumarası, satır[1])
                    hata = True
                    break
                
            elif buyrukTipi == 6: # Artır - Azalt sözde buyruğu
                if satır[1] in kaydediciListesi:
                    #print("-Rastlanan kaydedici: %s" %(satır[1]))
                    kaydediciÇevir(satır[1])
                else:
                    kaydediciHatası(satırNumarası, satır[1])
                    hata = True
                    break
                değerÇevir("0x01")
                if hata == True:
                    break
                satırSonlandır()

            elif buyrukTipi == 7: # Geç sözde buyruğu
                sıfırEkle(12)
                satırSonlandır()

            elif buyrukTipi == 8: # Sonlandır sözde buyruğu
                adresÇevir(str(buyrukSayısı + 1))
                sıfırEkle(2)
                satırSonlandır()
                buyrukÇevir("ATLA")
                adresÇevir(str(buyrukSayısı - 1))
                sıfırEkle(2)
                satırSonlandır()

        elif satır[0] == "*": # Yorum karakteri okundu ise.
            pass

        else: # Okunan karakter, buyruk listesinde yok ise.
            print("Çevirici bir hatayla karşılaştı. (100)\nSatır {0}, Beklenmeyen ifade: {1}".format(int(satırNumarası), satır[0]))
            hata = True
            break
    else:
        pass
    satırNumarası += 1

if hata == True:
    print("İşlem başarısız.")
else:
    if buyrukSayısı <= 1024:
        kaplananAlan = (100 * buyrukSayısı) / 1024
        kaplananAlan = round(kaplananAlan, 2)
        print("Program belleğinin %{0} kadarı kullanıldı.".format(kaplananAlan))
    else:
        print("Uyarı: Program belleği kapasitesi aşıldı.")
    print("Çevirme işlemi tamamlandı.")

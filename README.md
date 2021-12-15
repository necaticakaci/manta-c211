# Manta C211 8-Bit Sentezlenebilir İşlemci

<p align="left">
  <img src="./img/manta.png" alt="Manta Logo"  width="256" height="65">
</p>

**Manta C211** VHDL ile yazılmış, çok vuruşlu, 8-bit bir işlemci projesidir. 256 bayt veri belleği, 16 adet genel amaçlı kaydedici ve 1024 buyruk kapasiteli program belleğine sahiptir. Buyruk kümesi 21 buyruktan oluşmaktadır ve her buyruk kodu 18 bit genişliktedir. **Manta C211**, Cyclone IV EP4CE6E22C8 için sentezlendiğinde FPGA'in lojik elemanlarının yaklaşık %7'sini kullanmaktadır.

## MANTASM

[MANTASM](/mantasm), **Manta C211** işlemcisi için yazılan assembly kodunu makine diline çeviren bir python script'idir. Uçbirim üzerinde `python mantasm.py dosya_adı.msm` komutu ile makine dili çevirme işlemi gerçekleştirilebilir. Bu komutun ardından aynı dizin içerisinde, çevrilen programın bit dizilerini barındıran `dosya_adı.mpd` şeklinde bir dosya üretilecektir. Üretilen `.mpd` uzantılı dosyalar düz metin formatındadır ve içerdiği makine kodu sentezleme işleminden önce [program belleğine](/rtl/PROGRAM_BELLEGI.vhd) gömülmelidir.

Örnek assembly kodu aşağıda verilmiştir:

```
İYÜKLE Z0 0xFF  * Z0 = 0xFF
* "*" YORUM KARAKTERİDİR.
* BU SATIR ÇEVİRİCİ TARAFINDAN ÖNEMSENMEZ.
GİRİŞ Z2
XOR Z2 Z0   * Z2 = Z2 XOR Z0
ÇIKIŞ Z2
ATLA 0x001
```

[Program](/program) dizini altında daha fazla örnek bulunmaktadır.

---

## Kaynak Tüketimi

Tasarım, Quartus Prime 18.1 yazılımı ile, Storm IV isimli geliştirme kartında bulunan Cyclone IV EP4CE6E22C8 FPGA için sentezlenmiştir.

| Kaynak            | Kullanılan  | Toplam      |
| ----------------- | ----------- | ----------- |
| Lojik Eleman (LE) | 427         | 6,272       |
| Kaydedici         | 247         | 6,272       |
| Giriş-Çıkış Pini  | 18          | 92          |
| Hafıza Biti       | 20,736      | 276,480     |

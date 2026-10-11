# HF3 - Fájlrendszer, jogosultságok, átirányítás

A feladatot egy olyan tesztkönyvtárral ellenőriztem, amely tartalmazott különböző kiterjesztésű (.txt, .jpg, .sh) fájlokat, szóközöket tartalmazó fájlneveket, 30 napnál régebbi állományokat, üres fájlokat, valamint mindenki számára írható (777-es jogú) fájlokat is.

## Példakimenet a script futtatásáról:

=== JELENTÉS: /home/user/tesztmappa ===
Fájlok száma: 12, Könyvtárak száma: 3

Az 5 legnagyobb fájl:
4.0K    /home/user/tesztmappa/nagy_kep.jpg
0       /home/user/tesztmappa/ures_fajl.txt

30 napnál régebben módosított fájlok száma: 2

Üres fájlok listája:
/home/user/tesztmappa/ures_fajl.txt

Kiterjesztés-statisztika:
   5 .txt
   4 .jpg
   3 .sh

Mindenki számára írható fájlok:
/home/user/tesztmappa/veszelyes.sh

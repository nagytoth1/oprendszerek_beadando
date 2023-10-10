## Korszerű operációs rendszerek

<center><h2> Linux fájlszerver központi felhasználó kezeléssel, webszolgáltatás honlappal, levelezés</h2></center>

## Tervezés

### 1. Internetszolgáltatás
A Magyarországon üzemelő internetszolgáltatók közötti választási lehetőségeket az iskola elhelyezkedése korlátozza. Ennek megfelelően két internetszolgáltatót találtunk, akiknek a környéken lefedettségük van.

A lehetőségek a következők:
Szolgáltató | Csomag | Garantált letöltési sebesség | Garantált feltöltési sebesség | Bruttó havidíj | Saját beüzemelési lehetőség | elektronikus számla (e-Pack kedvezmény)
------------|---------|------|------|-----|-----|----
Vodafone | Internet 150  | 105 Mbit/s | 7 Mbit/s | 3000 Ft/hó | van | igen
Vodafone | Internet 300  | 210 Mbit/s | 14 Mbit/s | 5000 Ft/hó | van | igen
Digi | DIGINet Növekedés 100 | 90 Mbit/s | 60 Mbit/s | 5040 Ft/hó | nincs | igen
Digi | DIGINet Növekedés 500  | 300 Mbit/s | 100 Mbit/s | 6230 Ft/hó | nincs | igen

A szolgáltató által bevezetett internetes kábelt ajánlott egy WiFi-szórásra egyaránt képes router eszközhöz csatlakoztatni, így a vezetékes hálózat mellett a vezeték nélküli hálózatot is kiépíthetünk az iskolában, amennyiben erre igény van. A vezeték nélküli hálózat lefedettsége azonban korlátozott, az előbb ismertetett Mikrotik router esetében 10 méter. Ahhoz, hogy a teljes iskola épületét lefedjük, szükség lehet bizonyos helyiségben lehetőleg szintén Mikrotik márkájú jelismétlőket, hozzáférési pontokat kihelyezni, hogy az iskola legtöbb pontján stabil jelerősséget és internetelérést kapjunk.

A fenti táblázat alapján részünkről a második lehetőség optimális lehet, ez név szerint a Vodafone Internet 300-as csomagja.

### 2. Router típusának kiválasztása

Routerre azért van szükségünk, hogy az iskolai belső hálózatot az internetre csatlakoztassuk. Amennyiben egy géptermet vagy egy másik hálózati egységet szeretnénk leválasztani az internetről, természetesen erre is lehetőséget biztosít egy router. 

A választott internetszolgáltató alapértelmezés szerint biztosítana router eszközt, de ezt érdemes lemondani, mi fogjuk biztosítani ezt az eszközt.

Jelenlegi raktárkészletünknek megfelelően az alábbi eszközök közül tudnak választani:
| Router márkája | Előnyei                                                                                                          | Hátrányai                                                                                                                                                                                       |
| -------------- | ---------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Cisco          | felsőbb árkategória, ipari szabvány, rengeteg leírás található a beállításához, jelentős felhasználói bázisa van | drága, inkább nagyvállalati környezetben ajánlatos telepíteni, beállítása parancssori alkalmazáson keresztül történik, telepítése, üzemeltetése ebből fakadóan külön erre specializált szakértelmet igényel |
| Mikrotik       | megfizethetőbb vállalati megoldások, kis- és középvállalati felhasználásra alkalmas, beállítása nem igényel akkora szaktudást                                                 |                     nagyszabású hálózati felépítéshez nem annyira alkalmas, korlátozott fejlesztői és felhasználói támogatással és erőforrásokkal rendelkezik                                                                                                                                                                            |
| Tenda          | olcsóbb, alsó árketegóriás eszközök                                                                              | konfigurálhatósága, személyre szabhatósága gyengébb, mint az előbb felsoroltaké                                                                                                                 |

Ugyanakkor fontos megjegyezni, hogy a router egy támadási felület, úgyhogy a biztonság szempontjából mindenképp egyetlen routert ajánlatos beszerezni, az ajánlott, a lehetőségeknek megfelelő védelmi beállításokat elvégezni rajta, és a belső hálózatot switchekkel, vezetéknélküli access pointokkal (AP-kal) bővíteni.

### 3. Szerver operációs rendszer

A webszerver minimális, statikus weboldalakkal fog üzemelni, nem lesz szükség adatbázisszerver futtatására. Ebből fakadóan a kért fájl- levelező- és webszerver üzemeltethető egy számítógépen. Az erőforrások megfelelő kihasználása végett érdemes lehet a különféle szervereket külön virtuális gépekre telepíteni (lényegében ekkor is egy fizikai szervergépre lenne szükség), azonban ezt jelenleg nem tartjuk indokoltnak.

Lehetőségek:

| Operációs rendszer | Előnyök                                        | Hátrányok                                   |
| ------------------ | ---------------------------------------------- | ------------------------------------------- |
| Ubuntu Linux       | ingyenes                                       | a telepítés akár egy napot is igénybe vehet |
| Windows 10         | a webszerver, levelezőszerver telepítése gyors | fizetős (egyszeri költség)                  |

Mivel az anyagi források egy középiskola esetében erősen korlátozottak, ezért az ingyenessége végett Ubuntu Linux operációs rendszert ajánljuk.

### 4. Webszerver

| webszerver | előnyök                                              | hátrányok                                                     |
| ---------- | ---------------------------------------------------- | ------------------------------------------------------------- |
| Apache     | ingyenes, beállítása egyszerű                        | kevés funkció, kevés biztonsági beállítás található meg benne |
| Nginx      | ingyenes, gyorsabb töltési idő, nagyobb teljesítmény, lightweight: kevesebb erőforrást igényel a géptől | egyetlen konfigurációs fájl, kevésbé rugalmas, a fejlesztett modulok felett nincs irányításunk (nem lehet letiltani modulokat), kisebb közösségi támogatás
| XAMPP      | ingyenes                                            | egy egész fejlesztői csomag telepítését vonja maga után, ami felesleges, biztonsági beállítások hiánya

### Router terv

Egy Mikrotik routert szeretnénk bekonfigurálni a feladatnak megfelelően, a router tűzfalat, DHCP, valamint DNS-szervert biztosítana a belső hálózat (továbbiakban: LAN, vagy Internal, 10.0.0.0/27) számára, valamint a belső hálózatban lévő virtuális gépek részére átjáró az internet felé.

A Mikrotik router konfigurációját a RouterOS operációs rendszerben kívánjuk elvégezni, magát a routert virtuális géppel fogjuk szimulálni.

### IP-címzési terv

- Internal (belső) hálózat: 10.0.0.0/27
- Alhálózati maszk: 255.255.255.224
- Hálózat nagysága: 30 host
- Gateway/Mikrotik router, egyben DNS és DHCP-szerver címe: 10.0.0.1
- Web- és fájlszerver (Ubuntu): 10.0.0.2
- Kliens: DHCP [10.0.0.3 ; 10.0.0.31] tartományból

![Logikai topológia](logikai_topologia.JPG)
### Tűzfal-beállítások

- RouterOS-ben alapértelmezett portok átállítva (www, ssh)
- a felesleges portokat kikapcsoljuk (api-ssl, ftp, telnet, www-ssl)
- alapvetően minden port zárt, amíg annak megnyitását valami nem indokolja
- port forwarding: router 80-as (HTTP, majd később akár 443-as, HTTPS) portjára érkező kéréseket átirányítom az Internal webszerverének megfelelő portjára (8080)

Opcionális: Amennyiben szükség lenne VPN-kapcsolatra a webszerver konfigurálásához, azt a Mikrotik routeren szintén beállítjuk.

## Felhasználói csoportok kialakítási terve

- Alapvetően 3 féle felhasználói csoportot különböztetünk meg:
		- Gazdasági
		- Tanárok
		- Közös

## Fájlszerver terv 
- Samba fájlszerver, ami lehetőséget ad egy kliens gép számára, hogy hozzáférjen a fájlszerverhez.: 
	- [Dokumentáció](https://ubuntu.com/server/docs/samba-file-server)
- Samba telepítése:
	- sudo apt install samba 
- Felhasználók felvétele:
	- smbpasswd -a user
	- groupadd -g 501 tanarok
	- groupadd -g 502 gazdasagi
	- groupadd -g 500 kozos
- Csoport mapppa létrehozása, és jogosultság hozzáadása(példa a "tanarok" csoporttal): 
	- mdkir -p /var/fileServer/tanarok 
	- chgrp tanarok /var/fileServer/tanarok 
	- chmod 660 /var/fileServer/tanarok

A Samba fájlszerver __todo__ protokollt használ. 

## Levelezőszerver terv 

POP3-as protokollt fogjuk használni a levelek fogadásához a hatékonyabb biztonság érdekében, mivel az email csak egyetlen kliensgépre töltődik le.
A levelek küldésére az SMTP protokoll fog működni.
Az Ubuntu szerveren a Dovecot nevű alkalmazást használjuk a levelezőszerver konfigurálásához.

[Dovecot Dokumentáció](https://ubuntu.com/server/docs/mail-dovecot)

## Webszerver terv

- Maga a webszolgáltatás Linux alapon Ubuntu-n készül, melyen belül Apache(2) webszolgáltatás lesz telepítve.
- Apache telepítése:
	- sudo apt install apache2
- html fájl helye:
	- /var/www
- Szerver aktiválása:
	- sudo a2ensite <conf fájl> 
- Portok config fájljának a helye:
	- /etx/apache2/ports.conf 
- A szerverhez tartozó html fájlokat a /var/www/szero mappában találjuk meg.

Az Apache webszerver a 8080-as porton fut, várja a kéréseket.

A webszer alapvetően statikus tartalmú HTML-állományokat fog hosztolni dinamikus útvonalak nélkül, ezért az Apache szerveren kívül másra esetünkben nincs szükség.


## Elérhető weboldalak
Egy iskolának a weboldalát kívánjuk létrehozni, mely a következő elképzelések alapján valósul meg. A weboldal megnyitása követően egy Kezdőlap/Főoldal jelenik, ahol egy rövid leírás található magáról az iskoláról, illetve az elért sikereiről.

![Weboldalterv](./weboldalterv.png)

A weboldalon található egy menüsáv, ahol a felhasználó könnyen tud tájékozodni a felületen. A menüsávban megtalálhatóak a **Kezdőlap**, **Felvételi**, **Tantárgyak**, **Magunkról**, **Kapcsolat** pont. 

A **Felvételi** oldalon lehet tájékozodni a szülőknek és a diákoknak, hogy mire érdemes oda figyelni, illetve a követelményeket is tudják megtekinteni. 

A **Tantárgyak** oldalon látják a felhasználók, hogy milyen tantárgyakat oktatnak az adott iskolában és kik lehetnek a diákok tanáraik. 

A **Magunkról** oldalon lehet megtekinteni, az iskola bemutatkozását, illetve mire a legbüszkébb. Szintén itt lehet megtekinteni a korábbi eseményekről történt videókat, mint például a Magyar költészet napja vagy Sportnap és a házirend is itt érhető el. 

A **Kapcsolat** oldalon találhatóak az iskola elérhetősége, mint például cím, telefon és OM azonosítója és ez alatt egy google térkép ablak, ahol külön keresés nélkül lehet megtekinteni az iskola pontos helyét. 

A weboldaltervet Gajdos György készítette el.

## Csapattagok

- Sipos Levente (Neptun-kód: D985ET)
- Gajdos György (Neptun-kód: AM7NTP)
- Nagy-Tóth Bence (Neptun-kód: DZKBX0)

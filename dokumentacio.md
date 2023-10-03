# Korszerű operációs rendszerek beadandó terv

## Választott feladat: 2. _todo_

##

## Router terv

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

- RouterOS-ben alapértelmezett portok elrejtve (80, 22), felesleges portok kikapcsolva ()
- port forwarding: router 80-as (HTTP, majd később akár 443-as, HTTPS) portjára érkező kéréseket átirányítom az Internal webszerverének megfelelő portjára (_TODO: 8080?_)

Opcionális: Amennyiben szükség lenne VPN-kapcsolatra a webszerver konfigurálásához, azt a Mikrotik routeren szintén beállítjuk.


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


## Csoportok kialakításának a terve

- Alapvetően 3 féle felhasználói csoportot különböztetünk meg:
		- Gazdasági
		- Tanárok
		- Közös

## Fájlszerver terv 
- Samba fájlszerver, ami lehetőséget ad egy kliens gép számára, hogy hozzáférjen a fájlszerverhez.: 
	- Dokumentáció: https://ubuntu.com/server/docs/samba-file-server
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

## Levelezőszerver terv 

## Weboldalak terv

**todo**

## Csapattagok

- Sipos Levente (Neptun-kód: D985ET)
- Gajdos György (Neptun-kód: **todo**)
- Nagy-Tóth Bence (Neptun-kód: DZKBX0)

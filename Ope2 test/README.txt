Vajalikud programmid skripti käivitamiseks:
* Skripti käivitamiseks on vaja Windows operatsioonisüsteemi, SQL Central programmi ja Interactive SQL ehk iSQL. 
* Pakkfail on tehtud Windows operatsioonisüsteemi reeglite järgi. Kui pakkfail ümber kirjutada, siis saab loodud kodutöö kontrolli käivitada ka Linux’is või Mac’is.

Automaatkontrolli keskkonna ettevalmistus (ühekordne tegevus):
1) Luua kaust, kus hakatakase kodutöid kontrollima.
2) Pakkida lahti seal samas kaustas automaatkontrolli zip fail.
3) Kontrollida, kas kausta tekkis ope_test.sql, ope_test.bat
4) Luua C-kettale "TEMP" kaust (kui seda pole veel).

Tudengi kodutöö kontrollimine:
* Kontrollida skriptifailist, kas muutuja "versioon" vastab kodutöö numbrile (rida 2) ja vajadusel muuta number õigeks.

1) Laadida Moodle'ist tudengi kodutöö zip fail.
2) Pakkida lahti kausta, kus hakatakse kodutöid kontrollima.
3) Kontrollida, et tudeng on esitanud ope.db ja ope.log failid.
4) Käivitada ope_test.bat.

Pakkfail avab iSQL'i ja tudengi andmebaasi ning käivitab skripti, mis teeb kontrollid.
Kontrolli lõpus tuleb tulemus iSQL'i aknasse.

5) Sulge iSQl, sest siis tekivad tulemusfailid kausta, kus kodutöid kontrollitakse.
6) Kopeeri tulemus tulemusfailist Moodle'isse ja pane tudengile skripti esitatud hinne.
7) Sulge tulemusfail.
8) Kustuta ope.log ja ope.db.
9) Nüüd võib võtta järgmise tudengi kodutöö!

Arendaja:
Martti Kakk
marttikakk@hotmail.com
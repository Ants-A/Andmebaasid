**WSL SETUP**

* Ava powershell ja runni command " wsl --install"
* Reboot arvuti
* wsl-i sisse saamiseks runni powershellis " wsl "
* Edasi ma liht hakkan andma commande mida runnida

* sudo apt update
* sudo apt install mysql-server
* sudo service mysql start
* sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
* Leia rida, kus on kirjas " port ", kustuta hashtag (#) eest ära ja vaheta porti number 3008 peale
* Ctr + X ja siis enter
* sudo service mysql restart

* sudo mysql  ( või mysql -u root -p -P 3308, kui esimene ei tööta)
* CREATE USER 'mysql'@'%' IDENTIFIED BY 'pane_siia_parool';
* GRANT ALL PRIVILEGES ON *.* TO 'mysql'@'%' WITH GRANT OPTION;
* FLUSH PRIVILEGES;
* Exit;

Ja nüüd kui minna mysql workbenchi ( windowsil, mitte wsl) siis lisada uus connection, useriks "mysql" ja parool pane see, mille settisid talle, port pane 3008 ja peaks töötama

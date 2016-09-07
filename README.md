# rsync_backup #

Sauvegarde de mon mac avec rsync sur un partage samba.

## Description ##

Ce script lance le backup de la machine sur un serveur samba (le partage samba est monté comme un disque local — pas de ssh).

Il peut être lancé par launchd au démarrage de la machine (cf ~/Library/LaunchAgents/com.boissonnfive.backup.plist) par la commande:

       $ launchctl load ~/Library/LaunchAgents/com.boissonnfive.backup.plist

Retour: 1 si un des scripts a renvoyé une erreur. 0 si tout est OK

Usage:

	./startup.sh (pas de paramètres)

## Remarques ##

1. Nécessite les scripts suivants :

	- functions.sh                 (fonctions d'affichage)
	- check_network.sh             (vérifie la connexion au réseau de la maison)
	- connect_samba_shares.sh      (monte les serveurs samba)
	- export_safari_bookmarks.sh   (exporte les signets de safari)
	- ExportAddressBookToVcf.scpt  (exporte les contacts du carnet d'adresse)
	- backup.sh                    (lance la sauvegarde)

2. Si le script est lancé par launchd, il doit avoir tous les chemins en absolu car le répertoire de départ sera /



## Version 0.2 ##

Modification du script export_safari_bookmars.sh pour changer le xsl qui transforme un fichier plist en XHTML.

## Version 0.1 ##

Version initiale.


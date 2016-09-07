#! /bin/bash

# ------------------------------------------------------------------------------
# Auteur: Bruno Boissonnet
# Date: 09 dec 2008
# Description: Ce script lance le backup de la machine sur un serveur samba
#              (le partage samba est monté comme un disque local — pas de ssh) 
#              Il peut être lancé par launchd au démarrage de la machine
#              (cf ~/Library/LaunchAgents/com.boissonnfive.backup.plist)
#              par la commande:
#        $ launchctl load ~/Library/LaunchAgents/com.boissonnfive.backup.plist
# Retour: 1 si un des scripts a renvoyé une erreur. 0 si tout est OK
# Usage:  ./startup.sh (pas de paramètres)
# Remarque:
# Nécessite les scripts suivants
#   - functions.sh                 (fonctions d'affichage)
#   - check_network.sh             (vérifie la connexion au réseau de la maison)
#   - connect_samba_shares.sh      (monte les serveurs samba)
#   - export_safari_bookmarks.sh   (exporte les signets de safari)
#   - ExportAddressBookToVcf.scpt  (exporte les contacts du carnet d'adresse)
#   - backup.sh                    (lance la sauvegarde)
# Si le script est lancé par launchd, il doit avoir tous les chemins en absolu
# car le répertoire de départ sera /
# Variables à modifier:
# - WAIT: temps d'attente avant le démarrage du script en secondes
# - CHECK_NETWORK: chemin vers le script check_network.sh
# - SAMBA: chemin vers le script connecter_serveurs_maman.sh
# - SAFARI: chemin vers le script export_safari_bookmarks.sh
# - AB: chemin vers le script Applescript ExportAddressBookToVcf.scpt
# - BACKUP: chemin vers le script backup.sh
# ------------------------------------------------------------------------------

# Variables à modifier
declare -r SOURCE="$HOME/"
declare -r DESTINATION="/Volumes/bruno/"
declare -r EXCLUDE="exclude.txt"
declare -ri WAIT=120

# Le fichier de traces est géré par launchd
declare -r LOG_FILE="/Library/Logs/bb_backup.log"
declare -r CHECK_NETWORK=check_network.sh
declare -r SAMBA=connect_samba_shares.sh
declare -r SAFARI=export_safari_bookmarks.sh
declare -r SAFARI_BOOKMARKS=$HOME/Documents/favoris/signets_safari.html
declare -r AB=ExportAddressBookToVcf.scpt
declare -r INTERNET_IP="88.162.114.99"
#declare -ra mountDiskList=( bruno Photos_Couple 'dossier public de maman' )
declare -ra mountDiskList=( bruno )
declare -r FUNCTIONS="functions.sh"
declare -r RSYNC_306="/usr/local/bin/rsync"
declare -r ERROR1="Backup impossible: réseau non identifié ou connexion impossible."
declare -r ERROR2="Backup impossible: échec des connexions aux serveurs."
declare -r ERROR3="Backup IMPOSSIBLE car lecture IMPOSSIBLE de ${SOURCE}"
declare -r ERROR4="Backup IMPOSSIBLE car ${DESTINATION} non connecté/modifiable"
declare -r ERROR5="Des erreurs sont apparues lors du backup"
declare -r HEADER="Backup de `basename \"${SOURCE}\"` vers `basename \"${DESTINATION}\"`"
declare -i RETURN=0
declare -r SCRIPT_DIR=`dirname $0`

# Attends un moment avant que le script ne se lance
sleep ${WAIT}

# Récupère les fonctions du fichier FUNCTIONS
source "${SCRIPT_DIR}/${FUNCTIONS}"

printHeader "${HEADER}"

# Si on n'est pas sur le réseau de la maison, on quitte
if ! "${SCRIPT_DIR}/${CHECK_NETWORK}" "${INTERNET_IP}" ; then
	printError "${ERROR1}"
	RETURN=1
else
	# Si on ne peut pas monter les serveurs Samba, on quitte
	if ! "${SCRIPT_DIR}/${SAMBA}" "${mountDiskList[@]}" ; then
		printError "${ERROR2}"
		RETURN=1
	else
		# Exportation des signets safari
		"${SCRIPT_DIR}/${SAFARI}" "${SAFARI_BOOKMARKS}"
		# Exportation du carnet d'adresse
		osascript "${SCRIPT_DIR}/${AB}"
		
		# 1- Test de la source (elle doit être accessible en lecture)
		if test ! -r ${SOURCE}; then
			printError ${ERROR3}
		    RETURN=1

		# 2- Test de la destination (elle doit être accessible en écriture)
		elif ! test -w ${DESTINATION} ; then
		    printError ${ERROR4}
		    RETURN=1
		fi
		
		# 3- Sauvegarde
		# pour les tests, utiliser --dry-run (ne fait rien)
		#${RSYNC_306} --dry-run -avuL --delete --exclude-from "${SCRIPT_DIR}/${EXCLUDE}" "${SOURCE}" "${DESTINATION}"
		${RSYNC_306} -avuL --delete --exclude-from "${SCRIPT_DIR}/${EXCLUDE}" "${SOURCE}" "${DESTINATION}"
		
		#3b- Supprime les répertoires du fichiers de trace
		sed -e '/.*\/$/d' -i "" "${LOG_FILE}"
		
		#3c- Recherche les erreurs dans le fichier de trace
		if grep "rsync error:" "${LOG_FILE}" ; then
			printError "${ERROR5}"
			RETURN=1
		fi
		
		#4- Démonte le serveur Samba
		umount /Volumes/bruno
		
	fi			
fi

printFooter

exit $RETURN

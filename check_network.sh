#! /bin/bash

# ------------------------------------------------------------------------------
# Auteur: Shaneal Manek + Bruno Boissonnet
# Date: 27 dec 2006
# Description: Ce script vérifie si on est connecté au réseau de la maison
# Usage:       ./check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI.
#   -h:   affiche cette aide
#   IP: adresse IP externe fournie par son FAI
# Retour: 0 si IP est l'adresse externe, 1 sinon.
# Remarques:
# Nécessite les outils suivants: ifconfig, grep, awk, lynx, sed
# Variables à modifier:
#  - WHATISMYIP_ADDRESS: site web affichant l'adresse internet externe
# ------------------------------------------------------------------------------

# Codes d'erreur
# 0: pas d'erreur
# 1: nombre de paramètres incorrect
# 2: option incorrecte
# 3: mauvaise adresse IP ou connexion réseau impossible

# usage
# Affiche l'aide
# pas de paramètres
# retour: toujours 0
usage()
{
	echo "Usage: `basename $0` [-h] IP"
	echo "Vérifie si on est connecté à son FAI. "
	echo "  -h:   affiche cette aide"
	echo "  IP: adresse IP externe fournie par son FAI"
}

# checkNetwork
# vérifie si on est connecté au réseau de la maison
# $1: adresse IP fournie par mon FAI (IP externe)
# return: 0 si OK, 1 sinon
checkNetwork()
{
	local -r WHATISMYIP_ADDRESS="http://www.whatismyip.fr/"
	local -i RET=3

	# Récupère les status wifi et ethernet
	# 1- Affiche les caractéristiques de la connextion wifi (en1)
	# 2- Sélectionne la ligne où il y a le mot "status"
	# 3- Affiche le dernier mot de cette ligne ("active" ou "inactive")
	status_wifi=$(ifconfig en1 | grep status | awk '{print $NF}')
	status_ethernet=$(ifconfig en0 | grep status | awk '{ print $NF }')

	# Récupère l'adresse IP externe de la machine
	# 1- Récupère les infos sur la page whatismyip
	# 2- Sélectionne la ligne où il y a le mot "Adresse IP :" et
	#    remplace tout ce qu'il y a avant l'adresse IP par rien
	if [ "$status_wifi" == "active" ] || [ "$status_ethernet" == "active" ]; then
		IP=`/usr/local/bin/lynx -dump "${WHATISMYIP_ADDRESS}" 2> /dev/null \
			| sed -n '/Adresse IP :/s/^[ ]*Adresse IP : //p'`
	fi

	if [ "$status_wifi" == "active" ] && [ "${IP}" == "$1" ]; then
		# echo "Connexion réseau maison(${IP}) via WIFI: OK"
		RET=0
	elif [ "$status_ethernet" == "active" ] && [ "${IP}" == "$1" ]; then
		# echo "Connexion réseau maison(${IP}) via ethernet: OK"
		RET=0
	fi

	return $RET
}

declare -i RET=0

if [ $# -eq 1 ]; then
	if [[ $1 == -* ]]; then
		if [ $1 == "-h" ]; then
			usage
		else
			echo "`basename $0`: illegal option $1"
			usage
			RET=2
		fi
	elif checkNetwork "$1" ; then
		echo $1
	else
		RET=$?
	fi
else
	usage
	RET=1
fi



exit $RET

# -----
# Tests
# -----

# $ ./check_network.sh 88.162.114.99
# 88.162.114.99
# $ echo $?
# 0

# $ ./check_network.sh -h
# Usage: check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 0

# $ ./check_network.sh
# Usage: check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 1

# $ ./check_network.sh -h 88.162.114.99
# Usage: check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 1

# $ ./check_network.sh -hg
# check_network.sh: illegal option -hg
# Usage: check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 2

# $ ./check_network.sh jfkdls
# $ echo $?
# 3

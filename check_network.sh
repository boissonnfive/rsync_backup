#! /bin/bash

# ------------------------------------------------------------------------------
# Auteur: Shaneal Manek + Bruno Boissonnet
# Date: 27 dec 2006
# Description: Vérifie si on est connecté à internet via son FAI
# Usage:       ./check_network.sh [-h] IP
# Vérifie si on est connecté à son FAI.
#   -h:   affiche cette aide
#	-d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# Retour: 0 : IP est l'adresse externe fourni par le FAI
#         1 : nombre de paramètres incorrect.
#         2 : option incorrecte
#         3 : mauvaise adresse IP ou connexion réseau impossible 
# Remarques:
# Utilise le site https://api.ipify.org (à modifier si besoin)
# ------------------------------------------------------------------------------

DEBUG=False

main()
{
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
	elif [ $# -eq 2 ]; then
		if [[ $1 == -* ]]; then
			if [ $1 == "-h" ]; then
				usage
				RET=1
			elif [ $1 == "-d" ]; then
				DEBUG=True
				echo "`basename $0`: mode debug"
				if checkNetwork "$2" ; then
					echo $2
				else
					RET=$?
				fi
			else
				echo "`basename $0`: illegal option $1"
				usage
				RET=2
			fi
		else			
			echo "`basename $0`: illegal option $1"
			usage
			RET=2
		fi
	else
		usage
		RET=1
	fi

	return $RET
}


# usage
# Affiche l'aide
# pas de paramètres
# retour: toujours 0
usage()
{
	echo "Usage: `basename $0` [-hd] IP"
	echo "Vérifie si on est connecté à son FAI. "
	echo "  -h:   affiche cette aide"
	echo "  -d:   affiche les informations de debug"
	echo "  IP: adresse IP externe fournie par son FAI"
}

# checkNetwork
# vérifie si on est connecté au réseau de la maison
# $1: adresse IP fournie par mon FAI (IP externe)
# return: 0 si OK, 3 si mauvaise adresse IP ou connexion réseau impossible
checkNetwork()
{
	local -r WEB_SITE="https://api.ipify.org"
	local -i RET=3

	# Récupère les status wifi et ethernet
	# 1- Affiche les caractéristiques de la connextion wifi (en1)
	# 2- Sélectionne la ligne où il y a le mot "status"
	# 3- Affiche le dernier mot de cette ligne ("active" ou "inactive")
	status_wifi=$(ifconfig en1 | grep status | awk '{print $NF}')
	# ou :        ifconfig en0 | sed -nE 's/^.+status: ([a-z]+)$/\1/p'
	# ou encore : ifconfig en0 | sed -nE 's/[^:]+:[[:space:]]([[:alpha:]]+)$/\1/p'
	if [ $DEBUG == "True" ]; then
		echo "WIFI : "$status_wifi
	fi
	
	status_ethernet=$(ifconfig en0 | grep status | awk '{ print $NF }')
	if [ $DEBUG == "True" ]; then
		echo "Ethernet : "$status_ethernet
	fi

	# Récupère l'adresse IP externe de la machine si on est connecté
	if [ "$status_wifi" == "active" ] || [ "$status_ethernet" == "active" ]; then
		IP=$(curl -s ${WEB_SITE})
		if [ $DEBUG == "True" ]; then
			echo "Adresse IP : "$IP
		fi
		if [ "${IP}" == "$1" ]; then
			# echo "Connexion réseau maison(${IP}) via WIFI: OK"
			RET=0
		fi
		# else : mauvaise adresse IP 
	fi
	# else : connexion réseau impossible

	return $RET
}


# ------------------------
#    DÉBUT DU PROGRAMME
# ------------------------

main $@

# -----
# Tests
# -----

# $ ./check_network.sh 88.162.114.99
# 88.162.114.99
# $ echo $?
# 0

# $ ./check_network.sh -h
# Usage: check_network.sh [-hd] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   -d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 0

# $ ./check_network.sh
# Usage: check_network.sh [-hd] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   -d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 1

# $ ./check_network.sh -h 88.162.114.99
# Usage: check_network.sh [-hd] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   -d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 1

# $ ./check_network.sh -hd
# check_network.sh: illegal option -hd
# Usage: check_network.sh [-hd] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   -d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 2


# $ ./check_network.sh -d
# check_network.sh: illegal option -d
# Usage: check_network.sh [-hd] IP
# Vérifie si on est connecté à son FAI. 
#   -h:   affiche cette aide
#   -d:   affiche les informations de debug
#   IP: adresse IP externe fournie par son FAI
# $ echo $?
# 2

# $ ./check_network.sh jfkdls
# $ echo $?
# 3

#! /bin/bash

# ------------------------------------------------------------------------------
# Auteur: Bruno Boissonnet boissonnfive@gmail.com
# Date: 09 dec 2008
# Description: Connecte les partages samba
# Usage: $0 [-h] [share ...]
# Connecte les partages samba.
#   -h:   affiche cette aide
#   share: nom des partage samba
# Remarques:
# Nécessite les outils suivants: mount_smbfs, mkdir, sed
# ------------------------------------------------------------------------------

# Codes d'erreur
# 0: pas d'erreur
# 1: nombre de paramètres incorrect
# 2: option incorrecte
# 3: Impossible de créer le répertoire destination
# 4: Impossible de renommer le serveur samba
# 5: Impossible de monter le serveur Samba


# usage
# Affiche l'aide
# pas de paramètres
# retour: toujours 0
usage()
{
	echo "Usage: `basename $0` [-h] [share ...]"
	echo "Connecte les partages samba. "
	echo "  -h:   affiche cette aide"
	echo "  share: nom des partage samba"
}

# connectSambaShare
# connecte une serveur Samba
# $1: nom du serveur Samba
# return: 0 si OK, 1 sinon
connectSambaShare()
{
	# Variable de retour
	local -i RET=0
	# Connexion au serveur samba
	local -r IP=192.168.0.19
	local -r LOGIN=bruno
	local -r PASSWORD=brunoboi
	# Récupération du tableau passé en paramètres
	local -a sambaShare=( "$@" )

	# On parcourt tous les éléments de la liste (partages samba)
	# On monte chaque partage samba
	# S'il y en a un qui ne monte pas, on quitte avec un retour d'erreur
	local -i i=0
	while (( $i < ${#sambaShare[@]} )); do
		#echo "${sambaShare[i]}"
		if mkdir "/Volumes/""${sambaShare[i]}" ; then
			# Remplacement des espaces par des %20
			sambaName=`echo "${sambaShare[i]}" | sed 's/ /%20/g'`
			if [ $? == "0" ]; then
				if mount_smbfs "//${LOGIN}:${PASSWORD}@${IP}/""${sambaName}" "/Volumes/""${sambaName}"; then
					echo "${sambaShare[i]}"
				else
					#let i=${#sambaShare[@]}
					RET=5
					echo "Impossible de monter le serveur Samba \"${sambaShare[i]}\""
					# rmdir ne supprime que les dossier vide. Cool, non?
					rmdir "/Volumes/""${sambaShare[i]}"
				fi
			else
				RET=4
				# rmdir ne supprime que les dossier vide. Cool, non?
				rmdir "/Volumes/""${sambaShare[i]}"
			fi			
		else
			RET=3
		fi
		let i++
	done
	
	return $RET
}

if [ $# -eq 1 ]; then
	if [[ $1 == -* ]]; then
		if [ $1 == "-h" ]; then
			usage
		else
			echo "`basename $0`: illegal option $1"
			usage
			RET=2
		fi
	else
		connectSambaShare "$1"
		RET=$?
	fi
else
	connectSambaShare "$@"
	RET=$?
fi

exit $RET

# -----
# Tests
# -----

# $ ./connect_samba_shares.sh -h
# Usage: connect_samba_shares.sh [-h] [share ...]
# Connecte les partages samba. 
#   -h:   affiche cette aide
#   share: nom des partage samba
# $ echo $?
# 0

# $ ./connect_samba_shares.sh bruno
# bruno
# $ echo $?
# 0

# $ ./connect_samba_shares.sh -hg
# connect_samba_shares.sh: illegal option -hg
# Usage: connect_samba_shares.sh [-h] [share ...]
# Connecte les partages samba. 
#   -h:   affiche cette aide
#   share: nom des partage samba
# $ echo $?
# 2

# $ ./connect_samba_shares.sh test
# mkdir: /Volumes2: No such file or directory
# $ echo $?
# 3


# $ ./connect_samba_shares.sh test
# ./connect_samba_shares.sh: line 59: /user/bin/sed: No such file or directory
# $ echo $?
# 4
# $ ls /Volumes/
# Macintosh HD	Untitled


# $ ./connect_samba_shares.sh bruno 'dossier public de toto'
# bruno
# mount_smbfs: mount error: /Volumes/dossier public de toto: Broken pipe
# Impossible de monter le serveur Samba "dossier public de toto"
# $ echo $?
# 5
# $ ls /Volumes/
# Macintosh HD	Untitled	bruno



#! /bin/bash

# printMessage
# Print a message
# $1: message
# return: 0
printMessage()
{
	echo ""
    echo "-----------------------------------------------------------------"
    echo "$1"
    echo "-----------------------------------------------------------------"
}

# printError
# Print an error message
# $1: message
# return: 0
printError()
{
	local -r GROWL=/usr/local/bin/growlnotify
	[[ -f ${GROWL} ]] && ${GROWL} --iconpath attention -t `basename $0` -m "ERROR: $1"
	echo ""
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "ERROR: $1"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
}

# printHeader
# Print a header
# $1: message to put in the header
# return: 0
printHeader()
{
    heure=$(date +%Hh%M)
    date=$(date +%d/%m/%Y)
    message="$1 - le $date a $heure"

    printMessage "${message}"
}

# printFooter
# Print a footer in a file
# $1: file to print the header into
# return: 0
printFooter()
{
	heure=$(date +%Hh%M)
    date=$(date +%d/%m/%Y)
	message="Fin le $date a $heure"
    echo ""
	echo "                 ${message}"
    echo "*****************************************************************"
}





# nom_backup=$(basename "$2")
# nom_cible=$(basename "$3")
# message="Backup du $date a $heure de ${nom_backup} vers ${nom_cible}"
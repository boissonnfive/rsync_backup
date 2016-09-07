#! /bin/bash

# ------------------------------------------------------------------------------
# Auteur: macscripter.net + bruno boissonnet boissonnfive@gmail.com
# Date: 27 dec 2008
# Description: exporte les signets de safari au format HTML
# Usage: $0 [-h] file
# Exporte les signets de safari au format HTML.
#   -h:   affiche cette aide
#   file: fichier de sortie
# Retour: 0 si IP est l'adresse externe, 1 sinon.
# Remarques:
# Nécessite les outils suivants: plutil, xmllint, sed, xsltproc, rm
# Variables à modifier:
#  - BOOKMARKS: site web affichant l'adresse internet externe
# ------------------------------------------------------------------------------

# Codes d'erreur
# 0: pas d'erreur
# 1: nombre de paramètres incorrect
# 2: option incorrecte
# 3: plutil n'a pu convertir le fichier plist
# 4: le fichier xml n'est pas valide
# 5: sed n'a pu créé le fichier xsl
# 6: xsltproc n'a pu transfomer le fichier xml en HTML


# usage
# Affiche l'aide
# pas de paramètres
# retour: toujours 0
usage()
{
	echo "Usage: `basename $0` [-h] file"
	echo "Exporte les signets de safari au format HTML. "
	echo "  -h:   affiche cette aide"
	echo "  file: fichier de sortie"
}


safariBookmarksToHTML()
{
	HTML_result=$1
	# HTML_result=$HOME/Documents/favoris/signets_safari.html

	local -r BOOKMARKS=$HOME/Library/Safari/Bookmarks.plist
	local -r BOOKMARKS_XML=$HOME/Documents/favoris/signets_safari.xml
	local -r XSLFile=/tmp/plist2html.xsl
	local -i RET=0

	# transforme un fichier plist en fichier xml
	if plutil -convert xml1 -o "${BOOKMARKS_XML}" "${BOOKMARKS}"; then
		# Valide le fichier xml
		if xmllint --noout "${BOOKMARKS_XML}"; then
			# crée le fichier xsl
			sed > "${XSLFile}" <<EOF

<xsl:stylesheet version='1.0'
xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
xmlns='http://www.w3.org/1999/xhtml'>

<xsl:output method='xml' indent='no'
doctype-public='-//W3C//DTD XHTML 1.0 Transitional//EN'
doctype-system='http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'
omit-xml-declaration='no'
media-type='application/xhtml+xml; charset=utf-8'/>

<xsl:template match='/'>
<html>
<head>
<title>Safari Bookmarks</title>
</head>
<body>
<h1>Safari Bookmarks</h1>
<ul>
<xsl:apply-templates select='plist/dict'/>
</ul>
</body>
</html>
</xsl:template>

<xsl:template match='array'>
<ul>
<xsl:apply-templates/>
</ul>
</xsl:template>

<xsl:template match='dict'>
<li>
<xsl:choose>
<xsl:when test='string[text()="WebBookmarkTypeLeaf"]'>
<xsl:apply-templates select='key[text()="URIDictionary"]/following-sibling::dict[1]' mode='URIDictionary'/>
</xsl:when>
<xsl:when test='string[text()="WebBookmarkTypeList"]'>
<xsl:if test='key[text()="Title"]'>
<h3><xsl:apply-templates select='key[text()="Title"]/following-sibling::string[1]'/></h3>
</xsl:if>
</xsl:when>
</xsl:choose>
<xsl:apply-templates select='key[text()="Children"]/following-sibling::array[1]'/>
</li>
</xsl:template>

<xsl:template match='dict' mode='URIDictionary'>
<a href='{string[1]}'>
<xsl:value-of select='key[text()="title"]/following-sibling::string[1]'/>
</a>
</xsl:template>

</xsl:stylesheet>
EOF
			if [ $? == "0" ] ;then
				# transforme le fichier xml en fichier HTML via un fichier xsl
				if xsltproc "${XSLFile}" "${BOOKMARKS_XML}" > "${HTML_result}"; then
					:
				else
					# growlnotify -t "$(basename "$0")" -m "Erreur: xsltproc n'a pu transfomer le fichier xml en HTML (${XSLFile})"
					# echo "Erreur: xsltproc n'a pu transfomer le fichier xml en HTML (${XSLFile})"
					RET=6
				fi
			else
				# growlnotify -t "$(basename "$0")" -m "Erreur: sed n'a pu créé le fichier xsl (${XSLFile})"
				# echo "Erreur: sed n'a pu créé le fichier xsl (${XSLFile})"
				RET=5
			fi
		else #fichier xml invalide (ça m'est déjà arrivé !!!)
			# echo "Replace "$1" with "$2" in "$3"            [NOK]"
			# growlnotify -t "$(basename "$0")" -m "Erreur: le fichier xml n'est pas valide (${BOOKMARKS_XML})"
			# echo "Erreur: le fichier xml n'est pas valide (${BOOKMARKS_XML})"
			RET=4
		fi
	else
		# echo "Replace "$1" with "$2" in "$3"            [NOK]"
		# growlnotify -t "$(basename "$0")" -m "Erreur: plutil n'a pu convertir le fichier plist (${BOOKMARKS})"
		# echo "Erreur: plutil n'a pu convertir le fichier plist (${BOOKMARKS})"
		RET=3
	fi

	# On supprime les fichiers temporaires (XML et XSL)
	rm -f "${XSLFile}" "${BOOKMARKS_XML}"

	return ${RET}
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
	elif safariBookmarksToHTML "$1" ; then
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

# $ ./export_safari_bookmarks.sh signets_safari.html
# signets_safari.html
# $ echo $?
# 0
# $ open -a Safari signets_safari.html 

# $ ./export_safari_bookmarks.sh -h
# Usage: export_safari_bookmarks.sh [-h] file
# Exporte les signets de safari au format HTML. 
#   -h:   affiche cette aide
#   file: fichier de sortie
# $ echo $?
# 0

# $ ./export_safari_bookmarks.sh
# Usage: export_safari_bookmarks.sh [-h] file
# Exporte les signets de safari au format HTML. 
#   -h:   affiche cette aide
#   file: fichier de sortie
# $ echo $?
# 1

#  ./export_safari_bookmarks.sh -hg
# export_safari_bookmarks.sh: illegal option -hg
# Usage: export_safari_bookmarks.sh [-h] file
# Exporte les signets de safari au format HTML.
#   -h:   affiche cette aide
#   file: fichier de sortie
# $ echo $?
# 2

# $ ./export_safari_bookmarks.sh signets_safari.html
# /Users/brunoboissonnet/Library2/Safari/Bookmarks.plist: file does not exist or is not readable or is not a regular file
# $ echo $?
# 3

# $ ./export_safari_bookmarks.sh signets_safari.html
# warning: failed to load external entity "/Users/brunoboissonnet/Documents/favoris/signets_safari.xml2"
# $ echo $?
# 4

# $ sudo touch /tmp/plist2html.xsl
# Password:
# $ ./export_safari_bookmarks.sh signets_safari.html
# ./export_safari_bookmarks.sh: line 56: /tmp/plist2html.xsl: Permission denied
# rm: /tmp/plist2html.xsl: Permission denied
# $ echo $?
# 5

# $ sudo touch signets_safari.html
# $ ./export_safari_bookmarks.sh signets_safari.html
# ./export_safari_bookmarks.sh: line 114: signets_safari.html: Permission denied
# $ echo $?
# 6

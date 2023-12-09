#!/bin/bash
PATH=$PATH:/usr/local/bin:/usr/bin

# Positional arguments:
# $1: user - with or without domain in manner of domain\user (keepass does not have built-in 'domain' field
# $2: pass
# $3: URL

split_user() {
	DOMAIN=$( echo ${1} | cut -f 1 -d \\ )
	USER=$( echo ${1} | tr \\ ' ' | awk '{print $NF}' )
	if [[ ${USER} == ${DOMAIN} ]]; then
		DOMAIN=''
	else
		DOMAIN="$DOMAIN\\"
	fi
	USERSTRING=${DOMAIN}${USER}
}

struct_pass() {
	PASS=$( remmina-encode-password.py $1 )
}

struct_url() {
	URL=${1#"rdp://"}
}

split_user "${1}"
struct_pass "${2}"
struct_url "${3}"
# Connect
remmina -c rdp://${USERSTRING}:${PASS}@${URL} 


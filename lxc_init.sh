#!/usr/bin/env bash
set -euo pipefail


display() {
	printf -- "%s\n" "$1" 
}

display_lxc() {
	sudo lxc-ls -f

}

error() {
        printf "Error : %s\n" "$1" >&2
        exit "$2"
}

display "Configuration des locales"
sed -i 's/# fr_FR.UTF-8/fr_FR.UTF-8/' /etc/locale.gen || error "Failed to configure locale 1" 1
echo 'LANG=fr_FR.UTF-8' > /etc/default/locale || error "Failed to configure locale 2" 2
display "Génération de la locale"
locale-gen || error "Failed to generate locale" 3 

useradd -G sudo -m -s /bin/bash user || error "Failed to create user" 4

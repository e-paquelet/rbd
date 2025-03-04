# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History settings
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# Lesspipe (pour améliorer l'affichage de certains fichiers)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Détecter si on est en chroot
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Activer les couleurs du prompt et du terminal
force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# === 🎨 Personnalisation du prompt (root en rouge) ===
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;31m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\] \[\e[1;32m\]$(date +"%H:%M:%S")\[\e[0m\] \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Couleurs et alias
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# === 📂 Aliases pratiques ===
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias IP='ip --brief -c a'
alias APT='sudo apt update -y && sudo apt upgrade -y'
alias RAM='free -h'
alias DISK='df -hT'
alias IPR='ip route'
alias NETSTAT='ss -tulnp'
alias REBOOT='sudo reboot'
alias SD='sudo shutdown -h now'

# Charger les alias utilisateurs
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# === 📜 Fonction du menu ===
function show_menu {

        echo -e "\e[32m=================================================================================\e[0m"
        echo -e "\e[32m===================== 🚀 Bienvenue dans le terminal personnalisé =================\e[0m"
        echo -e "\e[32m=================================================================================\e[0m"
        echo -e "\e[34m IP) Afficher les adresses IP          \e[31m APT) Mettre à jour le système \e[0m"
        echo -e "\e[35m RAM) Afficher l'utilisation RAM       \e[36m DISK) Afficher l'espace disque \e[0m"
	      echo -e "\e[34m NETSTAT) Affiche les ports            \e[26m SD) Arrêter le système\e[0m"
        echo -e "\e[33m IPR) Affiche les routes               \e[32m EDIT) Editer le menu \e[0m"
      	echo -e "\e[31m REFRESH) rafraichir le terminal       \e[28m HELP Afficher le menu\e[0m"
        echo -e "\e[32m=================================================================================\e[0m"
}

show_menu
alias HELP=show_menu
alias EDIT='nano .bashrc'
alias REFRESH='source ~/.bashrc'

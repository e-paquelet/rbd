#!/bin/bash

read -p "Que voulez vous installer : Zimbra FOSS, Script dde synchronisation entre AD et ZImbra, Webmin ? (Répondre par : zimbra, script, ou webmin" APP ;

if [ $APP =  "zimbra" ]; 
	then
		echo -e "\e[33m=========================================================================================================================================\e[0m";
		echo -e "\e[33m========================================================[   Prerequisite    ]============================================================\e[0m";
		echo -e "\e[33m==                                  Ce script va installer une version Open source de Zimbra.                                          ==\e[0m";
		echo -e "\e[33m==       Afin que l'installation se fasse correctement, veillez à ce que les éléments suivants soient correctement configurés :        ==\e[0m";
		echo -e "\e[33m==          - Ce script doit être exécuté IMPERATIVEMENT en tant qu'utilisateur root                                                   ==\e[0m";
		echo -e "\e[33m==          - La configuration IP du serveur a été réalisée et est statique                                                            ==\e[0m";
		echo -e "\e[33m==          - Le fichier /etc/hosts: indiquez les éléments suivants : IP_SERVEUR	  FQDN_SERVEUR                                 ==\e[0m";
		echo -e "\e[33m==                  Exemple : 192.168.0.12    serveurmail.example.com                                                                  ==\e[0m";
		echo -e "\e[33m==          - Votre serveur DNS : Ajoutez un enregistrement MX ainsi qu'un enregistrement A pointant sur le serveur mail               ==\e[0m";
		echo -e "\e[33m==                  Exemple : @	IN  MX	10  mail.example.com   et mail IN A 192.168.0.12                                               ==\e[0m";
		echo -e "\e[33m==          - Vous êtes connecté à Internet et le serveur DNS arrive à joindre le serveur auquel Zimbra sera installé                  ==\e[0m";
		echo -e "\e[33m==          - Les utilitaires tar et wget sont installés et fonctionnel.                                                               ==\e[0m";
		echo -e "\e[33m=========================================================================================================================================\e[0m";
		read -p "Etes vous sur de vouloir installer Zimbra ? [Y/N]" ANSWER ;
		if [ $ANSWER = "Y" ];
			then
				read -p "nom du serveur auquel vous voulez installer Zimbra (Mettre sous la forme suivante : serveurmail ) " serveur_name ;
				read -p "Nom du domaine du serveur ( example.com ) " DN ;
				FQDN=$serveur_name.$DN ; 
				read -p "Le FQDN du serveur est donc : ('$FQDN')[Y/N] ? " verification ;
 				if [ $verification = "Y" ] ;
					then 
						wget https://github.com/maldua/zimbra-foss-builder/releases/download/zimbra-foss-build-ubuntu-22.04/10.1.4/zcs-10.1.4_GA_4200000.UBUNTU22_64.20241224171952.tgz  ;
						tar zxvf zcs-10.1.4_GA_4200000.UBUNTU22_64.20241224171952.tgz ;
						cd  zcs-10.1.4_GA_4200000.UBUNTU22_64.20241224171952 ;
						./install.sh  ;
						su - zimbra -c "zmprov ms $FQDN zimbraMailSSLPort 443 | zmprov ms $FQDN zimbraMailSSLProxyPort 8443"
						su - zimbra -c "zmcontrol restart"
						echo "Vous pouvez désormais accéder au webmail sur l'adresse suivante : $FQDN et mail.$DN" ; 
      						read -p "Voulez vous mettre en place un script permettant l'enregistrement des états du serveur dans un fichier ? [Y/N]" log ;
	    					if [ $log = "Y" ];
	  						then
								mkdir /log ;
      								mkdir /log/zimbra ;
								chown -R zimbra:zimbra /log/zimbra  ;
								chmod 770 /log/zimbra ; 
								wget https://raw.github.com/e-paquelet/rbd/main/zupdate.sh 
								mkdir /root/script ;
								mv zupdate.sh /root/script ;
								chmod +x /root/script/zupdate.sh 
								echo "0 22 * * * /root/script/zupdate.sh" | crontab -
						else
      							exit 0 ; 
	     					fi	   					
				else  
						exit 1 ; 
				fi
		fi

elif [ $APP = "webmin" ];
	then
	echo -e "\e[33m=========================================================================================================================================\e[0m";
		echo -e "\e[33m========================================================[   Prerequisite    ]============================================================\e[0m";
		echo -e "\e[33m==                                  Ce script va installer l'interface d'administration web de serveur Webmin                          ==\e[0m";
		echo -e "\e[33m==       Afin que l'installation se fasse correctement, veillez à ce que les éléments suivants soient correctement configurés :        ==\e[0m";
		echo -e "\e[33m==                                                                                                                                     ==\e[0m";
		echo -e "\e[33m==          - La configuration IP du serveur a été réalisée et est statique                                                            ==\e[0m";
        	echo -e "\e[33m==          - Vous êtes connecté à Internet                                                                                            ==\e[0m";	
		echo -e "\e[33m=========================================================================================================================================\e[0m";
		apt-get install curl -y ;
		curl -o webmin-setup-repo.sh https://raw.githubusercontent.com/webmin/webmin/master/webmin-setup-repo.sh ;
		sh webmin-setup-repo.sh ;
		apt-get install webmin --install-recommends -y ;
		echo  "Webmin installé et fonctionnel sur le port 10 000";
elif [ $APP = "script" ];
	then
		read -p "Voulez vous télécharger et mettre en palce un script de synchronisation entre Zimbra et l'AD (La configuration de  l'Authentification Externe par Active Directory devra être réalisé avant d'exécuter le script. Cependant, si vous répondez par [Y], le téléchargement du script et la configuration de son environnement s feront automatiquement. Dans le cas contraire, il faudra créer un dossier spécial dans /opt/zimbra, lui attribuer des droits 755, changer le propriétaire de root à zimbra et exécuter le script dans ce dossier précis " SYNC ;
	 	if [ $SYNC = "Y" ];
       			then
	      			wget https://raw.github.com/e-paquelet/rbd/main/sync.sh
	      			chmod +x sync.sh
	      			./sync.sh 
	      	else 
	    			exit 1;
	   	fi
	
else 
	echo -e "\e[34m Fin du script, installation du script de synchronisation entre Active Directory et Zimbra annulé\e[0m";
fi ;

#!/bin/bash

read -p "Ce script installera automatiquement un script de synchronisation entre Zimbra et l'Active Directory [Y/N]" APP ;

if [ $APP =  "Y" ]; 
	then
		echo -e "\e[33m=========================================================================================================================================\e[0m";
		echo -e "\e[33m=====================================================[   Notice d'utilisation    ]=======================================================\e[0m";
		echo -e "\e[33m==                Ce script va installer un script de synchronisation entre l'Active Directory et Zimra pour Ubuntu 22.                ==\e[0m";
		echo -e "\e[33m==       Afin que le script fonctionne correctement, assurez vous que la version de Zimbra que vous utilisez soit :                    ==\e[0m";
		echo -e "\e[33m==          - Zimbra FOSS v 10.1.4 (lien de téléchargement : https://maldua.github.io/zimbra-foss-builder/downloads.html               ==\e[0m";
		echo -e "\e[33m==          - Ce script doit être exécuté IMPERATIVEMENT en tant qu'utilisateur root                                                   ==\e[0m";
		echo -e "\e[33m==          - Zimbra doit avoir été installée                                                                                          ==\e[0m";
		echo -e "\e[33m==          - L'authentification par Active Directory Externe doit avoir été configuré sur Zimbra.                                     ==\e[0m";
		echo -e "\e[33m==          - Assurez vous d'avoir créer les comptes d'administrations de Zimbra également dans l'Active Directory                     ==\e[0m";
		echo -e "\e[33m==          - Ces comptes d'administrations doivent être dans une UO (Unité d'Organisation) différente des UO que vous souhaitez lier  ==\e[0m";
		echo -e "\e[33m==          pour la synchronisation avec l'Active Directory. Le script n'ira chercher les comptes que dans une UO distinctive.         ==\e[0m";
		echo -e "\e[33m==          Les sous UO présentent dans cette UO distinctive sont prise en compte par le script par récurrence.                        ==\e[0m";
    echo -e "\e[33m==          Exemple : Voici une arbre représentant l'arborescence de l'Active Directory :                                              ==\e[0m";
    echo -e "\e[33m== 📁 mondomaine.local\e[0m"
    echo -e "\e[33m== │\e[0m"
    echo -e "\e[33m== ├── 📁 Builtin\e[0m"
    echo -e "\e[33m== ├── 📁 Computers\e[0m"
    echo -e "\e[33m== ├── 📁 Domain Controllers\e[0m"
    echo -e "\e[33m== │   ├── 📄 Policies\e[0m"
    echo -e "\e[33m== │   └── 📁 <Nom_du_DC>\e[0m"
    echo -e "\e[33m== ├── 📁 ForeignSecurityPrincipals\e[0m"
    echo -e "\e[33m== ├── 📁 Managed Service Accounts\e[0m"
    echo -e "\e[33m== ├── 📁 Program Data\e[0m"
    echo -e "\e[33m== ├── 📁 System\e[0m"
    echo -e "\e[33m== │   ├── 📁 Policies\e[0m"
    echo -e "\e[33m== │   ├── 📁 Scripts\e[0m"
    echo -e "\e[33m== │   └── 📁 DFS-Configuration\e[0m"
    echo -e "\e[33m== ├── 📁 Users\e[0m"
    echo -e "\e[33m== │   ├── 👤 Administrateur\e[0m"
    echo -e "\e[33m== │   ├── 👤 Invité\e[0m"
    echo -e "\e[33m== │   ├── 👥 Utilisateurs du domaine\e[0m"
    echo -e "\e[33m== │   ├── 👥 Administrateurs du domaine\e[0m"
    echo -e "\e[33m== │   ├── 👥 Opérateurs de comptes\e[0m"
    echo -e "\e[33m== │   ├── 👥 Opérateurs de sauvegarde\e[0m"
    echo -e "\e[33m== │   ├── 👥 Opérateurs serveur\e[0m"
    echo -e "\e[33m== │   ├── 👥 Opérateurs d'impression\e[0m"
    echo -e "\e[33m== │   └── ...\e[0m"
    echo -e "\e[33m== └── 📁 Utilisateurs \e[0m"
    echo -e "\e[33m== |   ├── 📁 direction\e[0m"
    echo -e "\e[33m== |   ├── 📁 service_info\e[0m"
    echo -e "\e[33m== |       ├── 👤 Jean\e[0m"
    echo -e "\e[33m== |   ├── 👤 Pierre\e[0m"
    echo -e "\e[33m== Dans l'UO Utilisateurs, tous les utilisateurs, qu'ils soient dans l'UO principale <<Utilisateur>> ou dans une sous UO <<service_info>>          ==\e[0m";
    echo -e "\e[33m== seront pris en compte par le script. Cependant, les autres utilisateurs "Invités" ... ne seront pas pris en compte.                             ==\e[0m";
    echo -e "\e[33m== Je vous conseille donc de mettre les comptes administrateurs dans l'UO "Users" et non "Utilisateurs" pour éviter des problèmes 		      ==\e[0m";
    echo -e "\e[33m== lors de l'exécution du script : mauvais alignements des noms d'utilisateurs à leurs prénoms par exemple.                                        ==\e[0m"; 
    echo -e "\e[33m== Pour lier les comptes admin dans zimbra à leurs comptes dans l'AD, il suffit de configurer l'authentification avec l'Active Directory 	      ==\e[0m";
    echo -e "\e[33m== dans zimbra puis indiquer dans les paramètres utilisateurs des comptes d'administration de zimbra dans l'option <<Authentification Externe>>    ==\e[0m";
    echo -e "\e[33m== leur login de l'Active Directory. Cette option dans l'Active Directory se trouve dans l'onglet <<Compte>> des propriétés des utilisateurs.      ==\e[0m";
    echo -e "\e[33m== En cas de mauvaise compréhension, ne pas hésiter à me contacter <<etienne.paquelet@gmail.com>>                                                  ==\e[0m";
    echo -e "\e[33m== - Pour que le script soit fonctionnel, il faudra modifier plusieurs variables en fonction de votre environnement :                              ==\e[0m";
    echo -e "\e[33m== 		- DOMAIN_NAME=<<votredomain.local>>                                                                                                   ==\e[0m";
    echo -e "\e[33m==   	- domain_name=<<votredomaine.local>>                                                                                                  ==\e[0m";
    echo -e "\e[33m==   	- ADServer=<<IP_Serveur_AD>>                                                                                                          ==\e[0m";
    echo -e "\e[33m==   	- ADUser=<<utilisateur_lien>> Ce compte sert à faire la liaison entre AD et Zimbra. Il faut que ce soit un compte de AD présent       ==\e[0m";
    echo -e "\e[33m==   			dans UO Users, comme pour les comptes admins de Zimbra								      ==\e[0m";
    echo -e "\e[33m== 		- ADUserpass=<<mot de passe de l utilisateur>>                                                                                        ==\e[0m";
    echo -e "\e[33m== - Assurez vous que le répertoire zadsync (où sera stocké le script de synchronisation) appartienne bien à l utilisateur zimbra et		      ==\e[0m";
    echo -e "\e[33m== qu il possède des droit 755 une fois ce script terminé											      ==\e[0m";
    echo -e "\e[33m=====================================================================================================================================================\e[0m";

  else 
  	echo "lol" ;
   fi

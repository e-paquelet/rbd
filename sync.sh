#!/bin/bash

read -p "Ce script installera automatiquement un script de synchronisation entre Zimbra et l'Active Directory [Y/N]" APP ;

if [ $APP =  "Y" ]; 
	then
		echo -e "\e[33m=========================================================================================================================================\e[0m";
		echo -e "\e[33m========================================================[   Prerequisite    ]============================================================\e[0m";
		echo -e "\e[33m==                         Ce script va installer un script de synchronisation entre l'Active Directory et Zimra.                      ==\e[0m";
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
		echo -e "\e[33m=========================================================================================================================================\e[0m";

  else 
  	echo "lol" ;
   fi

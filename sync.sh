#!/bin/bash

read -p "Ce script installera automatiquement un script de synchronisation entre Zimbra et l'Active Directory" APP ;

if [ $APP =  "Zimbra" ]; 
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
    echo -e "\e[33m== 📁 mondomaine.local"
    echo -e "\e[33m== │"
    echo "├── 📁 Builtin"
    echo "├── 📁 Computers"
    echo "├── 📁 Domain Controllers"
    echo "│   ├── 📄 Policies"
    echo "│   └── 📁 <Nom_du_DC>"
    echo "├── 📁 ForeignSecurityPrincipals"
    echo "├── 📁 Managed Service Accounts"
    echo "├── 📁 Program Data"
    echo "├── 📁 System"
    echo "│   ├── 📁 Policies"
    echo "│   ├── 📁 Scripts"
    echo "│   └── 📁 DFS-Configuration"
    echo "├── 📁 Users"
    echo "│   ├── 👤 Administrateur"
    echo "│   ├── 👤 Invité"
    echo "│   ├── 👥 Utilisateurs du domaine"
    echo "│   ├── 👥 Administrateurs du domaine"
    echo "│   ├── 👥 Opérateurs de comptes"
    echo "│   ├── 👥 Opérateurs de sauvegarde"
    echo "│   ├── 👥 Opérateurs serveur"
    echo "│   ├── 👥 Opérateurs d'impression"
    echo "│   └── ..."
    echo "└── 📁 <Autres Unités Organisationnelles personnalisées si créées>"

		echo -e "\e[33m=========================================================================================================================================\e[0m";

#!/bin/bash

read -p "Ce script installera automatiquement un script de synchronisation entre Zimbra et l'Active Directory [Y/N] " APP

if [ "$APP" = "Y" ]; then
    cat << EOF | less
================================================================================================================
=========================================[   Notice d'utilisation    ]==========================================
==  Ce script va installer un script de synchronisation entre l'Active Directory et Zimbra pour Ubuntu 22.
==  Afin que le script fonctionne correctement, assurez-vous que la version de Zimbra que vous utilisez soit :
==      - Zimbra FOSS v 10.1.4 (lien de téléchargement : https://maldua.github.io/zimbra-foss-builder/downloads.html)
==      - Ce script doit être exécuté IMPÉRATIVEMENT en tant qu'utilisateur root.
==      - Zimbra doit avoir été installée.
==      - L'authentification par Active Directory Externe doit avoir été configurée sur Zimbra.
==      - Assurez-vous d'avoir créé les comptes d'administration de Zimbra également dans l'Active Directory.
==      - Ces comptes d'administration doivent être dans une UO (Unité d'Organisation) différente des UO que vous souhaitez lier.
==      - Les sous-UO présentes dans cette UO distinctive sont prises en compte par le script par récurrence.
==      
==  Exemple : Voici une arborescence de l'Active Directory :
==  
== 📁 mondomaine.local
== │
== ├── 📁 Builtin
== ├── 📁 Computers
== ├── 📁 Domain Controllers
== │   ├── 📄 Policies
== │   └── 📁 <Nom_du_DC>
== ├── 📁 ForeignSecurityPrincipals
== ├── 📁 Managed Service Accounts
== ├── 📁 Program Data
== ├── 📁 System
== │   ├── 📁 Policies
== │   ├── 📁 Scripts
== |   └── 📁 DFS-Configuration
== ├── 📁 Users
== │   ├── 👤 Administrateur
== │   ├── 👤 Invité
== │   ├── 👥 Utilisateurs du domaine
== │   ├── 👥 Administrateurs du domaine
== │   ├── 👥 Opérateurs de comptes
== │   ├── 👥 Opérateurs de sauvegarde
== │   ├── 👥 Opérateurs serveur
== │   ├── 👥 Opérateurs d'impression
== │   └── ...
== └── 📁 Utilisateurs
==     ├── 📁 direction
==     ├── 📁 service_info
==     |   ├── 👤 Jean
==     └── 👤 Pierre
==       
==  - Dans l'UO <<Utilisateurs>>, tous les utilisateurs seront pris en compte par le script.
==  - Cependant, les autres utilisateurs <<Invités>> ne seront pas pris en compte.
==  - Il est conseillé de mettre les comptes administrateurs dans l'UO <<Users>> et non <<Utilisateurs>>.
== 
==  - Configuration requise :
==      - DOMAIN_NAME=votredomaine.local
==      - domain_name=votredomaine.local
==      - ADServer=IP_Serveur_AD
==      - ADUser=utilisateur_lien (compte AD dans UO Users)
==      - ADUserpass=mot_de_passe
==
==  - Assurez-vous que le répertoire zadsync appartienne bien à l'utilisateur Zimbra avec les droits 755.
================================================================================================================
EOF
mkdir /opt/zimbra/zadsync
wget https://raw.github.com/e-paquelet/rbd/main/adsync.sh 
mv adsync.sh /opt/zimbra/zadsync/ 
chown -R zimbra:zimbra /opt/zimbra/zadsync
chmod -R 755 /opt/zimbra/zadsync
chmod +x /opt/zimbra/zadsync/adsync.sh 
echo "#*/5 * * * * /opt/zimbra/zadsync/adsync.sh >> /opt/zimbra/zadsync/adsync.log 2>&1" | sudo -u zimbra crontab -
echo "tâche ajoutée au crontab. Il faudra la décommenter pour qu'elle fonctionne. Modifiez les variables comme indiqué dans la notice pour que le script soit fonctionnel" ;
echo "Une fois le script modifié pour prendre en compte les variables de votre environnement, rendez vous dans le répertoire du script et faites ./adsync.sh";  
else
    echo "Annulation de l'installation." ;
fi

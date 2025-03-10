#!/bin/bash

read -p "Ce script installera automatiquement un script de synchronisation entre Zimbra et l'Active Directory [Y/N] " APP

if [ "$APP" = "Y" ]; then
    (
        echo "================================================================================================================"
        echo "========================================= [   Notice d'utilisation    ] ========================================="
        echo "Ce script va installer un script de synchronisation entre l'Active Directory et Zimbra pour Ubuntu 22."
        echo "Afin que le script fonctionne correctement, assurez-vous que la version de Zimbra que vous utilisez soit :"
        echo "  - Zimbra FOSS v 10.1.4 (lien : https://maldua.github.io/zimbra-foss-builder/downloads.html)"
        echo "  - Ce script doit être exécuté IMPÉRATIVEMENT en tant qu'utilisateur root"
        echo "  - Zimbra doit être installée"
        echo "  - L'authentification par Active Directory Externe doit être configurée sur Zimbra."
        echo "  - Les comptes d'administration de Zimbra doivent être créés dans l'Active Directory."
        echo "  - Ces comptes doivent être dans une UO distincte de celles que vous souhaitez synchroniser."
        echo ""
        echo "Exemple d'arborescence de l'Active Directory :"
        echo "📁 mondomaine.local"
        echo "│"
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
        echo "└── 📁 Utilisateurs"
        echo "    ├── 📁 direction"
        echo "    ├── 📁 service_info"
        echo "    │   ├── 👤 Jean"
        echo "    ├── 👤 Pierre"
        echo ""
        echo "Tous les utilisateurs dans l'UO Utilisateurs et ses sous-UO seront pris en compte."
        echo "Cependant, les autres utilisateurs (ex: Invités) ne seront pas pris en compte."
        echo "Il est conseillé de mettre les comptes administrateurs dans l'UO 'Users' et non 'Utilisateurs'."
        echo ""
        echo "Configuration requise dans Zimbra :"
        echo "  - Configurer l'authentification avec l'Active Directory"
        echo "  - Associer chaque compte Zimbra admin à son compte AD via l'option 'Authentification Externe'"
        echo "  - Cette option se trouve dans l'onglet 'Compte' des propriétés des utilisateurs dans l'AD."
        echo ""
        echo "Si vous avez des questions, contactez-moi : etienne.paquelet@gmail.com"
        echo ""
        echo "Variables à modifier pour l'adapter à votre environnement :"
        echo "  - DOMAIN_NAME=\"votredomaine.local\""
        echo "  - domain_name=\"votredomaine.local\""
        echo "  - ADServer=\"IP_Serveur_AD\""
        echo "  - ADUser=\"utilisateur_lien\" (doit être dans UO Users)"
        echo "  - ADUserpass=\"motdepasse\""
        echo ""
        echo "Assurez-vous que le répertoire 'zadsync' appartient bien à l'utilisateur Zimbra et qu'il possède les droits 755."
        echo "================================================================================================================"
    ) | less


    apt-get update -y;
    apt-get upgrade -y;
else 
    echo "Annulation de l'installation."
fi

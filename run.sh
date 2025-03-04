#!/bin/bash

wget -L https://raw.github.com/e-paquelet/rbd/main/bashrc -O bashrc

# Vérifier que le fichier a bien été téléchargé
if [ ! -f bashrc ]; then
    echo "❌ Fichier bashrc introuvable ! Téléchargement échoué."
    exit 1
fi

# S'assurer que le fichier est au format Unix
sed -i 's/\r$//' bashrc

# Copier bashrc dans ~/.bashrc
cp bashrc ~/.bashrc

# Recharger la configuration du shell
source ~/.bashrc

echo "✅ Configuration appliquée !"

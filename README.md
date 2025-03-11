}----------------------------Ce répertoire contient différents script d'automatisation------------------------------------{
Les différents scripts sont les suivants : 

- run.sh : remplace le .bashrc par défaut par le .bashrc de ce repertoire.
- zupdate.sh : création d'une tâche planifié concernant un serveur zimbra. Le script récupère l'état du serveur et l'inscrit dans un fichier zimbra_status_$(date +%D).txt  du répertoire /log/zimbra
- zinstall.sh : Permet l'installation automatique  d'un serveur zimbra version 10.1.4. Permet également l'installation d'un serveur Webmin et de l'installation d'un script de synchronisation entre AD et ZImbra
- sync.sh : Permet la création de l'environnement nécessaire au fonctionnement du script de synchronisation entre l'AD et Zimbra (Création d'un répertoire dédié, mis en place des droits...)
- adsync.sh : Script de synchronisation entre l'AD et Zimbra 

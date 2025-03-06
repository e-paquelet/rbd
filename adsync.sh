#!/bin/bash
#Script de SYNC AD --> Zimbra
#Script sous license GNU/GPL
#ROSENKRANZ Denis
#denisrosenkranz.com
#Modifié par Etienne PAQUELET
#SCRIPT A LANCER EN TANT QU’UTILISATEUR « zimbra »
#Déclaration des variables:
#Nom de domaine Active Directory
DOMAIN_NAME="domtest.local" ;
domain_name="domtest.local" ;

#Fichiers temporaires ou seront stockés les données de comptes
Names=Names.txt ;
Firstnames=FirstNames.txt ;
username=Nicks.txt ;
ADAccounts=Accounts.txt ;
ZAccounts=Zmbusers.txt ;
externauth=Mails.txt ;

#Paramètres sur serveur AD
#FQDN Du serveur Active Directory
ADServer="192.168.229.129" ;
#Nom d'un utilisateur
ADUser="ldap_mail" ;
#Mot de passe de cet utilisateur
ADUserpass="tpRT9025" ;

#On récupère les informations des comptes sur l'active directory
#Dans ce contexte, les comptes à récupérer de trouvent dans l'OU Utilisateurs"

#Récupération des noms exemple : paquelet
ldapsearch -x -H ldap://$ADServer -b "OU=Utilisateurs,DC=domtest,DC=local" -D "CN=$ADUser, CN=Users,DC=domtest,DC=local" -w $ADUserpass "(&(sAMAccountName=*)(objectClass=user))" | grep sn | awk '{print $2}' > $Names ; 

#Récupérations des prénoms exemple : etienne
ldapsearch -x -H ldap://$ADServer -b  "OU=Utilisateurs, DC=domtest,DC=local" -D  "CN=$ADUser, CN=Users, DC=domtest, DC=local" -w $ADUserpass  "( & ( sAMAccountName=*) (objectClass=user))" | grep givenName | awk ' { print $2 } ' > $Firstnames ;


#Récupérations des noms d'utilisateurs de l'AD qu'ils utilise pour se connecter aux PC. Exemple : ep@domtest.local
#ldapsearch -x -H ldap://$ADServer -b "OU=Utilisateurs, DC=domtest,DC=local" -D "CN=$ADUser, CN=Users,  DC=domtest, DC=local" -w $ADUserpass "(&(sAMAccountName=*)(objectClass=user))" | grep sAMAccountName | awk '{print $1}' > $username ;
ldapsearch -x -H ldap://$ADServer -b "OU=Utilisateurs, DC=domtest,DC=local" -D "CN=$ADUser, CN=Users,  DC=domtest, DC=local" -w $ADUserpass "(&(sAMAccountName=*)(objectClass=user))" | grep sAMAccountName | grep -v "filter:" | cut -d " " -f2  > $username ;

#Transformation des noms d'utilisateurs en adresses Emails pour option authentification externe 

cat -A $username ; 
echo "";
#rm email.txt
rm zimbraauth.txt ;

while read -r line; do
	echo "$line@$domain_name" >> zimbraauth.txt ;
done < "$username" 


prefixe=prefixe.txt
paste -d '.' $Firstnames $Names >  $prefixe;
truncate -s 0 email.txt ;
email=email.txt ; 
while read -r line2; do
	echo "$line2@$domain_name" >> $email ; 
done < "$prefixe" 

lower=fichier.txt
cat $email | tr '[:upper:]' '[:lower:]' > $lower ;

cat $lower 
temp=temp.txt ;
zmprov -l gaa | tee  $temp ;

sort $lower -o $lower ;
sort $temp -o $temp ;


comm -23 $lower $temp > missing_in_zimbra.txt ;



while IFS= read -r line; do
	echo "Adresse email : $line";
	zmprov ca $line  "" ;
	echo "création adresse mail sur zimbra $line" ;
done < missing_in_zimbra.txt ;

while IFS= read -r email; do
    # Extraire prénom.nom avant le @
    username=$(echo "$email" | cut -d '@' -f1)

    # Convertir en format attendu : prendre la première lettre du prénom + nom
    firstname=$(echo "$username" | cut -d '.' -f1)
    lastname=$(echo "$username" | cut -d '.' -f2)
    sn_candidate="${lastname}${firstname:0:2}@domtest.local"  # Ex: ploufc@domtest.local

    # Vérifier si ce sn existe dans zimbraauth.txt
    if grep -q "^$sn_candidate$" zimbraauth.txt; then
        echo "Ajout de l'authentification AD pour $email avec sn=$sn_candidate"
        zmprov ma "$email" zimbraAuthLdapExternalDN "$sn_candidate"
    else
        echo "⚠ Aucun sn trouvé pour $email, impossible d'ajouter l'authentification AD."
    fi
done < missing_in_zimbra.txt

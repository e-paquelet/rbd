#!/bin/bash
#Script de SYNC AD --> Zimbra
echo -e "\e[41m ===============================================================================================================================\e[0m"
echo -e "\e[32m $(date +%D%T) \e[0m" ;

#Déclaration des variables:
#Nom de domaine Active Directory
DOMAIN_NAME="" ;
domain_name="" ;
DCprinc="";
DCsec="";

#Fichiers temporaires ou seront stockés les données de comptes
Names=/opt/zimbra/zadsync/Names.txt ;
Firstnames=/opt/zimbra/zadsync/FirstNames.txt ;
username=/opt/zimbra/zadsync/Nicks.txt ;
#ADAccounts=/opt/zimbra/zadsync/Accounts.txt ;
#ZAccounts=/opt/zimbra/zadsync/Zmbusers.txt ;
#externauth=/opt/zimbra/zadsync/Mails.txt ;

#Paramètres sur serveur AD
#FQDN Du serveur Active Directory
ADServer="" ;
#Nom d'un utilisateur
ADUser="" ;
#Mot de passe de cet utilisateur
ADUserpass="" ;

#On récupère les informations des comptes sur l'active directory
#Dans ce contexte, les comptes à récupérer de trouvent dans l'OU Utilisateurs"

#Récupération des noms exemple : paquelet
/opt/zimbra/common/bin/ldapsearch -x -H ldap://$ADServer -b "OU=Utilisateurs,DC=$DCprinc,DC=$DCsec" -D "CN=$ADUser, CN=Users,DC=$DCprinc,DC=$DCsec" -w $ADUserpass "(&(sAMAccountName=*)(objectClass=user))" | grep sn | awk '{print $2}' > $Names ; 

#Récupérations des prénoms exemple : etienne
/opt/zimbra/common/bin/ldapsearch -x -H ldap://$ADServer -b  "OU=Utilisateurs, DC=$DCprinc,DC=$DCsec" -D  "CN=$ADUser, CN=Users, DC=$DCprinc, DC=$DCsec" -w $ADUserpass  "( & ( sAMAccountName=*) (objectClass=user))" | grep givenName | awk ' { print $2 } ' > $Firstnames ;


#Récupérations des noms dutilisateurs de lAD qu'ils utilise pour se connecter aux PC. Exemple : ep@domtest.local
/opt/zimbra/common/bin/ldapsearch -x -H ldap://$ADServer -b "OU=Utilisateurs, DC=$DCprinc,DC=$DCsec" -D "CN=$ADUser, CN=Users,  DC=$DCprinc, DC=$DCsec" -w $ADUserpass "(&(sAMAccountName=*)(objectClass=user))" | grep sAMAccountName | grep -v "filter:" | cut -d " " -f2  > $username ;

#Transformation des noms d'utilisateurs en adresses Emails pour option authentification externe 

echo -e "\e[36m login des utilisateurs de l'AD \e[0m"
cat -A $username ; 
echo "";
#rm email.txt
rm /opt/zimbra/zadsync/zimbraauth.txt ;

while read -r line; do
	echo "$line@$domain_name" >> /opt/zimbra/zadsync/zimbraauth.txt ;
done < "$username" 

#transformation du prénom et du nom des utilisateur de l'AD pour former leur adresses mail de zimbra
echo -e "\e[35m adresses mail des utilisateurs de l'AD\e[0m"
prefixe=/opt/zimbra/zadsync/prefixe.txt
paste -d '.' $Firstnames $Names >  $prefixe;
truncate -s 0 /opt/zimbra/zadsync/email.txt ;
email=/opt/zimbra/zadsync/email.txt ; 
while read -r line2; do
	echo "$line2@$domain_name" >> $email ; 
done < "$prefixe" 
cat $email ;

#Formattage des adresses mail en minuscule
echo -e "\e[34m Formattage des adresses mail en minuscule \e[0m" ;
lower=/opt/zimbra/zadsync/email_lowercase.txt
cat $email | tr '[:upper:]' '[:lower:]' > $lower ;

cat $lower 

#récupération des adresses mails présentent dans zimbra
echo -e "\e[31m Récupération des adresses mails présentent dans zimbra \e[0m" ;
temp=/opt/zimbra/zadsync/email_zimbra.txt ;
/opt/zimbra/bin/zmprov -l gaa | tee  $temp ;

sort $lower -o $lower ;
sort $temp -o $temp ;

#différenciation des adresses mail de zimbra et celle crée depuis les prénoms et noms des users de l'AD
echo -e "\e[30m différenciation des adresses mail de zimbra et celles crée depuis les prénoms et les noms des users de l'AD\e[30m "
comm -23 $lower $temp > /opt/zimbra/zadsync/missing_in_zimbra.txt ;

cat /opt/zimbra/zadsync/missing_in_zimbra.txt ;
#Création des adresses mails non présentent dans zimbra ==> celles qui sont présentent dans le fichier missing_in_zimbra.txt
echo -e "\e[42m Création des adresses mails non présentent dans zimbra ==> celles qui sont présentent dans le fichier missing_in_zimbra.txt \e[0m"
while IFS= read -r line; do
	echo "Adresse email : $line";
	/opt/zimbra/bin/zmprov ca $line  "" ;
	echo "création adresse mail sur zimbra $line" ;
done < /opt/zimbra/zadsync/missing_in_zimbra.txt ;

#ajout des logins de l'AD aux adresses mails créés pour quils puissent se connecter avec leurs mot de passes AD
echo -e "\e[35m ajout des logins de l'AD aux adresses mails créés pour qu'ils puissent se connecter avec leurs mot de passe AD\e[0m" 
while IFS= read -r email; do
    # Extraire prénom.nom avant le @
    username=$(echo "$email" | cut -d '@' -f1)

    # Convertir en format attendu : prendre les deux premières lettre du prénom + nom
    firstname=$(echo "$username" | cut -d '.' -f1)
    lastname=$(echo "$username" | cut -d '.' -f2)
    sn_candidate="${lastname}_${firstname:0:2}@domtest.local"  # Ex: paquelet_et@exemple.com

    # Vérifier si ce sn existe dans zimbraauth.txt
    if grep -q "^$sn_candidate$" /opt/zimbra/zadsync/zimbraauth.txt; then
        echo "Ajout de l'authentification AD pour $email avec sn=$sn_candidate"
        /opt/zimbra/bin/zmprov ma "$email" zimbraAuthLdapExternalDN "$sn_candidate"
    else
        echo "⚠ Aucun sn trouvé pour $email, impossible d'ajouter l'authentification AD."
    fi
done < /opt/zimbra/zadsync/missing_in_zimbra.txt

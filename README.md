# 📌 Scripts d'Automatisation

Ce répertoire contient divers scripts facilitant l'automatisation de tâches administratives, notamment pour la gestion d'un serveur **Zimbra**.

---

## 📂 Contenu du Répertoire

| 📜 **Script**      | 📝 **Description** |
|-------------------|-----------------|
| **`run.sh`**       | Remplace le `.bashrc` par défaut par celui de ce répertoire. |
| **`zupdate.sh`**   | Planifie une tâche cron pour surveiller l’état du serveur Zimbra. Il génère un fichier `zimbra_status_$(date +%D).txt` dans `/log/zimbra/`. |
| **`zinstall.sh`**  | Automatise l’installation d’un serveur **Zimbra 10.1.4**, **Webmin**, et du script de synchronisation entre **Active Directory (AD)** et **Zimbra**. |
| **`sync.sh`**      | Prépare l’environnement pour la synchronisation **AD ↔ Zimbra** (création d’un répertoire, attribution des droits…). |
| **`adsync.sh`**    | Effectue la synchronisation entre **Active Directory** et **Zimbra**. |

---

## 📌 Notes
- Tous les scripts doivent être exécutés avec les **droits root**.   
- `zupdate.sh` repose sur une tâche **cron** pour fonctionner en continu.  

---

📌 **Auteur** : [Etienne PAQUELET ]  
📌 **GitHub** : [https://e-paquelet.fr]  

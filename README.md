# Script de sauvegarde automatique en Bash

**Auteur** : Dannie Junior FIENI ([JuFiSec](https://github.com/JuFiSec))  
*Étudiant en Master 1 Cybersécurité & Cloud Computing à l'IPSSI Nice*

## 🎯 Objectif

Ce projet contient un script Bash robuste conçu pour automatiser la sauvegarde de répertoires sur un système Linux. L'objectif est de fournir un outil fiable, configurable et facile à utiliser pour la gestion des backups, en intégrant des fonctionnalités essentielles en environnement de production comme la journalisation et la rotation.

Ce projet a été réalisé dans le cadre de ma montée en compétences sur les systèmes Linux et les pratiques DevOps.

---
## ⚙️ Installation et Utilisation

Suivez ces étapes pour télécharger et exécuter le script sur votre machine.

**1. Cloner le dépôt**

Ouvrez votre terminal et clonez ce dépôt GitHub :
```bash
git clone https://github.com/JuFiSec/linux-backup-script.git
```

**2. Naviguer dans le dossier du projet**
```bash
cd linux-backup-script
```

**3. Rendre le script exécutable**

Cette commande donne au système la permission d'exécuter le fichier. Vous n'avez besoin de le faire qu'une seule fois.
```bash
chmod +x backup.sh
```

**4. Lancer le script**

Exécutez le script en spécifiant le dossier source à sauvegarder et le dossier de destination où l'archive sera créée.
```bash
# Syntaxe
./backup.sh /chemin/vers/votre/source /chemin/vers/votre/destination

# Exemple concret
./backup.sh ~/Documents /var/backups/mes_documents
```
L'opération se lance, et tous les détails seront enregistrés dans le fichier `logs/backup.log`.

---

## ⚙️ Fonctionnalités Détaillées

Le script `backup.sh` intègre plusieurs fonctionnalités pour garantir sa flexibilité et sa fiabilité :

* **Paramètres dynamiques** : Le script prend le dossier source et la destination en arguments, le rendant réutilisable pour n'importe quel besoin.
    ```bash
    ./backup.sh /chemin/vers/source /chemin/vers/destination
    ```

* **Horodatage précis** : Chaque archive est nommée avec le nom du dossier source et un horodatage au format `ANNEE-MOIS-JOUR-HEUREMINUTE` (ex: `documents-20250721-1130.tar.gz`), ce qui rend chaque sauvegarde unique et facile à trier.

* **Journalisation complète (Logging)** : Toutes les actions sont enregistrées dans le fichier `logs/backup.log`. Chaque ligne de log est horodatée, ce qui permet de suivre précisément le déroulement de chaque sauvegarde, de diagnostiquer les erreurs et de vérifier que tout s'est bien passé.

* **Rotation des sauvegardes** : Pour éviter de saturer l'espace disque, le script ne conserve que les `X` sauvegardes les plus récentes (configurable via la variable `RETENTION_COUNT`). Les archives plus anciennes sont automatiquement supprimées.

* **Gestion d'erreurs** : Le script vérifie si le dossier source existe et arrête l'exécution si la création de l'archive échoue, en enregistrant l'erreur dans le fichier de log.

* **Création automatique des dossiers** : Les répertoires de backup et de logs sont créés automatiquement s'ils n'existent pas, ce qui simplifie la première utilisation.

---

## 📸 Démonstration d'utilisation

La capture d'écran ci-dessous montre le déroulement complet : la gestion d'erreur (quand les arguments manquent), la création d'un dossier de test, l'exécution réussie du script, et le contenu final du fichier de log qui confirme le bon fonctionnement.

![Démonstration du script de sauvegarde](https://github.com/JuFiSec/linux-backup-script/blob/main/image_4c3711.png)


---

## ⏰ Automatisation avec Cron

Pour exécuter ce script automatiquement tous les jours à 2h du matin, ajoutez la ligne suivante à votre crontab (`crontab -e`).

```bash
0 2 * * * /chemin/complet/vers/backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```

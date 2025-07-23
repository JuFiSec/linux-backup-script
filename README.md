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

## ⏰ # Automatisation avec Cron - Guide Complet

## Introduction à Cron

Cron est un planificateur de tâches intégré aux systèmes Unix/Linux qui permet d'exécuter des scripts automatiquement à des heures précises. C'est l'outil parfait pour automatiser vos sauvegardes.

## Format de la syntaxe Cron

```
* * * * * commande-à-exécuter
│ │ │ │ │
│ │ │ │ └─── Jour de la semaine (0-7, où 0 et 7 = Dimanche)
│ │ │ └───── Mois (1-12)
│ │ └─────── Jour du mois (1-31)
│ └───────── Heure (0-23)
└─────────── Minute (0-59)
```

## Explication de notre ligne Cron

```bash
0 2 * * * /chemin/complet/vers/backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```

### Décomposition :
- **`0`** = À la minute 0
- **`2`** = À 2h du matin
- **`*`** = Tous les jours du mois
- **`*`** = Tous les mois
- **`*`** = Tous les jours de la semaine

**Résultat** : Le script s'exécute **tous les jours à 2h00 du matin**.

## Configuration étape par étape

### 1. Ouvrir l'éditeur crontab
```bash
crontab -e
```

### 2. Ajouter la ligne de planification
Ajoutez cette ligne à la fin du fichier :
```bash
0 2 * * * /home/votre-utilisateur/linux-backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```

⚠️ **Important** : Remplacez `/home/votre-utilisateur/linux-backup-script/` par le chemin réel où vous avez cloné le projet.

### 3. Sauvegarder et quitter
- Nano : `Ctrl+X`, puis `Y`, puis `Entrée`
- Vim : `:wq` puis `Entrée`

### 4. Vérifier que la tâche est enregistrée
```bash
crontab -l
```

## Exemples d'autres planifications

### Sauvegardes plus fréquentes
```bash
# Toutes les 6 heures
0 */6 * * * /chemin/vers/backup.sh /source /destination

# Tous les lundis à 3h du matin
0 3 * * 1 /chemin/vers/backup.sh /source /destination

# Le 1er de chaque mois à minuit
0 0 1 * * /chemin/vers/backup.sh /source /destination

# Du lundi au vendredi à 1h du matin (jours ouvrables)
0 1 * * 1-5 /chemin/vers/backup.sh /source /destination
```

## Conseils et bonnes pratiques

### 1. Utilisez des chemins absolus
❌ **Mauvais** :
```bash
0 2 * * * ./backup.sh ~/documents /mnt/backups
```

✅ **Bon** :
```bash
0 2 * * * /home/dannie/linux-backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```

### 2. Testez d'abord manuellement
Avant d'automatiser, assurez-vous que votre script fonctionne :
```bash
/home/dannie/linux-backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```

### 3. Vérifiez les permissions
```bash
# Le script doit être exécutable
chmod +x /home/dannie/linux-backup-script/backup.sh

# Vérifiez l'accès aux dossiers
ls -la /home/dannie/documents
ls -la /mnt/backups_externes
```

### 4. Surveillez les logs
Les logs du script sont dans `logs/backup.log`. Vous pouvez aussi rediriger les sorties de cron :
```bash
0 2 * * * /chemin/vers/backup.sh /source /destination >> /var/log/cron-backup.log 2>&1
```

## Dépannage

### Problème : La tâche cron ne s'exécute pas

1. **Vérifiez que le service cron tourne** :
```bash
sudo systemctl status cron
```

2. **Vérifiez la syntaxe cron** :
Utilisez un validateur en ligne comme [crontab.guru](https://crontab.guru/)

3. **Consultez les logs système** :
```bash
sudo grep CRON /var/log/syslog
```

### Problème : Permission refusée

Ajoutez les permissions complètes :
```bash
chmod 755 /home/dannie/linux-backup-script/backup.sh
```

### Problème : Chemin non trouvé

Utilisez la commande `which` pour trouver les chemins :
```bash
which bash
# Ajoutez #!/bin/bash en première ligne de votre script
```

## Variables d'environnement

Cron a un environnement limité. Ajoutez ces lignes au début de votre crontab si nécessaire :
```bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
HOME=/home/votre-utilisateur

0 2 * * * /chemin/vers/backup.sh /source /destination
```

## Arrêter ou modifier une tâche cron

```bash
# Voir toutes les tâches
crontab -l

# Modifier les tâches
crontab -e

# Supprimer toutes les tâches (attention !)
crontab -r
```

Cette configuration vous garantit des sauvegardes automatiques et fiables de vos données importantes !

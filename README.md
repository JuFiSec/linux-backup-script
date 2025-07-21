# 🔄 Script de sauvegarde automatique en Bash

**Auteur** : Dannie Junior FIENI ([JuFiSec](https://github.com/JuFiSec))  
*Étudiant en Master 1 Cybersécurité & Cloud Computing à l'IPSSI Nice*

## 🎯 Objectif

Ce projet contient un script Bash robuste conçu pour automatiser la sauvegarde de répertoires sur un système Linux. L'objectif est de fournir un outil fiable, configurable et facile à utiliser pour la gestion des backups, en intégrant des fonctionnalités essentielles en environnement de production comme la journalisation et la rotation.

Ce projet a été réalisé dans le cadre de ma montée en compétences sur les systèmes Linux et les pratiques DevOps.

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

## 📸 Captures d'écran

## 📸 Démonstration d'utilisation

La capture d'écran ci-dessous montre le déroulement complet : la gestion d'erreur (quand les arguments manquent), la création d'un dossier de test, l'exécution réussie du script, et le contenu final du fichier de log qui confirme le bon fonctionnement.

![Démonstration du script de sauvegarde](https://github.com/JuFiSec/nom-de-ton-repo/blob/main/image_4c3711.png)

*(**Note** : Pour que cette image s'affiche, tu dois uploader le fichier `image_4c3711.png` à la racine de ton dépôt GitHub, et ajuster le nom du repo dans l'URL ci-dessus si besoin.)*

---

## ⏰ Automatisation avec Cron

Pour exécuter ce script automatiquement tous les jours à 2h du matin, ajoutez la ligne suivante à votre crontab (`crontab -e`).

```bash
0 2 * * * /chemin/complet/vers/backup-script/backup.sh /home/dannie/documents /mnt/backups_externes
```
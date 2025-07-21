#!/bin/bash

# ==============================================================================
# Script de sauvegarde avec horodatage, logging et rotation.
#
# Auteur : Dannie FIENI
# Date : 21/07/2025
# ==============================================================================

# --- Validation des arguments ---
if [ "$#" -ne 2 ]; then
    echo "Erreur : Ce script nécessite exactement deux arguments."
    echo "Usage: $0 /chemin/source /chemin/destination"
    exit 1
fi

# --- Variables ---
SOURCE_DIR="$1"
BACKUP_PARENT_DIR="$2"
RETENTION_COUNT=5 # Nombre de sauvegardes à conserver

# Vérifier si le dossier source existe
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Erreur : Le dossier source '$SOURCE_DIR' n'existe pas."
    exit 1
fi

# Nom du dossier source (ex: "documents") pour nommer le backup
SOURCE_NAME=$(basename "$SOURCE_DIR")
TIMESTAMP=$(date +"%Y%m%d-%H%M")
FILENAME="$SOURCE_NAME-$TIMESTAMP.tar.gz"

# Création des dossiers de backup et de logs s'ils n'existent pas
LOG_DIR="logs"
mkdir -p "$BACKUP_PARENT_DIR"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/backup.log"

# --- Fonctions ---

# Fonction pour logger les messages avec un horodatage
log_message() {
    local message="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $message" >> "$LOG_FILE"
}

# --- Début du script ---

log_message "--- Début de la sauvegarde pour $SOURCE_DIR ---"

# --- Création de l'archive ---
log_message "Création de l'archive : $BACKUP_PARENT_DIR/$FILENAME"
tar -czf "$BACKUP_PARENT_DIR/$FILENAME" -C "$(dirname "$SOURCE_DIR")" "$SOURCE_NAME"

# Vérification si la commande tar a réussi
if [ $? -eq 0 ]; then
    log_message "Succès : L'archive a été créée avec succès."
else
    log_message "ERREUR : La création de l'archive a échoué."
    log_message "--- Fin de la sauvegarde avec erreurs ---"
    exit 1
fi

# --- Rotation des sauvegardes ---
log_message "Exécution de la rotation des sauvegardes (conservation des $RETENTION_COUNT plus récentes)."

# Lister les fichiers, les trier par date de modification (le plus récent en premier),
# sauter les 5 premiers et supprimer le reste.
ls -1t "$BACKUP_PARENT_DIR/$SOURCE_NAME-"*.tar.gz | tail -n +$((RETENTION_COUNT + 1)) | xargs -I {} rm -v -f {} >> "$LOG_FILE" 2>&1

log_message "Rotation terminée."
log_message "--- Fin de la sauvegarde ---"

echo "Opération de sauvegarde terminée. Consultez $LOG_FILE pour les détails."

exit 0
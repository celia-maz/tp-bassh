
#!/bin/bash

# Activer la gestion stricte des erreurs
set -Eeuo pipefail

# Définir le dossier à sauvegarder
DOSSIER="data"

# Définir le dossier de destination
DESTINATION="backups"

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier $DOSSIER n'existe pas" >&2
    exit 1
fi

# Créer le dossier de destination
mkdir -p "$DESTINATION"

# Générer la date et l'heure
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Créer le nom de l'archive
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

# Créer l'archive compressée
tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde créée : $ARCHIVE"

# Supprimer les sauvegardes de plus de 7 jours
for fichier in "$DESTINATION"/*.tar.gz; do
    [ -e "$fichier" ] || continue

    if [ -n "$(find "$fichier" -mtime +7 -print)" ]; then
        echo "Suppression de l'ancienne sauvegarde : $fichier"
        rm "$fichier"
    fi
done

echo "Sauvegarde terminée avec succès."


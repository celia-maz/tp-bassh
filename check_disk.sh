
#!/bin/bash

# Définir le seuil (80% par défaut)
SEUIL=${1:-80}

# Récupérer le pourcentage d'espace disque utilisé
UTILISATION=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

# Afficher les informations
echo "Utilisation du disque : $UTILISATION%"
echo "Seuil autorisé : $SEUIL%"

# Comparer l'utilisation avec le seuil
if [ "$UTILISATION" -ge "$SEUIL" ]; then
    echo "ALERTE : Espace disque presque plein !"
    exit 1
else
    echo "OK : Espace disque suffisant."
    exit 0
fi

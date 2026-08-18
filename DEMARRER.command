#!/bin/bash
# Double-clique ce fichier pour lancer Le Face-à-Face.
# Il ouvre le Terminal, prépare tout et affiche le simulateur dans ton navigateur.

cd "$(dirname "$0")" || exit 1

echo ""
echo "  ┌────────────────────────────────────────────┐"
echo "  │   Témoin — démarrage                       │"
echo "  └────────────────────────────────────────────┘"
echo ""

# --- Node est-il installé ? ---
if ! command -v npm >/dev/null 2>&1; then
  echo "  ✋ Node.js n'est pas installé sur cet ordinateur."
  echo ""
  echo "     Va sur  https://nodejs.org  et télécharge la version LTS"
  echo "     (le gros bouton de gauche). Installe-la, puis reviens"
  echo "     double-cliquer sur ce fichier."
  echo ""
  read -n 1 -s -r -p "  Appuie sur une touche pour fermer."
  echo ""
  exit 1
fi

# --- La clé est-elle renseignée ? ---
if ! grep -qE '(AQ\.[A-Za-z0-9._-]{20,}|AIza[A-Za-z0-9_-]{20,})' cle-api.txt 2>/dev/null; then
  echo "  ✋ Aucune clé trouvée dans cle-api.txt"
  echo ""
  echo "     Ouvre le fichier « cle-api.txt » (dans ce dossier),"
  echo "     colle ta clé Gemini en bas, enregistre, puis reviens ici."
  echo ""
  echo "     Ta clé se récupère sur https://aistudio.google.com/apikey"
  echo ""
  read -n 1 -s -r -p "  Appuie sur une touche pour fermer."
  echo ""
  exit 1
fi

# --- Dépendances (uniquement la première fois) ---
if [ ! -d node_modules ]; then
  echo "  ⏳ Première installation, ça prend une minute..."
  echo ""
  npm install --silent || { echo ""; echo "  ✋ L'installation a échoué."; read -n 1 -s -r -p "  Appuie sur une touche."; exit 1; }
  echo ""
  echo "  ✅ Installation terminée."
  echo ""
fi

# --- Ouvre le navigateur dès que le serveur répond ---
(
  for _ in $(seq 1 40); do
    if curl -s -o /dev/null http://localhost:3000/ 2>/dev/null; then
      open http://localhost:3000
      exit 0
    fi
    sleep 0.5
  done
) &

echo "  ▶︎  Le simulateur va s'ouvrir dans ton navigateur."
echo ""
echo "      Laisse CETTE fenêtre ouverte pendant que tu l'utilises."
echo "      Pour tout arrêter : ferme-la, ou appuie sur Ctrl et C."
echo ""

npm start

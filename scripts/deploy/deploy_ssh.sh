#!/bin/bash
set -e

DEST="$HOME/.ssh/id_ed25519"
SRC="$HOME/dotfiles/secrets/id_ed25519.age"

if [[ -f "$DEST" ]]; then
    echo "SSH Key already present: $DEST"
    exit 0
fi

echo "Decrypting SSH Key..."
mkdir -p ~/.ssh
age -d "$SRC" > "$DEST"
chmod 600 "$DEST"
cp "$HOME/dotfiles/secrets/id_ed25519.pub" "$HOME/.ssh/id_ed25519.pub"
chmod 644 "$HOME/.ssh/id_ed25519.pub"
echo "✅ SSH Key decrypted and copied."

if ssh-add -l >/dev/null 2>&1; then
    ssh-add "$DEST" && echo "🔑 SSH Key added to agent."
else
    echo "⚠️ No SSH Agent found."
fi

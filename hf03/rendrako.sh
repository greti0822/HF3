!/bin/bash

# Bemenet ellenőrzése (Kész, ha...)
if [ -z "$1" ] || [ ! -d "$1" ]; then
    echo "Hiba: A megadott könyvtár nem létezik vagy hiányzik!" >&2
    exit 1
fi

TARGET_DIR="$1"
RENDEZD=false

if [ "$2" == "--rendezd" ]; then
    RENDEZD=true
fi

if [ "$RENDEZD" = true ]; then
    echo "Rendrakás mód aktív (--rendezd)."
    echo "--------------------------------------------------"
fi

# --- 1. RÉSZ: JELENTÉS ---
echo "=== JELENTÉS: $TARGET_DIR ==="

file_count=$(find "$TARGET_DIR" -type f | wc -l)
dir_count=$(find "$TARGET_DIR" -type d -mindepth 1 | wc -l)
echo "Fájlok száma: $file_count, Könyvtárak száma: $dir_count"

echo ""
echo "Az 5 legnagyobb fájl:"
find "$TARGET_DIR" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -5

old_files_count=$(find "$TARGET_DIR" -type f -mtime +30 | wc -l)
echo ""
echo "30 napnál régebben módosított fájlok száma: $old_files_count"

echo ""
echo "Üres fájlok listája:"
find "$TARGET_DIR" -type f -empty

echo ""
echo "Kiterjesztés-statisztika:"
find "$TARGET_DIR" -type f | sed -n 's/.*\././p' | sort | uniq -c | sort -rn

echo ""
echo "Mindenki számára írható fájlok:"
find "$TARGET_DIR" -type f -perm -o+w

# --- 2. RÉSZ: RENDRAKÁS ---
if [ "$RENDEZD" = true ]; then
    echo ""
    echo "=== RENDRAKÁS FOLYAMATBAN ==="
    
    BASE_RENDEZETT="$TARGET_DIR/_rendezett"
    
    find "$TARGET_DIR" -type f -print0 | while IFS= read -r -d '' f; do
        if [[ "$f" == *"/_rendezett/"* ]]; then
            continue
        fi

        filename=$(basename -- "$f")
        if [[ "$filename" == *.* ]]; then
            ext="${filename##*.}"
            dest_dir="$BASE_RENDEZETT/$ext"
        else
            dest_dir="$BASE_RENDEZETT/_egyeb"
        fi

        mkdir -p "$dest_dir"
        cp "$f" "$dest_dir/"

        if [ -w "$f" ] && [ -n "$(find "$f" -perm -o+w)" ]; then
            echo "Jogosultság elvétele (o-w): $f"
            chmod o-w "$f"
        fi
    done
    echo "Rendrakás kész!"
fi
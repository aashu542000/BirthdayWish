#!/bin/bash
# Renames every photo in this folder to photo1, photo2, photo3 ... (sorted by name)
cd "$(dirname "$0")" || exit 1
shopt -s nullglob nocaseglob
files=( *.jpg *.jpeg *.png *.webp )
[ ${#files[@]} -eq 0 ] && { echo "No photos found."; exit 0; }
IFS=$'\n' files=( $(printf '%s\n' "${files[@]}" | sort -V) ); unset IFS
i=0
for f in "${files[@]}"; do i=$((i+1)); mv -- "$f" ".tmp_rename_$i.${f##*.}"; done
i=0
for f in "${files[@]}"; do
  i=$((i+1)); ext=$(echo "${f##*.}" | tr '[:upper:]' '[:lower:]')
  mv -- ".tmp_rename_$i.${f##*.}" "photo$i.$ext"
done
echo "Done! Renamed $i photos to photo1 ... photo$i"

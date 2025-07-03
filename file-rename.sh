#!/bin/bash

target_dir="$1"

if [ -z "$target_dir" ]; then
  echo "Usage: $0 /path/to/video_folder"
  exit 1
fi

# Expand ~
target_dir="${target_dir/#\~/$HOME}"

if [ ! -d "$target_dir" ]; then
  echo "Directory not found: $target_dir"
  exit 1
fi

cd "$target_dir" || exit 1

for file in *; do
  [ -f "$file" ] || continue
  original="$file"

  # Remove unwanted characters ' and ,
  newname=$(echo "$file" | tr -d "',")

  # Pad Day-N to Day-0N
  if echo "$newname" | grep -qE 'Day-[0-9]+-?\([^)]*\)-?'; then
    day_num=$(echo "$newname" | sed -nE 's/.*Day-([0-9]+)-?\([^)]*\)-?.*/\1/p')
    padded_day=$(printf "%02d" "$day_num")
    newname=$(echo "$newname" | sed -E "s/Day-[0-9]+/Day-$padded_day/")
  fi

  # Ensure there's a hyphen after the closing parenthesis ')'
  newname=$(echo "$newname" | sed -E 's/\)([^-])/\)-\1/')

  # Extract prefix (e.g., Day-16(9-2-2025)-)
  prefix=$(echo "$newname" | grep -oE '^Day-[0-9]+-?\([^)]*\)-?')

  if [[ "$newname" == "$prefix"* ]]; then
    suffix="${newname:${#prefix}}"
  else
    suffix="$newname"
  fi

  # Replace spaces/underscores with -, clean up -
  cleaned_suffix=$(echo "$suffix" | sed -E 's/[ _]+/-/g' | sed -E 's/-+/-/g' | sed -E 's/^-+//' | sed -E 's/-+$//')

  # Final new name
  newname="${prefix}${cleaned_suffix}"

  if [ "$original" != "$newname" ]; then
    mv -v -- "$original" "$newname"
  fi
done

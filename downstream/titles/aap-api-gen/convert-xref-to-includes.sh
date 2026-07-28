#!/bin/bash

# Recursively find all .adoc files in build/ directory and nested directories, excluding top-level index.adoc
find build/ -type f -name "*.adoc" | while read -r file; do
  # Use temporary file for safe in-place editing
  tmpfile=$(mktemp)

  while IFS= read -r line; do
    if [[ "$line" == *xref:* ]]; then
      # Replace 'xref:' with 'include::' and append '[leveloffset=+1]' on the same line
      new_line="${line/xref:/include::}"
      echo "$new_line[leveloffset=+1]" >> "$tmpfile"
    else
      echo "$line" >> "$tmpfile"
    fi
  done < "$file"

  # Replace the original file with the modified content
  mv "$tmpfile" "$file"
done
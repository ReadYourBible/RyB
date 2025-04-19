find kjv -maxdepth 1 -type d | while read path; do
  name=$(basename "$path")
  dir=$(dirname "$path")

  case "$name" in
    *-iii-*) newname=$(echo "$name" | sed 's/-iii-/-3-/') ;;
    *-ii-*)  newname=$(echo "$name" | sed 's/-ii-/-2-/') ;;
    *-i-*)   newname=$(echo "$name" | sed 's/-i-/-1-/') ;;
    *) continue ;;
  esac

  newpath="$dir/$newname"
  if [ "$path" != "$newpath" ]; then
    echo "📁 Renaming: $path → $newpath"
    mv "$path" "$newpath"
  fi
done


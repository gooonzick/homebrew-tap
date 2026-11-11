#!/usr/bin/env bash
# Points each cask at its app's latest GitHub release: version and sha256 of the macOS zip.
# Usage: scripts/bump.sh [cask...]   (default: every cask in Casks/)
set -euo pipefail
cd "$(dirname "$0")/.."

casks=("$@")
[[ ${#casks[@]} -eq 0 ]] && casks=($(ls Casks | sed 's/\.rb$//'))

for cask in "${casks[@]}"; do
  file="Casks/$cask.rb"
  repo="$(sed -n 's#.*homepage "https://github.com/\(.*\)"#\1#p' "$file")"
  tag="$(gh release view --repo "$repo" --json tagName --jq .tagName)"
  version="${tag#v}"
  current="$(sed -n 's/^  version "\(.*\)"/\1/p' "$file")"
  if [[ "$version" == "$current" ]]; then
    echo "$cask: $version is current"
    continue
  fi
  zip="$cask-$version-macos-arm64.zip"
  sha="$(gh release download "$tag" --repo "$repo" --pattern SHA256SUMS --output - | awk -v f="$zip" '$2 == f || $2 == "*"f {print $1}')"
  [[ -n "$sha" ]] || { echo "$cask: no checksum for $zip in $tag" >&2; exit 1; }
  sed -i.bak -e "s/^  version \".*\"/  version \"$version\"/" -e "s/^  sha256 \".*\"/  sha256 \"$sha\"/" "$file"
  rm -f "$file.bak"
  echo "$cask: $current -> $version"
done

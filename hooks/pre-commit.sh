#!/bin/bash

# get current version
## first go to then to apps/main directory,
cd apps/main_app
version=$(grep "version: " pubspec.yaml | cut -d' ' -f2)

# increment version
major=$(echo $version | cut -d'.' -f1)
minor=$(echo $version | cut -d'.' -f2)
patch=$(echo $version | cut -d'.' -f3)
patch=$((patch+1))
new_version="$major.$minor.$patch+$(date +%s)"

# replace version in pubspec.yaml
sed -i "s/version: $version/version: $new_version/" pubspec.yaml

# commit
git add pubspec.yaml


# Get current msix_version
msix_version=$(awk '/msix_version:/ {print $2}' pubspec.yaml)

# Increment the third number
IFS='.' read -ra version_parts <<< "$msix_version"
version_parts[2]=$((version_parts[2]+1))
version_parts[3]=0  # Set the last number to zero
new_msix_version="${version_parts[0]}.${version_parts[1]}.${version_parts[2]}.${version_parts[3]}"

# Replace msix_version in pubspec.yaml
sed -i "s/msix_version: $msix_version/msix_version: $new_msix_version/" pubspec.yaml

# Commit
git add pubspec.yaml

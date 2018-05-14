#! /bin/bash

VERSION=$1

if [[ -z $VERSION ]]
then
  echo "ERROR: version number *must* be given."
  echo "Current tags:"
  git tag | cat
  exit 1
fi

if [[ -n $(git status --porcelain) ]]
then
  echo "ERROR: cannot version bump a dirty working directory. Please commit your changes or clean the directory."
  exit 1
fi

sed -i "s/VERSION:\s*[0-9\.]\+/VERSION: $VERSION/" run
./run -m > README.md
git add run README.md
git commit -m "version bump: $VERSION"
git tag $VERSION

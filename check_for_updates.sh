#!/bin/bash

echo "Checking for updates..."

NEW_VERSION=$(cat Sources/OpenAPI/app_store_connect_api.json | jq -r '.info.version')
CURRENT_VERSION=$(cat spec-version)
REMOTE_BRANCH=$(git ls-remote origin refs/heads/spec-update-$NEW_VERSION)

echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"
echo "Remote branch: $REMOTE_BRANCH"
if [ "$NEW_VERSION" == "$CURRENT_VERSION" ] || [ ! -z $REMOTE_BRANCH ] ; then
    echo "Spec version is up to date"
    exit 0
fi

echo $NEW_VERSION > spec-version

make update

git config --local user.name "App Store Connect Swift SDK CI"
git switch --create spec-update-$NEW_VERSION
git add --all
git commit -m "[ci skip] Update spec to $NEW_VERSION"
# git push origin spec-update-$NEW_VERSION
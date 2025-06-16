#!/bin/bash

echo "Checking for updates..."

CURRENT_VERSION=$(cat Sources/OpenAPI/app_store_connect_api.json | jq -r '.info.version')

make download

NEW_VERSION=$(cat Sources/OpenAPI/app_store_connect_api.json | jq -r '.info.version')
REMOTE_BRANCH=$(git ls-remote origin refs/heads/spec-update-$NEW_VERSION)

echo "Current version: $CURRENT_VERSION"
echo "New version: $NEW_VERSION"
echo "Remote branch: $REMOTE_BRANCH"
if [ "$NEW_VERSION" == "$CURRENT_VERSION" ] || [ ! -z $REMOTE_BRANCH ] ; then
    echo "Spec version is up to date"
    exit 0
fi

make generate

git config --local user.name "App Store Connect Swift SDK CI"
git switch --create spec-update-$NEW_VERSION
git add --all
git commit -m "Update spec to $NEW_VERSION"
git push -u origin spec-update-$NEW_VERSION
create_pr_output=$(gh pr create --title "Update OpenAPI spec to $NEW_VERSION" --body "$warnings")
echo "Pull request created: $create_pr_output"
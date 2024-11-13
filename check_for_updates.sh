#!/bin/bash


NEW_VERSION=$(cat Sources/OpenAPI/app_store_connect_api.json | jq -r '.info.version')
CURRENT_VERSION=$(cat spec-version)
REMOTE_BRANCH=$(git ls-remote origin refs/heads/spec-update-$NEW_VERSION)
if [ "$NEW_VERSION" == "$CURRENT_VERSION" ] || [ ! -z $REMOTE_BRANCH ] ; then
    echo "Spec version is up to date"
    exit 0
fi

echo $NEW_VERSION > spec-version
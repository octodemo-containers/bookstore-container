#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
    echo "[ERROR] Missing patch set name argument"
    exit 1
fi

PATCH_SET_NAME=$1
if [[ -d "$DIR/$PATCH_SET_NAME" ]]; then
    feature_branch_name="feature-$PATCH_SET_NAME"
    feature_pack_tarball=$DIR/$PATCH_SET_NAME/patches.tgz

    if [[ ! -f "$feature_pack_tarball" ]]; then
        echo "[ERROR] no patch set tarball found for '$PATCH_SET_NAME' at location '$feature_pack_tarball'"
        exit 2
    fi
else
    echo "[ERROR] Failed to resolve patch set: '$PATCH_SET_NAME'"
    exit 1
fi


current_branch=`git branch`
echo "Current Branch: $current_branch"

echo "Creating new feature branch: $feature_branch_name"
git checkout -b $feature_branch_name

echo "Applying code changes..."
pushd $DIR/..
tar -xvf $feature_pack_tarball --strip 1
popd

echo "Completed."
#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -z "$1" ]; then
    echo "[ERROR] Missing patch set name argument"
    exit 1
fi

PATCH_SET_NAME=$1
if [[ -d "$DIR/$PATCH_SET_NAME" ]]; then
    feature_pack_dir=$DIR/$PATCH_SET_NAME
    feature_pack_tarball=$feature_pack_dir/patches.tgz
else
    echo "[ERROR] Failed to resolve patch set: '$PATCH_SET_NAME'"
    exit 1
fi

echo "Creating new patch set"

pushd $feature_pack_dir
tar -cvf "$feature_pack_tarball" files/
popd

echo "Completed."
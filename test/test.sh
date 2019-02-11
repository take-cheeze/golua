#!/usr/bin/env bash
set -euxo pipefail

root_dir="$(cd "${BASH_SOURCE[0]%/*}/.." && pwd)"
cd "$root_dir"

COMPAT_LUA_VERSION=5.3.4

if [ $(uname -s) = 'Linux' ] ; then
    wget --continue "https://www.lua.org/ftp/lua-${COMPAT_LUA_VERSION}.tar.gz"
    tar xf lua-${COMPAT_LUA_VERSION}.tar.gz
    pushd lua-${COMPAT_LUA_VERSION}
    make -j$(nproc) linux
    popd
    export PATH="$root_dir/lua-${COMPAT_LUA_VERSION}/src:$PATH"
fi

go install github.com/Azure/golua/cmd/glua

cd "test/lua-$COMPAT_LUA_VERSION"
glua -tests all.lua | grep -q OK

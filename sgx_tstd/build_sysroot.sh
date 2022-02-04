#!/bin/sh

set -e

SYSROOT_PATH="${1:-$(realpath ../../sysroot)}"
export CARGO_BUILD_TARGET="${CARGO_BUILD_TARGET:-$(rustc -vV | sed -n 's|host: ||p')}"
RUSTUP_TOOLCHAIN="${RUSTUP_TOOLCHAIN:-$(rustup show active-toolchain | cut -d' ' -f1)}"

cargo clean --target "$CARGO_BUILD_TARGET"
cargo build --release -Z build-std=core,alloc --features net,untrusted_time,untrusted_fs,thread,backtrace

mkdir -p "$SYSROOT_PATH/lib/rustlib/$CARGO_BUILD_TARGET"
rm -Rf "$SYSROOT_PATH/lib/rustlib/$CARGO_BUILD_TARGET/lib"
cp -R "$PWD/target/$CARGO_BUILD_TARGET/release/deps" "$SYSROOT_PATH/lib/rustlib/$CARGO_BUILD_TARGET/lib"

echo "Here's your environment:"
echo RUSTFLAGS=\"--sysroot $SYSROOT_PATH\" CARGO_BUILD_TARGET=\"$CARGO_BUILD_TARGET\" RUSTUP_TOOLCHAIN=\"$RUSTUP_TOOLCHAIN\"

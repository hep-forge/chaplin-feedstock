#! /usr/bin/bash
set -e

# Bundled config.sub/config.guess predate aarch64 (linux-arm64 and
# macos-arm64) triplets -- "config.sub aarch64-conda-linux-gnu failed" /
# "arm64-apple-darwin ... not recognized". Replace with the current ones
# from the gnuconfig package before configuring.
for f in config.sub config.guess; do
  find . -name "$f" -exec cp "$BUILD_PREFIX/share/gnuconfig/$f" {} \;
done

./configure --prefix=$PREFIX

make -j$(nproc)
make install

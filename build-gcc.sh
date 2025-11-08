#!/bin/zsh
export PREFIX="$HOME/.bin/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH

cd build-gcc
./contrib/download_prerequisites
../gcc-13.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++,fortran,go,d,objc,obj-c++ --without-headers
make -j12 all-gcc
make -j12 all-target-libgcc
make install-gcc
make install-target-libgcc

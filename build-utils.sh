export PREFIX="$HOME/.bin/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

cd build-binutils
../binutils-2.42/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make -j12
make install

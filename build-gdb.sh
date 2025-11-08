export PREFIX="$HOME/.bin/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

cd build-gdb
../gdb-15.2/configure --target=$TARGET --prefix="$PREFIX" --disable-werror
make -j12 all-gdb
make install-gdb
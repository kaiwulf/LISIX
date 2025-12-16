#!/bin/sh
# autogen.sh - Bootstrap the autotools build system

set -e

echo "Bootstrapping autotools build system..."

# Create m4 directory if it doesn't exist
mkdir -p m4

# Run autotools in order
echo "Running aclocal..."
aclocal -I m4

echo "Running autoconf..."
autoconf

echo "Running automake..."
automake --add-missing --copy --foreign

echo ""
echo "Bootstrap complete. You can now run:"
echo "  ./configure --host=i686-elf"
echo "  make"
echo ""

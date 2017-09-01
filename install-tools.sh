#!/bin/bash

# set up the PATH
mkdir -p $HOME/os161
mkdir -p $HOME/os161/toolbuild
mkdir -p $HOME/os161/tools
mkdir -p $HOME/os161/tools/bin
export PATH=$HOME/os161/tools/bin:$PATH

cd $HOME/os161/toolbuild

# Download, build and install binutils 
wget http://www.eecs.harvard.edu/~dholland/os161/download/binutils-2.24+os161-2.1.tar.gz
tar -zxf binutils-2.24+os161-2.1.tar.gz

cd binutils-2.24+os161-2.1
find . -name '*.info' | xargs touch
touch intl/plural.c
cd ..

cd binutils-2.24+os161-2.1
./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=$HOME/os161/tools
make
make install
cd ..

# Download, build, and install GCC-4.8
wget http://www.eecs.harvard.edu/~dholland/os161/download/gcc-4.8.3+os161-2.1.tar.gz
tar -zxf gcc-4.8.3+os161-2.1.tar.gz
cd gcc-4.8.3+os161-2.1

find . -name '*.info' | xargs touch
touch intl/plural.c
cd ..

mkdir buildgcc
cd buildgcc
../gcc-4.8.3+os161-2.1/configure \
	--enable-languages=c,lto \
	--nfp --disable-shared --disable-threads \
	--disable-libmudflap --disable-libssp \
	--disable-libstdcxx --disable-nls \
	--target=mips-harvard-os161 \
	--prefix=$HOME/os161/tools
cd ..

# Once configuration succeeds, compile and install gcc.
cd buildgcc
make
make install
cd ..

# Download, build, and install gdb 7.8
wget http://www.eecs.harvard.edu/~dholland/os161/download/gdb-7.8+os161-2.1.tar.gz
tar -zxf gdb-7.8+os161-2.1.tar.gz

cd gdb-7.8+os161-2.1
find . -name '*.info' | xargs touch
touch intl/plural.c
cd ..

cd gdb-7.8+os161-2.1
CC="gcc -std=gnu89" ./configure --target=mips-harvard-os161 --prefix=$HOME/os161/tools
make
make install
cd ..


# Download, build, and install the simulator sys161-2.0.8 
wget http://www.eecs.harvard.edu/~dholland/os161/download/sys161-2.0.8.tar.gz
tar -zxf sys161-2.0.8.tar.gz

cd sys161-2.0.8
./configure --prefix=$HOME/os161/tools mipseb
make
make install
cd ..

# Download, build, and install the simulator sys161-2.0.8 
# Important note: mk.tar.gz needs to be unpacked inside bmake. (Don't blame me! I didn't set it up that way.)

wget http://www.eecs.harvard.edu/~dholland/os161/download/bmake-20101215.tar.gz
wget http://www.eecs.harvard.edu/~dholland/os161/download/mk-20100612.tar.gz
tar -zxf bmake-20101215.tar.gz
cd bmake
tar -zxf ../mk-20100612.tar.gz
cd ..

cd bmake
./configure --prefix=$HOME/os161/tools --with-default-sys-path=$HOME/os161/tools/share/mk
sh ./make-bootstrap.sh
mkdir -p $HOME/os161/tools/bin
mkdir -p $HOME/os161/tools/share/man/man1
mkdir -p $HOME/os161/tools/share/mk
cp bmake $HOME/os161/tools/bin/
cp bmake.1 $HOME/os161/tools/share/man/man1/
sh mk/install-mk $HOME/os161/tools/share/mk
cd ..

# create symlinks for very long command names
cd $HOME/os161/tools/bin
sh -c 'for f in mips-harvard-*; do nf=`echo $f | sed -e s/mips-harvard-//`; ln -s $f $nf ; done'

echo "Tools are installed here: $HOME/os161/tools/bin. You need to include it in your path."

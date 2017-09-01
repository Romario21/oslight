#!/bin/bash

export PATH=$HOME/os161/tools/bin:$PATH
mkdir -p $HOME/os161/root

# make sure $HOME/os161/src pints to your os161 source code tree
# mv <path-to-oslight-source-tree> $HOME/os161/src
# cd $HOME/os161/src

# configure userland tools
./configure --ostree=$HOME/os161/root

# uncomment the following if you need to update the includes and dependencies
#bmake includes
#bmake depend
bmake
bmake install

# configure kernel with the sample DUMBVM configuration
cd kern/conf/
./config DUMBVM

# compile kernel with the DUMBVM configuration
cd ../compile/DUMBVM
bmake depend
bmake 
bmake install

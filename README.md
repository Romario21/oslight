1. These tools (gmp, mpfr, libmpc, and ncurses) are needed for GCC and GDB installation. On rpm systems such as CentOS, you can run this command as root
# yum install gmp-devel mpfr-devel libmpc-devel ncurses-devel 

2. On dpkg systems such as Ubuntu, you can run this command as root
# apt-get install libgmp-dev libmpfr-dev libmpc-dev libncurses-dev

3. Run the following two commands for the installation of tools and kernel
# cd {path-to-your-oslight}; ./install-tools.sh
# cd {path-to-your-oslight}; ./install-os161.sh

3. After the installation of tools and kernel, create a sample sys161.conf configration file
# cd ${HOME}/os161/root/
# cp {path-to-your-sys161-2.0.8}/sys161.conf.sample sys161.conf

4. You may look into sys161.conf for possible modification. The default is fine for now.

5. Create two disk files of 5MB each
# disk161 create LHD0.img 5M
# disk161 create LHD1.img 5M

6. start this command from one shell
# cd ${HOME}/os161/root/;  sys161 -w kernel

7. Run os161-gdb from another shell
# cd ${HOME}/os161/root/;  os161-gdb kernel

8. Type the following command to attach to the kernel
# target remote unix:.sockets/gdb
#!/bin/bash

export ARCH=arm64
export SUBARCH=arm64
export CLANG_PATH=/home/praveen/toolchain/clang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
#export CONFIG=sprd_sharkl5Pro_defconfig
export CONFIG=mmx_defconfig

echo "#"
echo "#    display clang-version"
clang --version
echo "#"

make O=out $CONFIG;
make O=out CC=clang AS=llvm-as NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf HOSTAS=llvm-as CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabi- menuconfig
cp -rf out/.config arch/arm64/configs/$CONFIG;

echo "#"
echo "# Compile Kernel"
echo "#"

echo "#"
echo "#    display clang-version"
clang --version
echo "#"

make O=out CC=clang $CONFIG;
time make -j$(nproc --all) O=out CC=clang LD=ld.lld LTO=thin AS=llvm-as NM=llvm-nm STRIP=llvm-strip OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf HOSTAS=llvm-as CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_COMPAT=arm-linux-gnueabi-
echo -e "\033[1;36mPress enter to continue \e[0m"
read a1






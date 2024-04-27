printf "\x1bc\x1b[43;37m "
nasm -o /tmp/boot.bin boot.asm
/usr/bin/qemu-system-x86_64 -boot a -fda boot.bin

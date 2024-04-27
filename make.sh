printf "\x1bc\x1b[43;37m "
nasm -o /tmp/boot.bin boot.asm
nasm -o /tmp/hello.com program.asm
dd if=/tmp/hello.com of=/tmp/boot.bin seek=1 conv=notrunc
cp -f /tmp/boot.bin ./
/usr/bin/qemu-system-x86_64 -boot a -fda boot.bin
